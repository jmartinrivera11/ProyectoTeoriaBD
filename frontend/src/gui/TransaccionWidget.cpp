#include "TransaccionWidget.h"

#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QLabel>
#include <QComboBox>
#include <QTableWidget>
#include <QHeaderView>
#include <QPushButton>
#include <QMessageBox>
#include <QUuid>
#include <QSqlQuery>

#include "../../../backend/src/database/DBManager.h"
#include "../../../backend/src/dao/UsuarioDAO.h"
#include "../../../backend/src/dao/PresupuestoDAO.h"
#include "../../../backend/src/dao/TransaccionDAO.h"

#include "TransaccionDialog.h"

TransaccionWidget::TransaccionWidget(QWidget* parent)
    : QWidget(parent)
{
    m_cmbUsuario = new QComboBox(this);
    m_cmbPresupuesto = new QComboBox(this);

    connect(m_cmbUsuario, &QComboBox::currentIndexChanged, this, &TransaccionWidget::onUsuarioChanged);
    connect(m_cmbPresupuesto, &QComboBox::currentIndexChanged, this, &TransaccionWidget::onPresupuestoChanged);

    auto* top = new QHBoxLayout;
    top->addWidget(new QLabel("Usuario:", this));
    top->addWidget(m_cmbUsuario, 1);
    top->addSpacing(16);
    top->addWidget(new QLabel("Presupuesto:", this));
    top->addWidget(m_cmbPresupuesto, 1);

    m_tbl = new QTableWidget(this);
    m_tbl->setColumnCount(10);
    m_tbl->setHorizontalHeaderLabels({
        "Id_transaccion", "Fecha", "Tipo", "Subcategoría", "Obligación",
        "Monto", "Descripción", "Método pago", "Factura", "Modificado"
    });
    m_tbl->horizontalHeader()->setStretchLastSection(true);
    m_tbl->setSelectionBehavior(QAbstractItemView::SelectRows);
    m_tbl->setSelectionMode(QAbstractItemView::SingleSelection);
    m_tbl->setEditTriggers(QAbstractItemView::NoEditTriggers);

    m_btnRefrescar = new QPushButton("Refrescar", this);
    m_btnNuevo = new QPushButton("Nuevo", this);
    m_btnEditar = new QPushButton("Editar", this);
    m_btnEliminar = new QPushButton("Eliminar", this);
    m_btnRecalcular = new QPushButton("Recalcular totales", this);

    connect(m_btnRefrescar, &QPushButton::clicked, this, &TransaccionWidget::refrescarTransacciones);
    connect(m_btnNuevo, &QPushButton::clicked, this, &TransaccionWidget::onNuevo);
    connect(m_btnEditar, &QPushButton::clicked, this, &TransaccionWidget::onEditar);
    connect(m_btnEliminar, &QPushButton::clicked, this, &TransaccionWidget::onEliminar);
    connect(m_btnRecalcular, &QPushButton::clicked, this, &TransaccionWidget::onRecalcularTotales);

    auto* bar = new QHBoxLayout;
    bar->addWidget(m_btnRefrescar);
    bar->addStretch();
    bar->addWidget(m_btnNuevo);
    bar->addWidget(m_btnEditar);
    bar->addWidget(m_btnEliminar);
    bar->addWidget(m_btnRecalcular);

    auto* root = new QVBoxLayout(this);
    root->addLayout(top);
    root->addLayout(bar);
    root->addWidget(m_tbl);
    setLayout(root);

    refrescarUsuarios();
}

void TransaccionWidget::refrescarUsuarios()
{
    auto db = DatabaseManager::instance().database();
    UsuarioDAO uDao(db);

    QString err;
    auto usuarios = uDao.obtenerTodos(&err);
    if (!err.isEmpty()) {
        QMessageBox::critical(this, "BD", "Error cargando usuarios:\n" + err);
        return;
    }

    m_cmbUsuario->clear();
    for (const auto& u : usuarios) {
        QString label = u.nombre + " " + u.apellido + " (" + u.correo + ")";
        m_cmbUsuario->addItem(label, u.id_usuario);
    }

    refrescarPresupuestos();
}

void TransaccionWidget::onUsuarioChanged()
{
    refrescarPresupuestos();
}

