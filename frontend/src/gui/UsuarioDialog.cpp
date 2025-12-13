#include "UsuarioDialog.h"
#include <QFormLayout>
#include <QLineEdit>
#include <QDoubleSpinBox>
#include <QComboBox>
#include <QDialogButtonBox>
#include <QVBoxLayout>

UsuarioDialog::UsuarioDialog(QWidget* parent) : QDialog(parent) {
    setWindowTitle("Usuario");

    m_nombre = new QLineEdit(this);
    m_apellido = new QLineEdit(this);
    m_correo = new QLineEdit(this);

    m_salario = new QDoubleSpinBox(this);
    m_salario->setMinimum(0.0);
    m_salario->setMaximum(1e12);
    m_salario->setDecimals(2);

    m_estado = new QComboBox(this);
    m_estado->addItems({"activo", "inactivo"});

    auto* form = new QFormLayout;
    form->addRow("Nombre:", m_nombre);
    form->addRow("Apellido:", m_apellido);
    form->addRow("Correo:", m_correo);
    form->addRow("Salario mensual base:", m_salario);
    form->addRow("Estado:", m_estado);

    auto* buttons = new QDialogButtonBox(QDialogButtonBox::Ok | QDialogButtonBox::Cancel, this);
    connect(buttons, &QDialogButtonBox::accepted, this, &QDialog::accept);
    connect(buttons, &QDialogButtonBox::rejected, this, &QDialog::reject);

    auto* root = new QVBoxLayout(this);
    root->addLayout(form);
    root->addWidget(buttons);
    setLayout(root);
}

void UsuarioDialog::setUsuario(const Model::Usuario& u) {
    m_idUsuario = u.id_usuario;
    m_nombre->setText(u.nombre);
    m_apellido->setText(u.apellido);
    m_correo->setText(u.correo);
    m_salario->setValue(u.salario_mensual_base);
    m_estado->setCurrentText(u.estado.isEmpty() ? "activo" : u.estado);
}

Model::Usuario UsuarioDialog::usuario() const {
    Model::Usuario u;
    u.id_usuario = m_idUsuario;
    u.nombre = m_nombre->text().trimmed();
    u.apellido = m_apellido->text().trimmed();
    u.correo = m_correo->text().trimmed();
    u.salario_mensual_base = m_salario->value();
    u.estado = m_estado->currentText();
    return u;
}
