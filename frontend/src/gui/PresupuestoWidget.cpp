#include "PresupuestoWidget.h"

#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QLabel>
#include <QComboBox>
#include <QTableWidget>
#include <QHeaderView>
#include <QPushButton>
#include <QMessageBox>
#include <QUuid>
#include <qsqlquery.h>

#include "../../../backend/src/database/DBManager.h"

#include "../../../backend/src/dao/UsuarioDAO.h"
#include "../../../backend/src/dao/PresupuestoDAO.h"
#include "../../../backend/src/dao/PresupuestoDetalleDAO.h"
#include "../../../backend/src/dao/SubcategoriaDAO.h"

#include "PresupuestoDialog.h"
#include "PresupuestoDetalleDialog.h"

PresupuestoWidget::PresupuestoWidget(QWidget* parent)
    : QWidget(parent)
{
    // Selector usuario
    m_cmbUsuario = new QComboBox(this);
    connect(m_cmbUsuario, &QComboBox::currentIndexChanged, this, &PresupuestoWidget::onUsuarioChanged);

    auto* top = new QHBoxLayout;
    top->addWidget(new QLabel("Usuario:", this));
    top->addWidget(m_cmbUsuario, 1);

    // Tabla presupuestos
    m_tblPresupuestos = new QTableWidget(this);
    m_tblPresupuestos->setColumnCount(10);
    m_tblPresupuestos->setHorizontalHeaderLabels({
        "Id_presupuesto", "Nombre", "Inicio", "Fin", "Estado",
        "Ingresos", "Gastos", "Ahorro", "Creado", "Modificado"
    });
    m_tblPresupuestos->horizontalHeader()->setStretchLastSection(true);
    m_tblPresupuestos->setSelectionBehavior(QAbstractItemView::SelectRows);
    m_tblPresupuestos->setSelectionMode(QAbstractItemView::SingleSelection);
    m_tblPresupuestos->setEditTriggers(QAbstractItemView::NoEditTriggers);
    connect(m_tblPresupuestos, &QTableWidget::itemSelectionChanged, this, &PresupuestoWidget::onPresupuestoSeleccionado);

    // Tabla detalles
    m_tblDetalles = new QTableWidget(this);
    m_tblDetalles->setColumnCount(5);
    m_tblDetalles->setHorizontalHeaderLabels({
        "Id_detalle", "Id_subcategoria", "Monto mensual", "Observación", "Modificado"
    });
    m_tblDetalles->horizontalHeader()->setStretchLastSection(true);
    m_tblDetalles->setSelectionBehavior(QAbstractItemView::SelectRows);
    m_tblDetalles->setSelectionMode(QAbstractItemView::SingleSelection);
    m_tblDetalles->setEditTriggers(QAbstractItemView::NoEditTriggers);

    // Botones presupuesto
    m_btnPresRef = new QPushButton("Refrescar", this);
    m_btnPresNuevo = new QPushButton("Nuevo", this);
    m_btnPresEditar = new QPushButton("Editar", this);
    m_btnPresEliminar = new QPushButton("Eliminar", this);
    m_btnPresRecalc = new QPushButton("Recalcular", this);
    m_btnPresCerrar = new QPushButton("Cerrar", this);
    m_btnPresReabrir = new QPushButton("Reabrir", this);

    connect(m_btnPresRef, &QPushButton::clicked, this, &PresupuestoWidget::refrescarPresupuestos);
    connect(m_btnPresNuevo, &QPushButton::clicked, this, &PresupuestoWidget::onPresNuevo);
    connect(m_btnPresEditar, &QPushButton::clicked, this, &PresupuestoWidget::onPresEditar);
    connect(m_btnPresEliminar, &QPushButton::clicked, this, &PresupuestoWidget::onPresEliminar);
    connect(m_btnPresRecalc, &QPushButton::clicked, this, &PresupuestoWidget::onPresRecalcular);
    connect(m_btnPresCerrar, &QPushButton::clicked, this, &PresupuestoWidget::onPresCerrar);
    connect(m_btnPresReabrir, &QPushButton::clicked, this, &PresupuestoWidget::onPresReabrir);

    auto* barPres = new QHBoxLayout;
    barPres->addWidget(m_btnPresRef);
    barPres->addStretch();
    barPres->addWidget(m_btnPresNuevo);
    barPres->addWidget(m_btnPresEditar);
    barPres->addWidget(m_btnPresEliminar);
    barPres->addWidget(m_btnPresRecalc);
    barPres->addWidget(m_btnPresCerrar);
    barPres->addWidget(m_btnPresReabrir);

    // Botones detalle
    m_btnDetNuevo = new QPushButton("Nuevo detalle", this);
    m_btnDetEditar = new QPushButton("Editar", this);
    m_btnDetEliminar = new QPushButton("Eliminar", this);

    connect(m_btnDetNuevo, &QPushButton::clicked, this, &PresupuestoWidget::onDetNuevo);
    connect(m_btnDetEditar, &QPushButton::clicked, this, &PresupuestoWidget::onDetEditar);
    connect(m_btnDetEliminar, &QPushButton::clicked, this, &PresupuestoWidget::onDetEliminar);

    auto* barDet = new QHBoxLayout;
    barDet->addStretch();
    barDet->addWidget(m_btnDetNuevo);
    barDet->addWidget(m_btnDetEditar);
    barDet->addWidget(m_btnDetEliminar);

    // Layout principal: arriba selector usuario, luego presupuestos, luego detalles
    auto* root = new QVBoxLayout(this);
    root->addLayout(top);
    root->addLayout(barPres);
    root->addWidget(m_tblPresupuestos, 2);
    root->addLayout(barDet);
    root->addWidget(m_tblDetalles, 1);
    setLayout(root);

    cargarUsuariosCombo();
}

