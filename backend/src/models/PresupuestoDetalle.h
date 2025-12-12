#include <QString>
#include <QDateTime>

namespace Model {
    struct PresupuestoDetalle {
        QString id_presupuesto_detalle;
        QString id_presupuesto;
        QString id_subcategoria;
        double monto_mensual = 0.0;
        QString observacion;
        QString creado_por;
        QString modificado_por;
        QDateTime creado_en;
        QDateTime modificado_en;
    };
}
