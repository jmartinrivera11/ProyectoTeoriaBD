#pragma once
#include <QDialog>
#include "../../../backend/src/models/Presupuesto.h"

class QLineEdit;
class QSpinBox;
class QComboBox;

class PresupuestoDialog : public QDialog {
    Q_OBJECT
public:
    explicit PresupuestoDialog(QWidget* parent = nullptr);
    void setPresupuesto(const Model::Presupuesto& p);
    Model::Presupuesto presupuesto() const;
    void setIdUsuario(const QString& idUsuario) { m_idUsuario = idUsuario; }

private:
    QString m_idPresupuesto;
    QString m_idUsuario;
    QLineEdit* m_nombre = nullptr;
    QSpinBox* m_anioInicio = nullptr;
    QSpinBox* m_mesInicio = nullptr;
    QSpinBox* m_anioFin = nullptr;
    QSpinBox* m_mesFin = nullptr;
    QComboBox* m_estado = nullptr;
};
