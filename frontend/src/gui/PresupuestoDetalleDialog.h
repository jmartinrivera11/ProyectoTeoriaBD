#pragma once
#include <QDialog>
#include "../../../backend/src/models/PresupuestoDetalle.h"

class QComboBox;
class QDoubleSpinBox;
class QLineEdit;

class PresupuestoDetalleDialog : public QDialog {
    Q_OBJECT
public:
    explicit PresupuestoDetalleDialog(QWidget* parent = nullptr);
    void setDetalle(const Model::PresupuestoDetalle& d);
    Model::PresupuestoDetalle detalle() const;
    void setIdPresupuesto(const QString& idPresupuesto) { m_idPresupuesto = idPresupuesto; }
    void setSubcategorias(const QList<QPair<QString, QString>>& items);

private:
    QString m_idDetalle;
    QString m_idPresupuesto;
    QComboBox* m_subcategoria = nullptr;
    QDoubleSpinBox* m_monto = nullptr;
    QLineEdit* m_observacion = nullptr;
    QList<QPair<QString, QString>> m_items;
};
