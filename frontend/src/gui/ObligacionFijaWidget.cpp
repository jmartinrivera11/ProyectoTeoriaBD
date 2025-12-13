#include "ObligacionFijaWidget.h"

#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QLabel>
#include <QComboBox>
#include <QTableWidget>
#include <QHeaderView>
#include <QPushButton>
#include <QMessageBox>
#include <QSqlQuery>
#include <QUuid>

#include "../../../backend/src/database/DBManager.h"
#include "../../../backend/src/dao/UsuarioDAO.h"
#include "../../../backend/src/dao/ObligacionFijaDAO.h"
#include "ObligacionFijaDialog.h"

ObligacionFijaWidget::ObligacionFijaWidget(QWidget* parent)
    : QWidget(parent)
{
    m_cmbUsuario = new QComboBox(this);
    connect(m_cmbUsuario, &QComboBox::currentIndexChanged, this, &ObligacionFijaWidget::onUsuarioChanged);

    auto* top = new QHBoxLayout;
    top->addWidget(new QLabel("Usuario:", this));
    top->addWidget(m_cmbUsuario, 1);

    m_tbl = new QTableWidget(this);
    m_tbl->setColumnCount(9);
    m_tbl->setHorizontalHeaderLabels({
        "Id_obligacion", "Subcategoría", "Nombre", "Monto mensual",
        "Día", "Vigente", "Inicio", "Fin", "Descripción"
    });
    m_tbl->horizontalHeader()->setStretchLastSection(true);
    m_tbl->setSelectionBehavior(QAbstractItemView::SelectRows);
    m_tbl->setSelectionMode(QAbstractItemView::SingleSelection);
    m_tbl->setEditTriggers(QAbstractItemView::NoEditTriggers);

    m_btnRef = new QPushButton("Refrescar", this);
    m_btnNuevo = new QPushButton("Nuevo", this);
    m_btnEditar = new QPushButton("Editar", this);
    m_btnEliminar = new QPushButton("Eliminar", this);

    connect(m_btnRef, &QPushButton::clicked, this, &ObligacionFijaWidget::refrescarObligaciones);
    connect(m_btnNuevo, &QPushButton::clicked, this, &ObligacionFijaWidget::onNuevo);
    connect(m_btnEditar, &QPushButton::clicked, this, &ObligacionFijaWidget::onEditar);
    connect(m_btnEliminar, &QPushButton::clicked, this, &ObligacionFijaWidget::onEliminar);

    auto* bar = new QHBoxLayout;
    bar->addWidget(m_btnRef);
    bar->addStretch();
    bar->addWidget(m_btnNuevo);
    bar->addWidget(m_btnEditar);
    bar->addWidget(m_btnEliminar);

    auto* root = new QVBoxLayout(this);
    root->addLayout(top);
    root->addLayout(bar);
    root->addWidget(m_tbl);
    setLayout(root);

    refrescarUsuarios();
}

void ObligacionFijaWidget::refrescarUsuarios()
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

    refrescarObligaciones();
}

void ObligacionFijaWidget::onUsuarioChanged()
{
    refrescarObligaciones();
}

QString ObligacionFijaWidget::selectedId() const
{
    auto ranges = m_tbl->selectedRanges();
    if (ranges.isEmpty()) return {};
    int row = ranges.first().topRow();
    auto* item = m_tbl->item(row, 0);
    return item ? item->text() : QString();
}

QList<QPair<QString, QString>> ObligacionFijaWidget::cargarSubcategorias()
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

void ObligacionFijaWidget::refrescarObligaciones()
{
    m_tbl->setRowCount(0);
    if (m_cmbUsuario->currentIndex() < 0) return;

    QString idUsuario = m_cmbUsuario->currentData().toString();

    auto db = DatabaseManager::instance().database();
    ObligacionFijaDAO dao(db);

    QString err;
    auto lista = dao.obtenerPorUsuario(idUsuario, &err);
    if (!err.isEmpty()) {
        QMessageBox::critical(this, "BD", "Error cargando obligaciones:\n" + err);
        return;
    }

    for (const auto& o : lista) {
        int r = m_tbl->rowCount();
        m_tbl->insertRow(r);

        m_tbl->setItem(r, 0, new QTableWidgetItem(o.id_obligacion_fija));
        m_tbl->setItem(r, 1, new QTableWidgetItem(o.id_subcategoria));
        m_tbl->setItem(r, 2, new QTableWidgetItem(o.nombre));
        m_tbl->setItem(r, 3, new QTableWidgetItem(QString::number(o.monto_mensual, 'f', 2)));
        m_tbl->setItem(r, 4, new QTableWidgetItem(QString::number(o.dia_mes)));
        m_tbl->setItem(r, 5, new QTableWidgetItem(o.vigente ? "Sí" : "No"));
        m_tbl->setItem(r, 6, new QTableWidgetItem(o.fecha_inicio.isValid() ? o.fecha_inicio.toString("yyyy-MM-dd") : ""));
        m_tbl->setItem(r, 7, new QTableWidgetItem(o.fecha_fin.isValid() ? o.fecha_fin.toString("yyyy-MM-dd") : ""));
        m_tbl->setItem(r, 8, new QTableWidgetItem(o.descripcion));
    }

    m_tbl->resizeColumnsToContents();
}

