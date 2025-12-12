#include <QString>
#include <QDateTime>

namespace Model {
    struct Presupuesto {
        QString id_presupuesto;
        QString id_usuario;
        QString nombre;
        int anio_inicio = 0;
        int mes_inicio = 0;
        int anio_fin = 0;
        int mes_fin = 0;
        double total_ingresos = 0.0;
        double total_gastos = 0.0;
        double total_ahorro = 0.0;
        QDateTime fecha_creacion;
        QString estado;
        QString creado_por;
        QString modificado_por;
        QDateTime creado_en;
        QDateTime modificado_en;
    };
}