void PresupuestoWidget::cargarUsuariosCombo()
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

    if (m_cmbUsuario->count() > 0) {
        refrescarPresupuestos();
    } else {
        m_tblPresupuestos->setRowCount(0);
        m_tblDetalles->setRowCount(0);
    }
}

void PresupuestoWidget::onUsuarioChanged()
{
    refrescarPresupuestos();
}

QString PresupuestoWidget::selectedPresupuestoId() const
{
    auto ranges = m_tblPresupuestos->selectedRanges();
    if (ranges.isEmpty()) return {};
    int row = ranges.first().topRow();
    auto* item = m_tblPresupuestos->item(row, 0);
    return item ? item->text() : QString();
}

QString PresupuestoWidget::selectedDetalleId() const
{
    auto ranges = m_tblDetalles->selectedRanges();
    if (ranges.isEmpty()) return {};
    int row = ranges.first().topRow();
    auto* item = m_tblDetalles->item(row, 0);
    return item ? item->text() : QString();
}

void PresupuestoWidget::refrescarPresupuestos()
{
    if (m_cmbUsuario->currentIndex() < 0) return;

    QString idUsuario = m_cmbUsuario->currentData().toString();
    auto db = DatabaseManager::instance().database();
    PresupuestoDAO dao(db);

    QString err;
    auto pres = dao.obtenerPorUsuario(idUsuario, &err);
    if (!err.isEmpty()) {
        QMessageBox::critical(this, "BD", "Error cargando presupuestos:\n" + err);
        return;
    }

    QString keepId = selectedPresupuestoId();

    m_tblPresupuestos->setRowCount(0);
    for (const auto& p : pres) {
        int r = m_tblPresupuestos->rowCount();
        m_tblPresupuestos->insertRow(r);

        QString inicio = QString::number(p.anio_inicio) + "-" + QString::number(p.mes_inicio).rightJustified(2, '0');
        QString fin    = QString::number(p.anio_fin)    + "-" + QString::number(p.mes_fin).rightJustified(2, '0');

        m_tblPresupuestos->setItem(r, 0, new QTableWidgetItem(p.id_presupuesto));
        m_tblPresupuestos->setItem(r, 1, new QTableWidgetItem(p.nombre));
        m_tblPresupuestos->setItem(r, 2, new QTableWidgetItem(inicio));
        m_tblPresupuestos->setItem(r, 3, new QTableWidgetItem(fin));
        m_tblPresupuestos->setItem(r, 4, new QTableWidgetItem(p.estado));
        m_tblPresupuestos->setItem(r, 5, new QTableWidgetItem(QString::number(p.total_ingresos, 'f', 2)));
        m_tblPresupuestos->setItem(r, 6, new QTableWidgetItem(QString::number(p.total_gastos, 'f', 2)));
        m_tblPresupuestos->setItem(r, 7, new QTableWidgetItem(QString::number(p.total_ahorro, 'f', 2)));
        m_tblPresupuestos->setItem(r, 8, new QTableWidgetItem(p.creado_en.isValid() ? p.creado_en.toString(Qt::ISODate) : ""));
        m_tblPresupuestos->setItem(r, 9, new QTableWidgetItem(p.modificado_en.isValid() ? p.modificado_en.toString(Qt::ISODate) : ""));
    }

    m_tblPresupuestos->resizeColumnsToContents();

    if (!keepId.isEmpty()) {
        for (int r = 0; r < m_tblPresupuestos->rowCount(); ++r) {
            if (m_tblPresupuestos->item(r, 0)->text() == keepId) {
                m_tblPresupuestos->selectRow(r);
                break;
            }
        }
    }

    refrescarDetalles();
}

