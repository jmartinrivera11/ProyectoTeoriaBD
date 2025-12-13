#pragma once
#include <QString>
#include <QDateTime>

namespace Model {
    struct Categoria {
        QString id_categoria;
        QString nombre;
        QString descripcion;
        QString tipo;
        QString icono;
        QString color_hex;
        int orden = 0;
        QString creado_por;
        QString modificado_por;
        QDateTime creado_en;
        QDateTime modificado_en;
    };
}
