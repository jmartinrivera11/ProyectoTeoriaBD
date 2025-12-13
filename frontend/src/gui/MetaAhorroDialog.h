#pragma once
#include <QDialog>
#include "../../../backend/src/models/MetaAhorro.h"

class QComboBox;
class QLineEdit;
class QDoubleSpinBox;
class QDateEdit;

class MetaAhorroDialog : public QDialog {
    Q_OBJECT
public:
    explicit MetaAhorroDialog(QWidget* parent = nullptr);
    void setMeta(const Model::MetaAhorro& m);
    Model::MetaAhorro meta() const;
    void setIdUsuario(const QString& idUsuario) { m_idUsuario = idUsuario; }
    void setSubcategorias(const QList<QPair<QString, QString>>& items);

private:
    QString m_idMeta;
    QString m_idUsuario;
    QComboBox* m_subcategoria = nullptr;
    QLineEdit* m_nombre = nullptr;
    QLineEdit* m_descripcion = nullptr;
    QDoubleSpinBox* m_montoTotal = nullptr;
    QDateEdit* m_fechaInicio = nullptr;
    QDateEdit* m_fechaObjetivo = nullptr;
    QComboBox* m_prioridad = nullptr;
    QComboBox* m_estado = nullptr;
};
