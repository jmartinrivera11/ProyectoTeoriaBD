#include "MetaAhorroWidget.h"

#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QLabel>
#include <QComboBox>
#include <QTableWidget>
#include <QHeaderView>
#include <QPushButton>
#include <QMessageBox>
#include <QInputDialog>
#include <QSqlQuery>
#include <QUuid>

#include "../../../backend/src/database/DBManager.h"
#include "../../../backend/src/dao/UsuarioDAO.h"
#include "../../../backend/src/dao/MetaAhorroDAO.h"
#include "MetaAhorroDialog.h"

MetaAhorroWidget::MetaAhorroWidget(QWidget* parent)
    : QWidget(parent)
{
    m_cmbUsuario = new QComboBox(this);
    connect(m_cmbUsuario, &QComboBox::currentIndexChanged, this, &MetaAhorroWidget::onUsuarioChanged);

    auto* top = new QHBoxLayout;
    top->addWidget(new QLabel("Usuario:", this));
    top->addWidget(m_cmbUsuario, 1);

    m_tbl = new QTableWidget(this);
    m_tbl->setColumnCount(9);
    m_tbl->setHorizontalHeaderLabels({
        "Id_meta", "Subcategoría", "Nombre", "Monto total", "Monto ahorrado",
        "Inicio", "Objetivo", "Prioridad", "Estado"
    });
    m_tbl->horizontalHeader()->setStretchLastSection(true);
    m_tbl->setSelectionBehavior(QAbstractItemView::SelectRows);
    m_tbl->setSelectionMode(QAbstractItemView::SingleSelection);
    m_tbl->setEditTriggers(QAbstractItemView::NoEditTriggers);

    m_btnRef = new QPushButton("Refrescar", this);
    m_btnNuevo = new QPushButton("Nuevo", this);
    m_btnEditar = new QPushButton("Editar", this);
    m_btnEliminar = new QPushButton("Eliminar", this);
    m_btnAportar = new QPushButton("Aportar", this);

    connect(m_btnRef, &QPushButton::clicked, this, &MetaAhorroWidget::refrescarMetas);
    connect(m_btnNuevo, &QPushButton::clicked, this, &MetaAhorroWidget::onNuevo);
    connect(m_btnEditar, &QPushButton::clicked, this, &MetaAhorroWidget::onEditar);
    connect(m_btnEliminar, &QPushButton::clicked, this, &MetaAhorroWidget::onEliminar);
    connect(m_btnAportar, &QPushButton::clicked, this, &MetaAhorroWidget::onAportar);

    auto* bar = new QHBoxLayout;
    bar->addWidget(m_btnRef);
    bar->addStretch();
    bar->addWidget(m_btnNuevo);
    bar->addWidget(m_btnEditar);
    bar->addWidget(m_btnEliminar);
    bar->addWidget(m_btnAportar);

    auto* root = new QVBoxLayout(this);
    root->addLayout(top);
    root->addLayout(bar);
    root->addWidget(m_tbl);
    setLayout(root);

    refrescarUsuarios();
}

void MetaAhorroWidget::refrescarUsuarios()
{
    auto db = DatabaseManager::instance().database();
    UsuarioDAO dao(db);

    QString err;
    auto usuarios = dao.obtenerTodos(&err);
    if (!err.isEmpty()) {
        QMessageBox::critical(this, "BD", "Error cargando usuarios:\n" + err);
        return;
    }

    m_cmbUsuario->clear();
    for (const auto& u : usuarios) {
        QString label = u.nombre + " " + u.apellido + " (" + u.correo + ")";
        m_cmbUsuario->addItem(label, u.id_usuario);
    }

    refrescarMetas();
}

void MetaAhorroWidget::onUsuarioChanged()
{
    refrescarMetas();
}

QString MetaAhorroWidget::selectedMetaId() const
{
    auto ranges = m_tbl->selectedRanges();
    if (ranges.isEmpty()) return {};
    int row = ranges.first().topRow();
    auto* item = m_tbl->item(row, 0);
    return item ? item->text() : QString();
}

QList<QPair<QString, QString>> MetaAhorroWidget::cargarSubcategorias()
{
    QList<QPair<QString, QString>> items;
    auto db = DatabaseManager::instance().database();

    QSqlQuery q(db);
    if (!q.exec("SELECT Id_subcategoria, nombre FROM Subcategoria ORDER BY nombre")) {
        return items;
    }
    while (q.next()) {
        items.append({ q.value(0).toString(), q.value(1).toString() });
    }
    return items;
}

void MetaAhorroWidget::refrescarMetas()
{
    m_tbl->setRowCount(0);
    if (m_cmbUsuario->currentIndex() < 0) return;

    QString idUsuario = m_cmbUsuario->currentData().toString();

    auto db = DatabaseManager::instance().database();
    MetaAhorroDAO dao(db);

    QString err;
    auto metas = dao.obtenerPorUsuario(idUsuario, &err);
    if (!err.isEmpty()) {
        QMessageBox::critical(this, "BD", "Error cargando metas:\n" + err);
        return;
    }

    for (const auto& m : metas) {
        int r = m_tbl->rowCount();
        m_tbl->insertRow(r);

        m_tbl->setItem(r, 0, new QTableWidgetItem(m.id_meta_ahorro));
        m_tbl->setItem(r, 1, new QTableWidgetItem(m.id_subcategoria));
        m_tbl->setItem(r, 2, new QTableWidgetItem(m.nombre));
        m_tbl->setItem(r, 3, new QTableWidgetItem(QString::number(m.monto_total, 'f', 2)));
        m_tbl->setItem(r, 4, new QTableWidgetItem(QString::number(m.monto_ahorrado, 'f', 2)));
        m_tbl->setItem(r, 5, new QTableWidgetItem(m.fecha_inicio.isValid() ? m.fecha_inicio.toString("yyyy-MM-dd") : ""));
        m_tbl->setItem(r, 6, new QTableWidgetItem(m.fecha_objetivo.isValid() ? m.fecha_objetivo.toString("yyyy-MM-dd") : ""));
        m_tbl->setItem(r, 7, new QTableWidgetItem(m.prioridad));
        m_tbl->setItem(r, 8, new QTableWidgetItem(m.estado));
    }

    m_tbl->resizeColumnsToContents();
}