void PresupuestoWidget::onPresupuestoSeleccionado()
{
    refrescarDetalles();
}

void PresupuestoWidget::refrescarDetalles()
{
    QString idPres = selectedPresupuestoId();
    if (idPres.isEmpty()) {
        m_tblDetalles->setRowCount(0);
        return;
    }

    auto db = DatabaseManager::instance().database();
    PresupuestoDetalleDAO dao(db);

    QString err;
    auto dets = dao.obtenerPorPresupuesto(idPres, &err);
    if (!err.isEmpty()) {
        QMessageBox::critical(this, "BD", "Error cargando detalles:\n" + err);
        return;
    }

    m_tblDetalles->setRowCount(0);
    for (const auto& d : dets) {
        int r = m_tblDetalles->rowCount();
        m_tblDetalles->insertRow(r);

        m_tblDetalles->setItem(r, 0, new QTableWidgetItem(d.id_presupuesto_detalle));
        m_tblDetalles->setItem(r, 1, new QTableWidgetItem(d.id_subcategoria));
        m_tblDetalles->setItem(r, 2, new QTableWidgetItem(QString::number(d.monto_mensual, 'f', 2)));
        m_tblDetalles->setItem(r, 3, new QTableWidgetItem(d.observacion));
        m_tblDetalles->setItem(r, 4, new QTableWidgetItem(d.modificado_en.isValid() ? d.modificado_en.toString(Qt::ISODate) : ""));
    }

    m_tblDetalles->resizeColumnsToContents();
}

QList<QPair<QString, QString>> PresupuestoWidget::cargarSubcategoriasComboData()
{
    auto db = DatabaseManager::instance().database();
    SubcategoriaDAO dao(db);

    QList<QPair<QString, QString>> items;

    // Tomamos subcategorías de la categoría seleccionada? Aquí simple: todas.
    // Para no hacer consulta extra, usaremos un SELECT directo (simple y funcional).
    QSqlQuery q(db);
    if (!q.exec("SELECT Id_subcategoria, nombre FROM Subcategoria ORDER BY nombre")) {
        return items;
    }
    while (q.next()) {
        items.append({ q.value(0).toString(), q.value(1).toString() });
    }

    return items;
}

