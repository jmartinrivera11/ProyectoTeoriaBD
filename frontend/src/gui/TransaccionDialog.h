#pragma once
#include <QDialog>
#include "../../../backend/src/models/Transaccion.h"

class QComboBox;
class QLineEdit;
class QDoubleSpinBox;
class QDateTimeEdit;

class TransaccionDialog : public QDialog {
    Q_OBJECT
public:
    explicit TransaccionDialog(QWidget* parent = nullptr);
    void setTransaccion(const Model::Transaccion& t);
    Model::Transaccion transaccion() const;
    void setIdUsuario(const QString& idUsuario) { m_idUsuario = idUsuario; }
    void setIdPresupuesto(const QString& idPresupuesto) { m_idPresupuesto = idPresupuesto; }
    void setSubcategorias(const QList<QPair<QString, QString>>& items);
    void setObligaciones(const QList<QPair<QString, QString>>& items);

private:
    QString m_idTransaccion;
    QString m_idUsuario;
    QString m_idPresupuesto;
    QComboBox* m_tipo = nullptr;
    QComboBox* m_subcategoria = nullptr;
    QComboBox* m_obligacion = nullptr;
    QDateTimeEdit* m_fecha = nullptr;
    QLineEdit* m_descripcion = nullptr;
    QDoubleSpinBox* m_monto = nullptr;
    QLineEdit* m_metodoPago = nullptr;
    QLineEdit* m_numeroFactura = nullptr;
    QLineEdit* m_observaciones = nullptr;
};
