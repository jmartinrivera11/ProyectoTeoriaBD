#include "MetaAhorroDialog.h"

#include <QFormLayout>
#include <QComboBox>
#include <QLineEdit>
#include <QDoubleSpinBox>
#include <QDateEdit>
#include <QDialogButtonBox>
#include <QVBoxLayout>

MetaAhorroDialog::MetaAhorroDialog(QWidget* parent)
    : QDialog(parent)
{
    setWindowTitle("Meta de ahorro");

    m_subcategoria = new QComboBox(this);

    m_nombre = new QLineEdit(this);
    m_descripcion = new QLineEdit(this);

    m_montoTotal = new QDoubleSpinBox(this);
    m_montoTotal->setRange(0.0, 1e12);
    m_montoTotal->setDecimals(2);

    m_fechaInicio = new QDateEdit(QDate::currentDate(), this);
    m_fechaInicio->setCalendarPopup(true);

    m_fechaObjetivo = new QDateEdit(QDate::currentDate().addMonths(1), this);
    m_fechaObjetivo->setCalendarPopup(true);

    m_prioridad = new QComboBox(this);
    m_prioridad->addItems({"baja", "media", "alta"});

    m_estado = new QComboBox(this);
    m_estado->addItems({"activa", "completada", "cancelada"});

    auto* form = new QFormLayout;
    form->addRow("Subcategoría:", m_subcategoria);
    form->addRow("Nombre:", m_nombre);
    form->addRow("Descripción:", m_descripcion);
    form->addRow("Monto total:", m_montoTotal);
    form->addRow("Fecha inicio:", m_fechaInicio);
    form->addRow("Fecha objetivo:", m_fechaObjetivo);
    form->addRow("Prioridad:", m_prioridad);
    form->addRow("Estado:", m_estado);

    auto* buttons = new QDialogButtonBox(QDialogButtonBox::Ok | QDialogButtonBox::Cancel, this);
    connect(buttons, &QDialogButtonBox::accepted, this, &QDialog::accept);
    connect(buttons, &QDialogButtonBox::rejected, this, &QDialog::reject);

    auto* root = new QVBoxLayout(this);
    root->addLayout(form);
    root->addWidget(buttons);
    setLayout(root);
}

void MetaAhorroDialog::setSubcategorias(const QList<QPair<QString, QString>>& items)
{
    m_subcategoria->clear();
    for (const auto& it : items) {
        m_subcategoria->addItem(it.second, it.first);
    }
}

void MetaAhorroDialog::setMeta(const Model::MetaAhorro& m)
{
    m_idMeta = m.id_meta_ahorro;
    m_idUsuario = m.id_usuario;

    int idxSub = m_subcategoria->findData(m.id_subcategoria);
    if (idxSub >= 0) m_subcategoria->setCurrentIndex(idxSub);

    m_nombre->setText(m.nombre);
    m_descripcion->setText(m.descripcion);
    m_montoTotal->setValue(m.monto_total);

    if (m.fecha_inicio.isValid())
        m_fechaInicio->setDate(m.fecha_inicio.date());
    if (m.fecha_objetivo.isValid())
        m_fechaObjetivo->setDate(m.fecha_objetivo.date());

    if (!m.prioridad.isEmpty()) m_prioridad->setCurrentText(m.prioridad);
    if (!m.estado.isEmpty()) m_estado->setCurrentText(m.estado);
}

Model::MetaAhorro MetaAhorroDialog::meta() const
{
    Model::MetaAhorro m;
    m.id_meta_ahorro = m_idMeta;
    m.id_usuario = m_idUsuario;

    m.id_subcategoria = m_subcategoria->currentData().toString();
    m.nombre = m_nombre->text().trimmed();
    m.descripcion = m_descripcion->text().trimmed();
    m.monto_total = m_montoTotal->value();

    m.fecha_inicio = QDateTime(m_fechaInicio->date(), QTime(0,0,0));
    m.fecha_objetivo = QDateTime(m_fechaObjetivo->date(), QTime(0,0,0));

    m.prioridad = m_prioridad->currentText();
    m.estado = m_estado->currentText();
    return m;
}
