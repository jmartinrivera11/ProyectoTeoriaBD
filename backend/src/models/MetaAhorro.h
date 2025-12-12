#include <QString>
#include <QDateTime>

namespace Model {
    struct MetaAhorro {
        QString id_meta_ahorro;
        QString id_usuario;
        QString id_subcategoria;
        QString nombre;
        QString descripcion;
        double monto_total = 0.0;
        double monto_ahorrado = 0.0;
        QDateTime fecha_inicio;
        QDateTime fecha_objetivo;
        QString prioridad;
        QString estado;
        QString creado_por;
        QString modificado_por;
        QDateTime creado_en;
        QDateTime modificado_en;
    };
}