void TransaccionWidget::refrescarPresupuestos()
{
    m_cmbPresupuesto->clear();
    m_tbl->setRowCount(0);

    if (m_cmbUsuario->currentIndex() < 0) return;

    QString idUsuario = m_cmbUsuario->currentData().toString();

    auto db = DatabaseManager::instance().database();
    PresupuestoDAO pDao(db);

    QString err;
    auto pres = pDao.obtenerPorUsuario(idUsuario, &err);
    if (!err.isEmpty()) {
        QMessageBox::critical(this, "BD", "Error cargando presupuestos:\n" + err);
        return;
    }

    for (const auto& p : pres) {
        QString label = p.nombre + " [" +
                        QString::number(p.anio_inicio) + "-" + QString::number(p.mes_inicio).rightJustified(2, '0') +
                        " .. " +
                        QString::number(p.anio_fin) + "-" + QString::number(p.mes_fin).rightJustified(2, '0') +
                        "] (" + p.estado + ")";
        m_cmbPresupuesto->addItem(label, p.id_presupuesto);
    }

    refrescarTransacciones();
}

void TransaccionWidget::onPresupuestoChanged()
{
    refrescarTransacciones();
}

QString TransaccionWidget::selectedTransaccionId() const
{
    auto ranges = m_tbl->selectedRanges();
    if (ranges.isEmpty()) return {};
    int row = ranges.first().topRow();
    auto* item = m_tbl->item(row, 0);
    return item ? item->text() : QString();
}

QList<QPair<QString, QString>> TransaccionWidget::cargarSubcategorias()
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

QList<QPair<QString, QString>> TransaccionWidget::cargarObligacionesPorUsuario(const QString& idUsuario)
{
    QList<QPair<QString, QString>> items;
    auto db = DatabaseManager::instance().database();

    QSqlQuery q(db);
    q.prepare("SELECT Id_obligacion_fija, nombre FROM Obligacion_fija WHERE Id_usuario = :u ORDER BY nombre");
    q.bindValue(":u", idUsuario);

    if (!q.exec()) {
        return items;
    }
    while (q.next()) {
        items.append({ q.value(0).toString(), q.value(1).toString() });
    }
    return items;
}

void TransaccionWidget::refrescarTransacciones()
{
    m_tbl->setRowCount(0);

    if (m_cmbUsuario->currentIndex() < 0) return;
    if (m_cmbPresupuesto->currentIndex() < 0) return;

    QString idPresupuesto = m_cmbPresupuesto->currentData().toString();

    auto db = DatabaseManager::instance().database();
    TransaccionDAO tDao(db);

    QString err;
    auto lista = tDao.obtenerPorPresupuesto(idPresupuesto, &err);
    if (!err.isEmpty()) {
        QMessageBox::critical(this, "BD", "Error cargando transacciones:\n" + err);
        return;
    }

    for (const auto& t : lista) {
        int r = m_tbl->rowCount();
        m_tbl->insertRow(r);

        m_tbl->setItem(r, 0, new QTableWidgetItem(t.id_transaccion));
        m_tbl->setItem(r, 1, new QTableWidgetItem(t.fecha.isValid() ? t.fecha.toString(Qt::ISODate) : ""));
        m_tbl->setItem(r, 2, new QTableWidgetItem(t.tipo));
        m_tbl->setItem(r, 3, new QTableWidgetItem(t.id_subcategoria));
        m_tbl->setItem(r, 4, new QTableWidgetItem(t.id_obligacion_fija));
        m_tbl->setItem(r, 5, new QTableWidgetItem(QString::number(t.monto, 'f', 2)));
        m_tbl->setItem(r, 6, new QTableWidgetItem(t.descripcion));
        m_tbl->setItem(r, 7, new QTableWidgetItem(t.metodo_pago));
        m_tbl->setItem(r, 8, new QTableWidgetItem(t.numero_factura));
        m_tbl->setItem(r, 9, new QTableWidgetItem(t.modificado_en.isValid() ? t.modificado_en.toString(Qt::ISODate) : ""));
    }

    m_tbl->resizeColumnsToContents();
}

void TransaccionWidget::onNuevo()
{
    if (m_cmbUsuario->currentIndex() < 0 || m_cmbPresupuesto->currentIndex() < 0) {
        QMessageBox::information(this, "Transacciones", "Selecciona usuario y presupuesto.");
        return;
    }

    QString idUsuario = m_cmbUsuario->currentData().toString();
    QString idPresupuesto = m_cmbPresupuesto->currentData().toString();

    auto subItems = cargarSubcategorias();
    if (subItems.isEmpty()) {
        QMessageBox::information(this, "Transacciones", "No hay subcategorías. Crea subcategorías primero.");
        return;
    }

    auto oblItems = cargarObligacionesPorUsuario(idUsuario);

    TransaccionDialog dlg(this);
    dlg.setIdUsuario(idUsuario);
    dlg.setIdPresupuesto(idPresupuesto);
    dlg.setSubcategorias(subItems);
    dlg.setObligaciones(oblItems);

    if (dlg.exec() != QDialog::Accepted) return;

    auto t = dlg.transaccion();
    if (t.id_subcategoria.isEmpty()) {
        QMessageBox::warning(this, "Validación", "Subcategoría es obligatoria.");
        return;
    }
    if (t.monto <= 0.0) {
        QMessageBox::warning(this, "Validación", "Monto debe ser mayor a 0.");
        return;
    }

    t.id_transaccion = QUuid::createUuid().toString(QUuid::WithoutBraces);
    t.creado_por = "app";

    auto db = DatabaseManager::instance().database();
    TransaccionDAO dao(db);

    QString err;
    // Inserta + recalcula totales con lógica de negocio
    if (!dao.registrarNegocio(t, &err)) {
        QMessageBox::critical(this, "BD", "No se pudo registrar:\n" + err);
        return;
    }

    refrescarTransacciones();
}

