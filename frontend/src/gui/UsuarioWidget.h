#include <QWidget>

class QTableWidget;
class QPushButton;

class UsuarioWidget : public QWidget {
    Q_OBJECT
public:
    explicit UsuarioWidget(QWidget* parent = nullptr);

private slots:
    void onRefrescar();
    void onNuevo();
    void onEditar();
    void onEliminar();

private:
    QString selectedId() const;
    void cargarTabla();
    QTableWidget* m_table = nullptr;
    QPushButton* m_btnRefrescar = nullptr;
    QPushButton* m_btnNuevo = nullptr;
    QPushButton* m_btnEditar = nullptr;
    QPushButton* m_btnEliminar = nullptr;
};
