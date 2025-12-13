#include <QDialog>
#include "../../../backend/src/models/Usuario.h"

class QLineEdit;
class QDoubleSpinBox;
class QComboBox;

class UsuarioDialog : public QDialog {
    Q_OBJECT
public:
    explicit UsuarioDialog(QWidget* parent = nullptr);
    void setUsuario(const Model::Usuario& u);
    Model::Usuario usuario() const;

private:
    QString m_idUsuario;
    QLineEdit* m_nombre = nullptr;
    QLineEdit* m_apellido = nullptr;
    QLineEdit* m_correo = nullptr;
    QDoubleSpinBox* m_salario = nullptr;
    QComboBox* m_estado = nullptr;
};
