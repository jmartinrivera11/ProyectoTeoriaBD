#pragma once
#include <QWidget>

class QComboBox;
class QTableWidget;
class QPushButton;

class TransaccionWidget : public QWidget {
    Q_OBJECT
public:
    explicit TransaccionWidget(QWidget* parent = nullptr);

private slots:
    void onUsuarioChanged();
    void onPresupuestoChanged();
    void refrescarUsuarios();
    void refrescarPresupuestos();
    void refrescarTransacciones();
    void onNuevo();
    void onEditar();
    void onEliminar();
    void onRecalcularTotales();

private:
    QString selectedTransaccionId() const;
    QList<QPair<QString, QString>> cargarSubcategorias();
    QList<QPair<QString, QString>> cargarObligacionesPorUsuario(const QString& idUsuario);
    QComboBox* m_cmbUsuario = nullptr;
    QComboBox* m_cmbPresupuesto = nullptr;
    QTableWidget* m_tbl = nullptr;
    QPushButton* m_btnNuevo = nullptr;
    QPushButton* m_btnEditar = nullptr;
    QPushButton* m_btnEliminar = nullptr;
    QPushButton* m_btnRefrescar = nullptr;
    QPushButton* m_btnRecalcular = nullptr;
};
