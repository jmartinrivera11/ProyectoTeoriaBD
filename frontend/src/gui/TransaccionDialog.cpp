#include "TransaccionDialog.h"

#include <QFormLayout>
#include <QComboBox>
#include <QLineEdit>
#include <QDoubleSpinBox>
#include <QDateTimeEdit>
#include <QDialogButtonBox>
#include <QVBoxLayout>

TransaccionDialog::TransaccionDialog(QWidget* parent)
    : QDialog(parent)
{
    setWindowTitle("Transacción");

    m_tipo = new QComboBox(this);
    m_tipo->addItems({"ingreso", "gasto", "ahorro"});

    m_subcategoria = new QComboBox(this);

    m_obligacion = new QComboBox(this);
    m_obligacion->addItem("(Sin obligación)", QString()); // vacío = NULL/empty

    m_fecha = new QDateTimeEdit(QDateTime::currentDateTime(), this);
    m_fecha->setCalendarPopup(true);

    m_descripcion = new QLineEdit(this);

    m_monto = new QDoubleSpinBox(this);
    m_monto->setRange(0.0, 1e12);
    m_monto->setDecimals(2);

    m_metodoPago = new QLineEdit(this);
    m_numeroFactura = new QLineEdit(this);
    m_observaciones = new QLineEdit(this);

    auto* form = new QFormLayout;
    form->addRow("Tipo:", m_tipo);
    form->addRow("Subcategoría:", m_subcategoria);
    form->addRow("Obligación fija:", m_obligacion);
    form->addRow("Fecha:", m_fecha);
    form->addRow("Descripción:", m_descripcion);
    form->addRow("Monto:", m_monto);
    form->addRow("Método pago:", m_metodoPago);
    form->addRow("No. factura:", m_numeroFactura);
    form->addRow("Observaciones:", m_observaciones);

    auto* buttons = new QDialogButtonBox(QDialogButtonBox::Ok | QDialogButtonBox::Cancel, this);
    connect(buttons, &QDialogButtonBox::accepted, this, &QDialog::accept);
    connect(buttons, &QDialogButtonBox::rejected, this, &QDialog::reject);

    auto* root = new QVBoxLayout(this);
    root->addLayout(form);
    root->addWidget(buttons);
    setLayout(root);
}

void TransaccionDialog::setSubcategorias(const QList<QPair<QString, QString>>& items)
{
    m_subcategoria->clear();
    for (const auto& it : items) {
        m_subcategoria->addItem(it.second, it.first);
    }
}

void TransaccionDialog::setObligaciones(const QList<QPair<QString, QString>>& items)
{
    m_obligacion->clear();
    m_obligacion->addItem("(Sin obligación)", QString());
    for (const auto& it : items) {
        m_obligacion->addItem(it.second, it.first);
    }
}

void TransaccionDialog::setTransaccion(const Model::Transaccion& t)
{
    m_idTransaccion = t.id_transaccion;
    m_idUsuario = t.id_usuario;
    m_idPresupuesto = t.id_presupuesto;

    int idxTipo = m_tipo->findText(t.tipo);
    if (idxTipo >= 0) m_tipo->setCurrentIndex(idxTipo);

    int idxSub = m_subcategoria->findData(t.id_subcategoria);
    if (idxSub >= 0) m_subcategoria->setCurrentIndex(idxSub);

    int idxObl = m_obligacion->findData(t.id_obligacion_fija);
    if (idxObl >= 0) m_obligacion->setCurrentIndex(idxObl);
    else m_obligacion->setCurrentIndex(0);

    m_fecha->setDateTime(t.fecha.isValid() ? t.fecha : QDateTime::currentDateTime());
    m_descripcion->setText(t.descripcion);
    m_monto->setValue(t.monto);

    m_metodoPago->setText(t.metodo_pago);
    m_numeroFactura->setText(t.numero_factura);
    m_observaciones->setText(t.observaciones);
}

Model::Transaccion TransaccionDialog::transaccion() const
{
    Model::Transaccion t;
    t.id_transaccion = m_idTransaccion;
    t.id_usuario = m_idUsuario;
    t.id_presupuesto = m_idPresupuesto;

    t.tipo = m_tipo->currentText();
    t.id_subcategoria = m_subcategoria->currentData().toString();
    t.id_obligacion_fija = m_obligacion->currentData().toString();

    t.fecha = m_fecha->dateTime();
    t.anio = t.fecha.date().year();
    t.mes  = t.fecha.date().month();

    t.descripcion = m_descripcion->text().trimmed();
    t.monto = m_monto->value();

    t.metodo_pago = m_metodoPago->text().trimmed();
    t.numero_factura = m_numeroFactura->text().trimmed();
    t.observaciones = m_observaciones->text().trimmed();

    return t;
}
