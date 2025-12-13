#pragma once
#include <QDialog>
#include "../../../backend/src/models/Subcategoria.h"

class QLineEdit;
class QCheckBox;

class SubcategoriaDialog : public QDialog {
    Q_OBJECT
public:
    explicit SubcategoriaDialog(QWidget* parent = nullptr);
    void setSubcategoria(const Model::Subcategoria& s);
    Model::Subcategoria subcategoria() const;

private:
    QString m_idSubcategoria;
    QString m_idCategoria;
    QLineEdit* m_nombre = nullptr;
    QLineEdit* m_descripcion = nullptr;
    QCheckBox* m_activa = nullptr;
    QCheckBox* m_esDefecto = nullptr;

public:
    void setIdCategoria(const QString& idCategoria) { m_idCategoria = idCategoria; }
};
