#pragma once
#include <QWidget>

class QComboBox;
class QTableWidget;
class QPushButton;

class PresupuestoWidget : public QWidget {
    Q_OBJECT
public:
    explicit PresupuestoWidget(QWidget* parent = nullptr);

private slots:
    void onUsuarioChanged();
    void refrescarPresupuestos();
    void refrescarDetalles();
    void onPresupuestoSeleccionado();
    void onPresNuevo();
    void onPresEditar();
    void onPresEliminar();
    void onPresRecalcular();
    void onPresCerrar();
    void onPresReabrir();
    void onDetNuevo();
    void onDetEditar();
    void onDetEliminar();

private:
    QString selectedPresupuestoId() const;
    QString selectedDetalleId() const;
    void cargarUsuariosCombo();
    QList<QPair<QString, QString>> cargarSubcategoriasComboData();
    QComboBox* m_cmbUsuario = nullptr;
    QTableWidget* m_tblPresupuestos = nullptr;
    QTableWidget* m_tblDetalles = nullptr;
    QPushButton* m_btnPresRef = nullptr;
    QPushButton* m_btnPresNuevo = nullptr;
    QPushButton* m_btnPresEditar = nullptr;
    QPushButton* m_btnPresEliminar = nullptr;
    QPushButton* m_btnPresRecalc = nullptr;
    QPushButton* m_btnPresCerrar = nullptr;
    QPushButton* m_btnPresReabrir = nullptr;
    QPushButton* m_btnDetNuevo = nullptr;
    QPushButton* m_btnDetEditar = nullptr;
    QPushButton* m_btnDetEliminar = nullptr;
};