void ObligacionFijaWidget::onNuevo()
{
    if (m_cmbUsuario->currentIndex() < 0) {
        QMessageBox::information(this, "Obligaciones", "Selecciona un usuario.");
        return;
    }

    auto subs = cargarSubcategorias();
    if (subs.isEmpty()) {
        QMessageBox::information(this, "Obligaciones", "No hay subcategorías. Crea subcategorías primero.");
        return;
    }

    QString idUsuario = m_cmbUsuario->currentData().toString();

    ObligacionFijaDialog dlg(this);
    dlg.setIdUsuario(idUsuario);
    dlg.setSubcategorias(subs);

    if (dlg.exec() != QDialog::Accepted) return;

    auto o = dlg.obligacion();
    if (o.id_subcategoria.isEmpty() || o.nombre.isEmpty()) {
        QMessageBox::warning(this, "Validación", "Subcategoría y nombre son obligatorios.");
        return;
    }
    if (o.monto_mensual <= 0.0) {
        QMessageBox::warning(this, "Validación", "Monto mensual debe ser mayor a 0.");
        return;
    }

    o.id_obligacion_fija = QUuid::createUuid().toString(QUuid::WithoutBraces);
    o.creado_por = "app";

    auto db = DatabaseManager::instance().database();
    ObligacionFijaDAO dao(db);

    QString err;
    if (!dao.insertar(o, &err)) {
        QMessageBox::critical(this, "BD", "No se pudo insertar:\n" + err);
        return;
    }

    refrescarObligaciones();
}

void ObligacionFijaWidget::onEditar()
{
    QString id = selectedId();
    if (id.isEmpty()) {
        QMessageBox::information(this, "Obligaciones", "Selecciona una obligación.");
        return;
    }

    auto subs = cargarSubcategorias();

    auto db = DatabaseManager::instance().database();
    ObligacionFijaDAO dao(db);

    QString err;
    auto opt = dao.obtenerPorId(id, &err);
    if (!err.isEmpty()) {
        QMessageBox::critical(this, "BD", "Error consultando:\n" + err);
        return;
    }
    if (!opt) {
        QMessageBox::information(this, "Obligaciones", "La obligación ya no existe.");
        refrescarObligaciones();
        return;
    }

    ObligacionFijaDialog dlg(this);
    dlg.setSubcategorias(subs);
    dlg.setObligacion(*opt);

    if (dlg.exec() != QDialog::Accepted) return;

    auto o = dlg.obligacion();
    if (o.id_subcategoria.isEmpty() || o.nombre.isEmpty()) {
        QMessageBox::warning(this, "Validación", "Subcategoría y nombre son obligatorios.");
        return;
    }
    if (o.monto_mensual <= 0.0) {
        QMessageBox::warning(this, "Validación", "Monto mensual debe ser mayor a 0.");
        return;
    }

    o.modificado_por = "app";

    if (!dao.actualizar(o, &err)) {
        QMessageBox::critical(this, "BD", "No se pudo actualizar:\n" + err);
        return;
    }

    refrescarObligaciones();
}

void ObligacionFijaWidget::onEliminar()
{
    QString id = selectedId();
    if (id.isEmpty()) {
        QMessageBox::information(this, "Obligaciones", "Selecciona una obligación.");
        return;
    }

    if (QMessageBox::question(this, "Eliminar", "¿Eliminar la obligación seleccionada?") != QMessageBox::Yes)
        return;

    auto db = DatabaseManager::instance().database();
    ObligacionFijaDAO dao(db);

    QString err;
    if (!dao.eliminar(id, &err)) {
        QMessageBox::critical(this, "BD",
                              "No se pudo eliminar.\n"
                              "Si está referenciada por transacciones, elimina esas transacciones primero.\n\n" + err);
        return;
    }

    refrescarObligaciones();
}
