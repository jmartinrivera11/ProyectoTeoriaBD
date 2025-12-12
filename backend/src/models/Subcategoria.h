#include <QString>
#include <QDateTime>

namespace Model {
    struct Subcategoria {
        QString id_subcategoria;
        QString id_categoria;
        QString nombre;
        QString descripcion;
        bool activa = true;
        bool es_defecto = false;
        QString creado_por;
        QString modificado_por;
        QDateTime creado_en;
        QDateTime modificado_en;
    };
}
