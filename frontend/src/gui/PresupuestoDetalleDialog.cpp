#include "PresupuestoDetalleDialog.h"

#include <QFormLayout>
#include <QComboBox>
#include <QDoubleSpinBox>
#include <QLineEdit>
#include <QDialogButtonBox>
#include <QVBoxLayout>

PresupuestoDetalleDialog::PresupuestoDetalleDialog(QWidget* parent)
    : QDialog(parent)
{
    setWindowTitle("Detalle de Presupuesto");

    m_subcategoria = new QComboBox(this);

    m_monto = new QDoubleSpinBox(this);
    m_monto->setRange(0.0, 1e12);
    m_monto->setDecimals(2);

    m_observacion = new QLineEdit(this);

    auto* form = new QFormLayout;
    form->addRow("Subcategoría:", m_subcategoria);
    form->addRow("Monto mensual:", m_monto);
    form->addRow("Observación:", m_observacion);

    auto* buttons = new QDialogButtonBox(QDialogButtonBox::Ok | QDialogButtonBox::Cancel, this);
    connect(buttons, &QDialogButtonBox::accepted, this, &QDialog::accept);
    connect(buttons, &QDialogButtonBox::rejected, this, &QDialog::reject);

    auto* root = new QVBoxLayout(this);
    root->addLayout(form);
    root->addWidget(buttons);
    setLayout(root);
}

void PresupuestoDetalleDialog::setSubcategorias(const QList<QPair<QString, QString>>& items)
{
    m_items = items;
    m_subcategoria->clear();
    for (const auto& it : m_items) {
        m_subcategoria->addItem(it.second, it.first); // text, userData=id
    }
}

void PresupuestoDetalleDialog::setDetalle(const Model::PresupuestoDetalle& d)
{
    m_idDetalle = d.id_presupuesto_detalle;
    m_idPresupuesto = d.id_presupuesto;

    // Seleccionar subcategoría en combo
    int idx = m_subcategoria->findData(d.id_subcategoria);
    if (idx >= 0) m_subcategoria->setCurrentIndex(idx);

    m_monto->setValue(d.monto_mensual);
    m_observacion->setText(d.observacion);
}

Model::PresupuestoDetalle PresupuestoDetalleDialog::detalle() const
{
    Model::PresupuestoDetalle d;
    d.id_presupuesto_detalle = m_idDetalle;
    d.id_presupuesto = m_idPresupuesto;

    d.id_subcategoria = m_subcategoria->currentData().toString();
    d.monto_mensual = m_monto->value();
    d.observacion = m_observacion->text().trimmed();
    return d;
}
