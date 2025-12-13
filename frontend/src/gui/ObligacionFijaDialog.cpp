#include "ObligacionFijaDialog.h"

#include <QFormLayout>
#include <QComboBox>
#include <QLineEdit>
#include <QDoubleSpinBox>
#include <QSpinBox>
#include <QCheckBox>
#include <QDateEdit>
#include <QDialogButtonBox>
#include <QVBoxLayout>

ObligacionFijaDialog::ObligacionFijaDialog(QWidget* parent)
    : QDialog(parent)
{
    setWindowTitle("Obligación fija");

    m_subcategoria = new QComboBox(this);

    m_nombre = new QLineEdit(this);
    m_descripcion = new QLineEdit(this);

    m_montoMensual = new QDoubleSpinBox(this);
    m_montoMensual->setRange(0.0, 1e12);
    m_montoMensual->setDecimals(2);

    m_diaMes = new QSpinBox(this);
    m_diaMes->setRange(1, 31);

    m_vigente = new QCheckBox("Vigente", this);
    m_vigente->setChecked(true);

    m_fechaInicio = new QDateEdit(QDate::currentDate(), this);
    m_fechaInicio->setCalendarPopup(true);

    m_fechaFin = new QDateEdit(QDate::currentDate().addYears(1), this);
    m_fechaFin->setCalendarPopup(true);

    auto* form = new QFormLayout;
    form->addRow("Subcategoría:", m_subcategoria);
    form->addRow("Nombre:", m_nombre);
    form->addRow("Descripción:", m_descripcion);
    form->addRow("Monto mensual:", m_montoMensual);
    form->addRow("Día del mes:", m_diaMes);
    form->addRow("", m_vigente);
    form->addRow("Fecha inicio:", m_fechaInicio);
    form->addRow("Fecha fin:", m_fechaFin);

    auto* buttons = new QDialogButtonBox(QDialogButtonBox::Ok | QDialogButtonBox::Cancel, this);
    connect(buttons, &QDialogButtonBox::accepted, this, &QDialog::accept);
    connect(buttons, &QDialogButtonBox::rejected, this, &QDialog::reject);

    auto* root = new QVBoxLayout(this);
    root->addLayout(form);
    root->addWidget(buttons);
    setLayout(root);
}

void ObligacionFijaDialog::setSubcategorias(const QList<QPair<QString, QString>>& items)
{
    m_subcategoria->clear();
    for (const auto& it : items) {
        m_subcategoria->addItem(it.second, it.first);
    }
}

void ObligacionFijaDialog::setObligacion(const Model::ObligacionFija& o)
{
    m_idObligacion = o.id_obligacion_fija;
    m_idUsuario = o.id_usuario;

    int idxSub = m_subcategoria->findData(o.id_subcategoria);
    if (idxSub >= 0) m_subcategoria->setCurrentIndex(idxSub);

    m_nombre->setText(o.nombre);
    m_descripcion->setText(o.descripcion);
    m_montoMensual->setValue(o.monto_mensual);
    m_diaMes->setValue(o.dia_mes);
    m_vigente->setChecked(o.vigente);

    if (o.fecha_inicio.isValid())
        m_fechaInicio->setDate(o.fecha_inicio.date());
    if (o.fecha_fin.isValid())
        m_fechaFin->setDate(o.fecha_fin.date());
}

Model::ObligacionFija ObligacionFijaDialog::obligacion() const
{
    Model::ObligacionFija o;
    o.id_obligacion_fija = m_idObligacion;
    o.id_usuario = m_idUsuario;

    o.id_subcategoria = m_subcategoria->currentData().toString();
    o.nombre = m_nombre->text().trimmed();
    o.descripcion = m_descripcion->text().trimmed();
    o.monto_mensual = m_montoMensual->value();
    o.dia_mes = m_diaMes->value();
    o.vigente = m_vigente->isChecked();

    o.fecha_inicio = QDateTime(m_fechaInicio->date(), QTime(0,0,0));
    o.fecha_fin = QDateTime(m_fechaFin->date(), QTime(0,0,0));

    return o;
}
