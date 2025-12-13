#pragma once
#include <QWidget>

class QComboBox;
class QTableWidget;
class QPushButton;

class ObligacionFijaWidget : public QWidget {
    Q_OBJECT
public:
    explicit ObligacionFijaWidget(QWidget* parent = nullptr);

private slots:
    void refrescarUsuarios();
    void refrescarObligaciones();
    void onUsuarioChanged();
    void onNuevo();
    void onEditar();
    void onEliminar();

private:
    QString selectedId() const;
    QList<QPair<QString, QString>> cargarSubcategorias();
    QComboBox* m_cmbUsuario = nullptr;
    QTableWidget* m_tbl = nullptr;
    QPushButton* m_btnRef = nullptr;
    QPushButton* m_btnNuevo = nullptr;
    QPushButton* m_btnEditar = nullptr;
    QPushButton* m_btnEliminar = nullptr;
};
