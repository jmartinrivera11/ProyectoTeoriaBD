#include "PresupuestoDialog.h"

#include <QFormLayout>
#include <QLineEdit>
#include <QSpinBox>
#include <QComboBox>
#include <QDialogButtonBox>
#include <QVBoxLayout>

PresupuestoDialog::PresupuestoDialog(QWidget* parent)
    : QDialog(parent)
{
    setWindowTitle("Presupuesto");

    m_nombre = new QLineEdit(this);

    m_anioInicio = new QSpinBox(this);
    m_anioInicio->setRange(1900, 3000);

    m_mesInicio = new QSpinBox(this);
    m_mesInicio->setRange(1, 12);

    m_anioFin = new QSpinBox(this);
    m_anioFin->setRange(1900, 3000);

    m_mesFin = new QSpinBox(this);
    m_mesFin->setRange(1, 12);

    m_estado = new QComboBox(this);
    m_estado->addItems({"activo", "cerrado"});

    auto* form = new QFormLayout;
    form->addRow("Nombre:", m_nombre);
    form->addRow("Año inicio:", m_anioInicio);
    form->addRow("Mes inicio:", m_mesInicio);
    form->addRow("Año fin:", m_anioFin);
    form->addRow("Mes fin:", m_mesFin);
    form->addRow("Estado:", m_estado);

    auto* buttons = new QDialogButtonBox(QDialogButtonBox::Ok | QDialogButtonBox::Cancel, this);
    connect(buttons, &QDialogButtonBox::accepted, this, &QDialog::accept);
    connect(buttons, &QDialogButtonBox::rejected, this, &QDialog::reject);

    auto* root = new QVBoxLayout(this);
    root->addLayout(form);
    root->addWidget(buttons);
    setLayout(root);
}

void PresupuestoDialog::setPresupuesto(const Model::Presupuesto& p)
{
    m_idPresupuesto = p.id_presupuesto;
    m_idUsuario = p.id_usuario;

    m_nombre->setText(p.nombre);
    m_anioInicio->setValue(p.anio_inicio);
    m_mesInicio->setValue(p.mes_inicio);
    m_anioFin->setValue(p.anio_fin);
    m_mesFin->setValue(p.mes_fin);
    m_estado->setCurrentText(p.estado.isEmpty() ? "activo" : p.estado);
}

Model::Presupuesto PresupuestoDialog::presupuesto() const
{
    Model::Presupuesto p;
    p.id_presupuesto = m_idPresupuesto;
    p.id_usuario = m_idUsuario;

    p.nombre = m_nombre->text().trimmed();
    p.anio_inicio = m_anioInicio->value();
    p.mes_inicio  = m_mesInicio->value();
    p.anio_fin    = m_anioFin->value();
    p.mes_fin     = m_mesFin->value();
    p.estado      = m_estado->currentText();

    return p;
}
