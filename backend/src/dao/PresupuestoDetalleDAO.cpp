#include "PresupuestoDetalleDAO.h"
#include <QSqlQuery>
#include <QSqlError>
#include <QSqlRecord>
#include <QVariant>
#include <QDebug>

PresupuestoDetalleDAO::PresupuestoDetalleDAO(const QSqlDatabase& db) : m_db(db) {}

bool PresupuestoDetalleDAO::insertar(const Model::PresupuestoDetalle& d, QString* error) {
    QSqlQuery query(m_db);
    query.prepare(
        "EXECUTE PROCEDURE sp_insert_presupuesto_detalle("
        " :p_id_presupuesto_detalle, :p_id_presupuesto, :p_id_subcategoria, "
        " :p_monto_mensual, :p_observacion, :p_creado_por)"
    );

    query.bindValue(":p_id_presupuesto_detalle", d.id_presupuesto_detalle);
    query.bindValue(":p_id_presupuesto", d.id_presupuesto);
    query.bindValue(":p_id_subcategoria", d.id_subcategoria);
    query.bindValue(":p_monto_mensual", d.monto_mensual);
    query.bindValue(":p_observacion", d.observacion);
    query.bindValue(":p_creado_por", d.creado_por.isEmpty() ? QStringLiteral("app") : d.creado_por);

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error insertar presupuesto_detalle:" << query.lastError().text();
        return false;
    }
    return true;
}

bool PresupuestoDetalleDAO::actualizar(const Model::PresupuestoDetalle& d, QString* error) {
    QSqlQuery query(m_db);
    query.prepare(
        "EXECUTE PROCEDURE sp_update_presupuesto_detalle("
        " :p_id_presupuesto_detalle, :p_id_subcategoria, "
        " :p_monto_mensual, :p_observacion, :p_modificado_por)"
    );

    query.bindValue(":p_id_presupuesto_detalle", d.id_presupuesto_detalle);
    query.bindValue(":p_id_subcategoria", d.id_subcategoria);
    query.bindValue(":p_monto_mensual", d.monto_mensual);
    query.bindValue(":p_observacion", d.observacion);
    query.bindValue(":p_modificado_por", d.modificado_por.isEmpty() ? QStringLiteral("app") : d.modificado_por);

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error actualizar presupuesto_detalle:" << query.lastError().text();
        return false;
    }
    return true;
}

bool PresupuestoDetalleDAO::eliminar(const QString& idPresupuestoDetalle, QString* error) {
    QSqlQuery query(m_db);
    query.prepare("EXECUTE PROCEDURE sp_delete_presupuesto_detalle(:p_id_presupuesto_detalle)");
    query.bindValue(":p_id_presupuesto_detalle", idPresupuestoDetalle);

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error eliminar presupuesto_detalle:" << query.lastError().text();
        return false;
    }
    return true;
}

std::optional<Model::PresupuestoDetalle> PresupuestoDetalleDAO::obtenerPorId(const QString& idPresupuestoDetalle, QString* error) {
    QSqlQuery query(m_db);
    query.prepare("SELECT * FROM sp_get_presupuesto_detalle_by_id(:p_id_presupuesto_detalle)");
    query.bindValue(":p_id_presupuesto_detalle", idPresupuestoDetalle);

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error obtener presupuesto_detalle por id:" << query.lastError().text();
        return std::nullopt;
    }

    if (!query.next()) {
        return std::nullopt;
    }

    QSqlRecord rec = query.record();
    Model::PresupuestoDetalle d;
    d.id_presupuesto_detalle = rec.value("r_id_presupuesto_detalle").toString();
    d.id_presupuesto = rec.value("r_id_presupuesto").toString();
    d.id_subcategoria = rec.value("r_id_subcategoria").toString();
    d.monto_mensual = rec.value("r_monto_mensual").toDouble();
    d.observacion = rec.value("r_observacion").toString();
    d.creado_por = rec.value("r_creado_por").toString();
    d.modificado_por = rec.value("r_modificado_por").toString();
    d.creado_en = rec.value("r_creado_en").toDateTime();
    d.modificado_en = rec.value("r_modificado_en").toDateTime();
    return d;
}

std::vector<Model::PresupuestoDetalle> PresupuestoDetalleDAO::obtenerPorPresupuesto(const QString& idPresupuesto, QString* error) {
    std::vector<Model::PresupuestoDetalle> lista;
    QSqlQuery query(m_db);

    query.prepare("SELECT "
                  "Id_presupuesto_detalle, Id_presupuesto, Id_subcategoria, "
                  "monto_mensual, observacion, creado_por, modificado_por, creado_en, modificado_en "
                  "FROM Presupuesto_detalle "
                  "WHERE Id_presupuesto = :p_id_presupuesto");
    query.bindValue(":p_id_presupuesto", idPresupuesto);

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error obtener detalles por presupuesto:" << query.lastError().text();
        return lista;
    }

    while (query.next()) {
        QSqlRecord rec = query.record();
        Model::PresupuestoDetalle d;
        d.id_presupuesto_detalle = rec.value("Id_presupuesto_detalle").toString();
        d.id_presupuesto = rec.value("Id_presupuesto").toString();
        d.id_subcategoria = rec.value("Id_subcategoria").toString();
        d.monto_mensual = rec.value("monto_mensual").toDouble();
        d.observacion = rec.value("observacion").toString();
        d.creado_por = rec.value("creado_por").toString();
        d.modificado_por = rec.value("modificado_por").toString();
        d.creado_en = rec.value("creado_en").toDateTime();
        d.modificado_en = rec.value("modificado_en").toDateTime();
        lista.push_back(d);
    }
    return lista;
}
