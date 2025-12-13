#pragma once
#include <QDialog>
#include "../../../backend/src/models/ObligacionFija.h"

class QComboBox;
class QLineEdit;
class QDoubleSpinBox;
class QSpinBox;
class QCheckBox;
class QDateEdit;

class ObligacionFijaDialog : public QDialog {
    Q_OBJECT
public:
    explicit ObligacionFijaDialog(QWidget* parent = nullptr);
    void setObligacion(const Model::ObligacionFija& o);
    Model::ObligacionFija obligacion() const;
    void setIdUsuario(const QString& idUsuario) { m_idUsuario = idUsuario; }
    void setSubcategorias(const QList<QPair<QString, QString>>& items);

private:
    QString m_idObligacion;
    QString m_idUsuario;
    QComboBox* m_subcategoria = nullptr;
    QLineEdit* m_nombre = nullptr;
    QLineEdit* m_descripcion = nullptr;
    QDoubleSpinBox* m_montoMensual = nullptr;
    QSpinBox* m_diaMes = nullptr;
    QCheckBox* m_vigente = nullptr;
    QDateEdit* m_fechaInicio = nullptr;
    QDateEdit* m_fechaFin = nullptr;
};
