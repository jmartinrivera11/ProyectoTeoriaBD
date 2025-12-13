#include "CategoriaDialog.h"

#include <QFormLayout>
#include <QLineEdit>
#include <QComboBox>
#include <QSpinBox>
#include <QDialogButtonBox>
#include <QVBoxLayout>

CategoriaDialog::CategoriaDialog(QWidget* parent)
    : QDialog(parent)
{
    setWindowTitle("Categoría");

    m_nombre = new QLineEdit(this);
    m_descripcion = new QLineEdit(this);

    m_tipo = new QComboBox(this);
    m_tipo->addItems({"ingreso", "gasto", "ahorro"});

    m_icono = new QLineEdit(this);
    m_colorHex = new QLineEdit(this);
    m_colorHex->setPlaceholderText("#RRGGBB");

    m_orden = new QSpinBox(this);
    m_orden->setMinimum(0);
    m_orden->setMaximum(100000);

    auto* form = new QFormLayout;
    form->addRow("Nombre:", m_nombre);
    form->addRow("Descripción:", m_descripcion);
    form->addRow("Tipo:", m_tipo);
    form->addRow("Icono:", m_icono);
    form->addRow("Color hex:", m_colorHex);
    form->addRow("Orden:", m_orden);

    auto* buttons = new QDialogButtonBox(QDialogButtonBox::Ok | QDialogButtonBox::Cancel, this);
    connect(buttons, &QDialogButtonBox::accepted, this, &QDialog::accept);
    connect(buttons, &QDialogButtonBox::rejected, this, &QDialog::reject);

    auto* root = new QVBoxLayout(this);
    root->addLayout(form);
    root->addWidget(buttons);
    setLayout(root);
}

void CategoriaDialog::setCategoria(const Model::Categoria& c)
{
    m_idCategoria = c.id_categoria;
    m_nombre->setText(c.nombre);
    m_descripcion->setText(c.descripcion);
    m_tipo->setCurrentText(c.tipo.isEmpty() ? "gasto" : c.tipo);
    m_icono->setText(c.icono);
    m_colorHex->setText(c.color_hex);
    m_orden->setValue(c.orden);
}

Model::Categoria CategoriaDialog::categoria() const
{
    Model::Categoria c;
    c.id_categoria = m_idCategoria;
    c.nombre = m_nombre->text().trimmed();
    c.descripcion = m_descripcion->text().trimmed();
    c.tipo = m_tipo->currentText();
    c.icono = m_icono->text().trimmed();
    c.color_hex = m_colorHex->text().trimmed();
    c.orden = m_orden->value();
    return c;
}