void TransaccionWidget::onEditar()
{
    QString id = selectedTransaccionId();
    if (id.isEmpty()) {
        QMessageBox::information(this, "Transacciones", "Selecciona una transacción.");
        return;
    }

    auto db = DatabaseManager::instance().database();
    TransaccionDAO dao(db);

    QString err;
    auto opt = dao.obtenerPorId(id, &err);
    if (!err.isEmpty()) {
        QMessageBox::critical(this, "BD", "Error consultando:\n" + err);
        return;
    }
    if (!opt) {
        QMessageBox::information(this, "Transacciones", "La transacción ya no existe.");
        refrescarTransacciones();
        return;
    }

    QString idUsuario = m_cmbUsuario->currentData().toString();
    auto subItems = cargarSubcategorias();
    auto oblItems = cargarObligacionesPorUsuario(idUsuario);

    TransaccionDialog dlg(this);
    dlg.setSubcategorias(subItems);
    dlg.setObligaciones(oblItems);
    dlg.setTransaccion(*opt);

    if (dlg.exec() != QDialog::Accepted) return;

    auto t = dlg.transaccion();
    if (t.id_subcategoria.isEmpty()) {
        QMessageBox::warning(this, "Validación", "Subcategoría es obligatoria.");
        return;
    }
    if (t.monto <= 0.0) {
        QMessageBox::warning(this, "Validación", "Monto debe ser mayor a 0.");
        return;
    }

    t.modificado_por = "app";

    if (!dao.actualizar(t, &err)) {
        QMessageBox::critical(this, "BD", "No se pudo actualizar:\n" + err);
        return;
    }

    // Si editaste monto/tipo, totales podrían cambiar: recalcula
    QSqlQuery q(db);
    q.prepare("EXECUTE PROCEDURE sp_recalcular_totales_presupuesto(:p)");
    q.bindValue(":p", t.id_presupuesto);
    q.exec();

    refrescarTransacciones();
}

void TransaccionWidget::onEliminar()
{
    QString id = selectedTransaccionId();
    if (id.isEmpty()) {
        QMessageBox::information(this, "Transacciones", "Selecciona una transacción.");
        return;
    }

    if (QMessageBox::question(this, "Eliminar", "¿Eliminar la transacción seleccionada?") != QMessageBox::Yes)
        return;

    // necesitamos el presupuesto para recalcular
    QString idPresupuesto = m_cmbPresupuesto->currentData().toString();

    auto db = DatabaseManager::instance().database();
    TransaccionDAO dao(db);

    QString err;
    if (!dao.eliminar(id, &err)) {
        QMessageBox::critical(this, "BD", "No se pudo eliminar:\n" + err);
        return;
    }

    // Recalcular totales después de eliminar
    QSqlQuery q(db);
    q.prepare("EXECUTE PROCEDURE sp_recalcular_totales_presupuesto(:p)");
    q.bindValue(":p", idPresupuesto);
    q.exec();

    refrescarTransacciones();
}

void TransaccionWidget::onRecalcularTotales()
{
    if (m_cmbPresupuesto->currentIndex() < 0) {
        QMessageBox::information(this, "Transacciones", "Selecciona un presupuesto.");
        return;
    }

    QString idPresupuesto = m_cmbPresupuesto->currentData().toString();
    auto db = DatabaseManager::instance().database();

    QSqlQuery q(db);
    q.prepare("EXECUTE PROCEDURE sp_recalcular_totales_presupuesto(:p)");
    q.bindValue(":p", idPresupuesto);

    if (!q.exec()) {
        QMessageBox::critical(this, "BD", "No se pudo recalcular totales.");
        return;
    }

    QMessageBox::information(this, "OK", "Totales recalculados.");
}