void PresupuestoWidget::onPresNuevo()
{
    if (m_cmbUsuario->currentIndex() < 0) {
        QMessageBox::information(this, "Presupuestos", "Crea o selecciona un usuario.");
        return;
    }

    QString idUsuario = m_cmbUsuario->currentData().toString();

    PresupuestoDialog dlg(this);
    dlg.setIdUsuario(idUsuario);

    if (dlg.exec() != QDialog::Accepted) return;

    auto p = dlg.presupuesto();
    if (p.nombre.isEmpty()) {
        QMessageBox::warning(this, "Validación", "El nombre es obligatorio.");
        return;
    }
    if (p.anio_inicio > p.anio_fin || (p.anio_inicio == p.anio_fin && p.mes_inicio > p.mes_fin)) {
        QMessageBox::warning(this, "Validación", "Rango de fechas inválido.");
        return;
    }

    p.id_presupuesto = QUuid::createUuid().toString(QUuid::WithoutBraces);
    p.creado_por = "app";

    auto db = DatabaseManager::instance().database();
    PresupuestoDAO dao(db);

    QString err;
    if (!dao.insertar(p, &err)) {
        QMessageBox::critical(this, "BD", "No se pudo insertar:\n" + err);
        return;
    }

    refrescarPresupuestos();
}

void PresupuestoWidget::onPresEditar()
{
    QString id = selectedPresupuestoId();
    if (id.isEmpty()) {
        QMessageBox::information(this, "Presupuestos", "Selecciona un presupuesto.");
        return;
    }

    auto db = DatabaseManager::instance().database();
    PresupuestoDAO dao(db);

    QString err;
    auto opt = dao.obtenerPorId(id, &err);
    if (!err.isEmpty()) {
        QMessageBox::critical(this, "BD", "Error consultando:\n" + err);
        return;
    }
    if (!opt) {
        QMessageBox::information(this, "Presupuestos", "El presupuesto ya no existe.");
        refrescarPresupuestos();
        return;
    }

    PresupuestoDialog dlg(this);
    dlg.setPresupuesto(*opt);

    if (dlg.exec() != QDialog::Accepted) return;

    auto p = dlg.presupuesto();
    if (p.nombre.isEmpty()) {
        QMessageBox::warning(this, "Validación", "El nombre es obligatorio.");
        return;
    }
    if (p.anio_inicio > p.anio_fin || (p.anio_inicio == p.anio_fin && p.mes_inicio > p.mes_fin)) {
        QMessageBox::warning(this, "Validación", "Rango de fechas inválido.");
        return;
    }

    p.modificado_por = "app";

    if (!dao.actualizar(p, &err)) {
        QMessageBox::critical(this, "BD", "No se pudo actualizar:\n" + err);
        return;
    }

    refrescarPresupuestos();
}

void PresupuestoWidget::onPresEliminar()
{
    QString id = selectedPresupuestoId();
    if (id.isEmpty()) {
        QMessageBox::information(this, "Presupuestos", "Selecciona un presupuesto.");
        return;
    }

    if (QMessageBox::question(this, "Eliminar", "¿Eliminar el presupuesto seleccionado?") != QMessageBox::Yes)
        return;

    auto db = DatabaseManager::instance().database();
    PresupuestoDAO dao(db);

    QString err;
    if (!dao.eliminar(id, &err)) {
        QMessageBox::critical(this, "BD",
                              "No se pudo eliminar.\n"
                              "Si tiene detalles/transacciones asociadas, primero elimínalos.\n\n" + err);
        return;
    }

    refrescarPresupuestos();
}

void PresupuestoWidget::onPresRecalcular()
{
    QString id = selectedPresupuestoId();
    if (id.isEmpty()) {
        QMessageBox::information(this, "Presupuestos", "Selecciona un presupuesto.");
        return;
    }

    auto db = DatabaseManager::instance().database();
    PresupuestoDAO dao(db);

    QString err;
    if (!dao.recalcularTotales(id, &err)) {
        QMessageBox::critical(this, "BD", "No se pudo recalcular:\n" + err);
        return;
    }

    refrescarPresupuestos();
}

void PresupuestoWidget::onPresCerrar()
{
    QString id = selectedPresupuestoId();
    if (id.isEmpty()) {
        QMessageBox::information(this, "Presupuestos", "Selecciona un presupuesto.");
        return;
    }

    auto db = DatabaseManager::instance().database();
    PresupuestoDAO dao(db);

    QString err;
    if (!dao.cerrarPresupuesto(id, "app", &err)) {
        QMessageBox::critical(this, "BD", "No se pudo cerrar:\n" + err);
        return;
    }

    refrescarPresupuestos();
}