void MetaAhorroWidget::onNuevo()
{
    if (m_cmbUsuario->currentIndex() < 0) {
        QMessageBox::information(this, "Metas", "Selecciona un usuario.");
        return;
    }

    auto subs = cargarSubcategorias();
    if (subs.isEmpty()) {
        QMessageBox::information(this, "Metas", "No hay subcategorías. Crea subcategorías primero.");
        return;
    }

    QString idUsuario = m_cmbUsuario->currentData().toString();

    MetaAhorroDialog dlg(this);
    dlg.setIdUsuario(idUsuario);
    dlg.setSubcategorias(subs);

    if (dlg.exec() != QDialog::Accepted) return;

    auto m = dlg.meta();
    if (m.id_subcategoria.isEmpty() || m.nombre.isEmpty()) {
        QMessageBox::warning(this, "Validación", "Subcategoría y nombre son obligatorios.");
        return;
    }
    if (m.monto_total <= 0.0) {
        QMessageBox::warning(this, "Validación", "Monto total debe ser mayor a 0.");
        return;
    }

    m.id_meta_ahorro = QUuid::createUuid().toString(QUuid::WithoutBraces);
    m.monto_ahorrado = 0.0;
    m.creado_por = "app";

    auto db = DatabaseManager::instance().database();
    MetaAhorroDAO dao(db);

    QString err;
    if (!dao.insertar(m, &err)) {
        QMessageBox::critical(this, "BD", "No se pudo insertar:\n" + err);
        return;
    }

    refrescarMetas();
}

void MetaAhorroWidget::onEditar()
{
    QString id = selectedMetaId();
    if (id.isEmpty()) {
        QMessageBox::information(this, "Metas", "Selecciona una meta.");
        return;
    }

    auto subs = cargarSubcategorias();

    auto db = DatabaseManager::instance().database();
    MetaAhorroDAO dao(db);

    QString err;
    auto opt = dao.obtenerPorId(id, &err);
    if (!err.isEmpty()) {
        QMessageBox::critical(this, "BD", "Error consultando:\n" + err);
        return;
    }
    if (!opt) {
        QMessageBox::information(this, "Metas", "La meta ya no existe.");
        refrescarMetas();
        return;
    }

    MetaAhorroDialog dlg(this);
    dlg.setSubcategorias(subs);
    dlg.setMeta(*opt);

    if (dlg.exec() != QDialog::Accepted) return;

    auto m = dlg.meta();
    if (m.id_subcategoria.isEmpty() || m.nombre.isEmpty()) {
        QMessageBox::warning(this, "Validación", "Subcategoría y nombre son obligatorios.");
        return;
    }
    if (m.monto_total <= 0.0) {
        QMessageBox::warning(this, "Validación", "Monto total debe ser mayor a 0.");
        return;
    }

    m.modificado_por = "app";

    if (!dao.actualizar(m, &err)) {
        QMessageBox::critical(this, "BD", "No se pudo actualizar:\n" + err);
        return;
    }

    refrescarMetas();
}

void MetaAhorroWidget::onEliminar()
{
    QString id = selectedMetaId();
    if (id.isEmpty()) {
        QMessageBox::information(this, "Metas", "Selecciona una meta.");
        return;
    }

    if (QMessageBox::question(this, "Eliminar", "¿Eliminar la meta seleccionada?") != QMessageBox::Yes)
        return;

    auto db = DatabaseManager::instance().database();
    MetaAhorroDAO dao(db);

    QString err;
    if (!dao.eliminar(id, &err)) {
        QMessageBox::critical(this, "BD", "No se pudo eliminar:\n" + err);
        return;
    }

    refrescarMetas();
}

void MetaAhorroWidget::onAportar()
{
    QString idMeta = selectedMetaId();
    if (idMeta.isEmpty()) {
        QMessageBox::information(this, "Metas", "Selecciona una meta.");
        return;
    }

    bool ok = false;
    double monto = QInputDialog::getDouble(this, "Aportar", "Monto a aportar:", 0.0, 0.01, 1e12, 2, &ok);
    if (!ok) return;

    auto db = DatabaseManager::instance().database();

    // Nombres de SP esperados:
    // - sp_aplicar_aporte_meta(id_meta, monto, modificado_por)
    // - sp_recalcular_estado_meta(id_meta)
    QSqlQuery q(db);
    q.prepare("EXECUTE PROCEDURE sp_aplicar_aporte_meta(:id, :monto, :who)");
    q.bindValue(":id", idMeta);
    q.bindValue(":monto", monto);
    q.bindValue(":who", "app");

    if (!q.exec()) {
        QMessageBox::critical(this, "BD",
                              "No se pudo aplicar el aporte.\n"
                              "Verifica el nombre/params de sp_aplicar_aporte_meta.\n");
        return;
    }

    QSqlQuery q2(db);
    q2.prepare("EXECUTE PROCEDURE sp_recalcular_estado_meta(:id)");
    q2.bindValue(":id", idMeta);
    q2.exec();

    refrescarMetas();
}
