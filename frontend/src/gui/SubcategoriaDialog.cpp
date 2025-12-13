#include "SubcategoriaDialog.h"

#include <QFormLayout>
#include <QLineEdit>
#include <QCheckBox>
#include <QDialogButtonBox>
#include <QVBoxLayout>

SubcategoriaDialog::SubcategoriaDialog(QWidget* parent)
    : QDialog(parent)
{
    setWindowTitle("Subcategoría");

    m_nombre = new QLineEdit(this);
    m_descripcion = new QLineEdit(this);

    m_activa = new QCheckBox("Activa", this);
    m_activa->setChecked(true);

    m_esDefecto = new QCheckBox("Es defecto", this);

    auto* form = new QFormLayout;
    form->addRow("Nombre:", m_nombre);
    form->addRow("Descripción:", m_descripcion);
    form->addRow("", m_activa);
    form->addRow("", m_esDefecto);

    auto* buttons = new QDialogButtonBox(QDialogButtonBox::Ok | QDialogButtonBox::Cancel, this);
    connect(buttons, &QDialogButtonBox::accepted, this, &QDialog::accept);
    connect(buttons, &QDialogButtonBox::rejected, this, &QDialog::reject);

    auto* root = new QVBoxLayout(this);
    root->addLayout(form);
    root->addWidget(buttons);
    setLayout(root);
}

void SubcategoriaDialog::setSubcategoria(const Model::Subcategoria& s)
{
    m_idSubcategoria = s.id_subcategoria;
    m_idCategoria = s.id_categoria;

    m_nombre->setText(s.nombre);
    m_descripcion->setText(s.descripcion);
    m_activa->setChecked(s.activa);
    m_esDefecto->setChecked(s.es_defecto);
}

Model::Subcategoria SubcategoriaDialog::subcategoria() const
{
    Model::Subcategoria s;
    s.id_subcategoria = m_idSubcategoria;
    s.id_categoria = m_idCategoria;

    s.nombre = m_nombre->text().trimmed();
    s.descripcion = m_descripcion->text().trimmed();
    s.activa = m_activa->isChecked();
    s.es_defecto = m_esDefecto->isChecked();

    return s;
}
