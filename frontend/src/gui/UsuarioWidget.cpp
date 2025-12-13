#include "UsuarioWidget.h"
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QTableWidget>
#include <QHeaderView>
#include <QPushButton>
#include <QMessageBox>
#include <QUuid>
#include "../../../backend/src/database/DBManager.h"
#include "../../../backend/src/dao/UsuarioDAO.h"
#include "UsuarioDialog.h"

UsuarioWidget::UsuarioWidget(QWidget* parent) : QWidget(parent) {
    m_table = new QTableWidget(this);
    m_table->setColumnCount(7);
    m_table->setHorizontalHeaderLabels({
        "Id_usuario", "Nombre", "Apellido", "Correo",
        "Salario", "Estado", "Modificado_en"
    });
    m_table->horizontalHeader()->setStretchLastSection(true);
    m_table->setSelectionBehavior(QAbstractItemView::SelectRows);
    m_table->setSelectionMode(QAbstractItemView::SingleSelection);
    m_table->setEditTriggers(QAbstractItemView::NoEditTriggers);

    m_btnRefrescar = new QPushButton("Refrescar", this);
    m_btnNuevo = new QPushButton("Nuevo", this);
    m_btnEditar = new QPushButton("Editar", this);
    m_btnEliminar = new QPushButton("Eliminar", this);

    connect(m_btnRefrescar, &QPushButton::clicked, this, &UsuarioWidget::onRefrescar);
    connect(m_btnNuevo, &QPushButton::clicked, this, &UsuarioWidget::onNuevo);
    connect(m_btnEditar, &QPushButton::clicked, this, &UsuarioWidget::onEditar);
    connect(m_btnEliminar, &QPushButton::clicked, this, &UsuarioWidget::onEliminar);

    auto* btns = new QHBoxLayout;
    btns->addWidget(m_btnRefrescar);
    btns->addStretch();
    btns->addWidget(m_btnNuevo);
    btns->addWidget(m_btnEditar);
    btns->addWidget(m_btnEliminar);

    auto* root = new QVBoxLayout(this);
    root->addLayout(btns);
    root->addWidget(m_table);
    setLayout(root);

    cargarTabla();
}

void UsuarioWidget::onRefrescar() {
    cargarTabla();
}

QString UsuarioWidget::selectedId() const {
    auto ranges = m_table->selectedRanges();
    if (ranges.isEmpty()) return {};
    int row = ranges.first().topRow();
    auto* item = m_table->item(row, 0);
    return item ? item->text() : QString();
}

void UsuarioWidget::cargarTabla() {
    auto db = DatabaseManager::instance().database();
    UsuarioDAO dao(db);

    QString err;
    auto usuarios = dao.obtenerTodos(&err);
    if (!err.isEmpty()) {
        QMessageBox::critical(this, "BD", "Error cargando usuarios:\n" + err);
        return;
    }

    m_table->setRowCount(0);

    for (const auto& u : usuarios) {
        int r = m_table->rowCount();
        m_table->insertRow(r);

        m_table->setItem(r, 0, new QTableWidgetItem(u.id_usuario));
        m_table->setItem(r, 1, new QTableWidgetItem(u.nombre));
        m_table->setItem(r, 2, new QTableWidgetItem(u.apellido));
        m_table->setItem(r, 3, new QTableWidgetItem(u.correo));
        m_table->setItem(r, 4, new QTableWidgetItem(QString::number(u.salario_mensual_base, 'f', 2)));
        m_table->setItem(r, 5, new QTableWidgetItem(u.estado));
        m_table->setItem(r, 6, new QTableWidgetItem(u.modificado_en.isValid() ? u.modificado_en.toString(Qt::ISODate) : ""));
    }

    m_table->resizeColumnsToContents();
}

void UsuarioWidget::onNuevo() {
    UsuarioDialog dlg(this);
    if (dlg.exec() != QDialog::Accepted) return;

    auto u = dlg.usuario();
    if (u.nombre.isEmpty() || u.apellido.isEmpty() || u.correo.isEmpty()) {
        QMessageBox::warning(this, "Validación", "Nombre, apellido y correo son obligatorios.");
        return;
    }

    u.id_usuario = QUuid::createUuid().toString(QUuid::WithoutBraces);
    u.creado_por = "app";

    auto db = DatabaseManager::instance().database();
    UsuarioDAO dao(db);

    QString err;
    if (!dao.insertar(u, &err)) {
        QMessageBox::critical(this, "BD", "No se pudo insertar:\n" + err);
        return;
    }

    cargarTabla();
}

void UsuarioWidget::onEditar() {
    QString id = selectedId();
    if (id.isEmpty()) {
        QMessageBox::information(this, "Usuarios", "Selecciona un usuario.");
        return;
    }

    auto db = DatabaseManager::instance().database();
    UsuarioDAO dao(db);

    QString err;
    auto opt = dao.obtenerPorId(id, &err);
    if (!err.isEmpty()) {
        QMessageBox::critical(this, "BD", "Error consultando usuario:\n" + err);
        return;
    }
    if (!opt) {
        QMessageBox::information(this, "Usuarios", "El usuario ya no existe.");
        cargarTabla();
        return;
    }

    UsuarioDialog dlg(this);
    dlg.setUsuario(*opt);

    if (dlg.exec() != QDialog::Accepted) return;

    auto u = dlg.usuario();
    if (u.nombre.isEmpty() || u.apellido.isEmpty() || u.correo.isEmpty()) {
        QMessageBox::warning(this, "Validación", "Nombre, apellido y correo son obligatorios.");
        return;
    }

    u.modificado_por = "app";

    if (!dao.actualizar(u, &err)) {
        QMessageBox::critical(this, "BD", "No se pudo actualizar:\n" + err);
        return;
    }

    cargarTabla();
}

void UsuarioWidget::onEliminar() {
    QString id = selectedId();
    if (id.isEmpty()) {
        QMessageBox::information(this, "Usuarios", "Selecciona un usuario.");
        return;
    }

    if (QMessageBox::question(this, "Eliminar", "¿Eliminar el usuario seleccionado?") != QMessageBox::Yes)
        return;

    auto db = DatabaseManager::instance().database();
    UsuarioDAO dao(db);

    QString err;
    if (!dao.eliminar(id, &err)) {
        QMessageBox::critical(this, "BD", "No se pudo eliminar:\n" + err);
        return;
    }

    cargarTabla();
}
