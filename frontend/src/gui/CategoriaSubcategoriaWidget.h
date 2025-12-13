#pragma once
#include <QWidget>

class QTableWidget;
class QPushButton;

class CategoriaSubcategoriaWidget : public QWidget {
    Q_OBJECT
public:
    explicit CategoriaSubcategoriaWidget(QWidget* parent = nullptr);

private slots:
    void refrescarCategorias();
    void refrescarSubcategorias();
    void onCategoriaSeleccionada();
    void onCategoriaNuevo();
    void onCategoriaEditar();
    void onCategoriaEliminar();
    void onSubcategoriaNuevo();
    void onSubcategoriaEditar();
    void onSubcategoriaEliminar();

private:
    QString selectedCategoriaId() const;
    QString selectedSubcategoriaId() const;
    QTableWidget* m_tblCategorias = nullptr;
    QTableWidget* m_tblSubcategorias = nullptr;
    QPushButton* m_btnCatRefrescar = nullptr;
    QPushButton* m_btnCatNuevo = nullptr;
    QPushButton* m_btnCatEditar = nullptr;
    QPushButton* m_btnCatEliminar = nullptr;
    QPushButton* m_btnSubNuevo = nullptr;
    QPushButton* m_btnSubEditar = nullptr;
    QPushButton* m_btnSubEliminar = nullptr;
};
