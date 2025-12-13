#pragma once
#include <QString>
#include <QDateTime>

namespace Model {
    struct Transaccion {
        QString id_transaccion;
        QString id_usuario;
        QString id_presupuesto;
        QString id_subcategoria;
        QString id_obligacion_fija;
        int anio = 0;
        int mes = 0;
        QString tipo;
        QString descripcion;
        double monto = 0.0;
        QDateTime fecha;
        QString metodo_pago;
        QString numero_factura;
        QString observaciones;
        QDateTime fecha_registro;
        QString creado_por;
        QString modificado_por;
        QDateTime creado_en;
        QDateTime modificado_en;
    };
}