void PresupuestoWidget::onPresReabrir()
{
    QString id = selectedPresupuestoId();
    if (id.isEmpty()) {
        QMessageBox::information(this, "Presupuestos", "Selecciona un presupuesto.");
        return;
    }

    auto db = DatabaseManager::instance().database();
    PresupuestoDAO dao(db);

    QString err;
    if (!dao.reabrirPresupuesto(id, "app", &err)) {
        QMessageBox::critical(this, "BD", "No se pudo reabrir:\n" + err);
        return;
    }

    refrescarPresupuestos();
}

void PresupuestoWidget::onDetNuevo()
{
    QString idPres = selectedPresupuestoId();
    if (idPres.isEmpty()) {
        QMessageBox::information(this, "Detalle", "Selecciona un presupuesto.");
        return;
    }

    auto subItems = cargarSubcategoriasComboData();
    if (subItems.isEmpty()) {
        QMessageBox::information(this, "Detalle", "No hay subcategorías. Crea subcategorías primero.");
        return;
    }

    PresupuestoDetalleDialog dlg(this);
    dlg.setIdPresupuesto(idPres);
    dlg.setSubcategorias(subItems);

    if (dlg.exec() != QDialog::Accepted) return;

    auto d = dlg.detalle();
    if (d.id_subcategoria.isEmpty()) {
        QMessageBox::warning(this, "Validación", "Selecciona una subcategoría.");
        return;
    }

    d.id_presupuesto_detalle = QUuid::createUuid().toString(QUuid::WithoutBraces);
    d.creado_por = "app";

    auto db = DatabaseManager::instance().database();
    PresupuestoDetalleDAO dao(db);

    QString err;
    if (!dao.insertar(d, &err)) {
        QMessageBox::critical(this, "BD", "No se pudo insertar detalle:\n" + err);
        return;
    }

    refrescarDetalles();
}

void PresupuestoWidget::onDetEditar()
{
    QString idDet = selectedDetalleId();
    if (idDet.isEmpty()) {
        QMessageBox::information(this, "Detalle", "Selecciona un detalle.");
        return;
    }

    auto db = DatabaseManager::instance().database();
    PresupuestoDetalleDAO dao(db);

    QString err;
    auto opt = dao.obtenerPorId(idDet, &err);
    if (!err.isEmpty()) {
        QMessageBox::critical(this, "BD", "Error consultando detalle:\n" + err);
        return;
    }
    if (!opt) {
        QMessageBox::information(this, "Detalle", "El detalle ya no existe.");
        refrescarDetalles();
        return;
    }

    auto subItems = cargarSubcategoriasComboData();
    PresupuestoDetalleDialog dlg(this);
    dlg.setSubcategorias(subItems);
    dlg.setDetalle(*opt);

    if (dlg.exec() != QDialog::Accepted) return;

    auto d = dlg.detalle();
    if (d.id_subcategoria.isEmpty()) {
        QMessageBox::warning(this, "Validación", "Selecciona una subcategoría.");
        return;
    }

    d.modificado_por = "app";

    if (!dao.actualizar(d, &err)) {
        QMessageBox::critical(this, "BD", "No se pudo actualizar detalle:\n" + err);
        return;
    }

    refrescarDetalles();
}

void PresupuestoWidget::onDetEliminar()
{
    QString idDet = selectedDetalleId();
    if (idDet.isEmpty()) {
        QMessageBox::information(this, "Detalle", "Selecciona un detalle.");
        return;
    }

    if (QMessageBox::question(this, "Eliminar", "¿Eliminar el detalle seleccionado?") != QMessageBox::Yes)
        return;

    auto db = DatabaseManager::instance().database();
    PresupuestoDetalleDAO dao(db);

    QString err;
    if (!dao.eliminar(idDet, &err)) {
        QMessageBox::critical(this, "BD", "No se pudo eliminar detalle:\n" + err);
        return;
    }

    refrescarDetalles();
}
