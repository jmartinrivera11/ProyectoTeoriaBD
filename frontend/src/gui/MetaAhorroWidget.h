#pragma once
#include <QWidget>

class QComboBox;
class QTableWidget;
class QPushButton;

class MetaAhorroWidget : public QWidget {
    Q_OBJECT
public:
    explicit MetaAhorroWidget(QWidget* parent = nullptr);

private slots:
    void refrescarUsuarios();
    void refrescarMetas();
    void onUsuarioChanged();
    void onNuevo();
    void onEditar();
    void onEliminar();
    void onAportar();

private:
    QString selectedMetaId() const;
    QList<QPair<QString, QString>> cargarSubcategorias();
    QComboBox* m_cmbUsuario = nullptr;
    QTableWidget* m_tbl = nullptr;
    QPushButton* m_btnRef = nullptr;
    QPushButton* m_btnNuevo = nullptr;
    QPushButton* m_btnEditar = nullptr;
    QPushButton* m_btnEliminar = nullptr;
    QPushButton* m_btnAportar = nullptr;
};
