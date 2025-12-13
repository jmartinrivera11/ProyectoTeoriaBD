#pragma once
#include <QDialog>
#include "../../../backend/src/models/Categoria.h"

class QLineEdit;
class QComboBox;
class QSpinBox;

class CategoriaDialog : public QDialog {
    Q_OBJECT
public:
    explicit CategoriaDialog(QWidget* parent = nullptr);
    void setCategoria(const Model::Categoria& c);
    Model::Categoria categoria() const;

private:
    QString m_idCategoria;
    QLineEdit* m_nombre = nullptr;
    QLineEdit* m_descripcion = nullptr;
    QComboBox* m_tipo = nullptr;
    QLineEdit* m_icono = nullptr;
    QLineEdit* m_colorHex = nullptr;
    QSpinBox* m_orden = nullptr;
};
