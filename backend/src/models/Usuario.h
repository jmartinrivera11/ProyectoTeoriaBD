#include <QString>
#include <QDateTime>

namespace Model {
    struct Usuario {
        QString id_usuario;
        QString nombre;
        QString apellido;
        QString correo;
        QDateTime fecha_registro;
        double salario_mensual_base = 0.0;
        QString estado;
        QString creado_por;
        QString modificado_por;
        QDateTime creado_en;
        QDateTime modificado_en;
    };
}
