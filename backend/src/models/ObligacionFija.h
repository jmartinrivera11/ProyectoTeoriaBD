#pragma once
#include <QString>
#include <QDateTime>

namespace Model {
    struct ObligacionFija {
        QString id_obligacion_fija;
        QString id_subcategoria;
        QString id_usuario;
        QString nombre;
        QString descripcion;
        double monto_mensual = 0.0;
        int dia_mes = 1;
        bool vigente = true;
        QDateTime fecha_inicio;
        QDateTime fecha_fin;
        QString creado_por;
        QString modificado_por;
        QDateTime creado_en;
        QDateTime modificado_en;
    };
}
