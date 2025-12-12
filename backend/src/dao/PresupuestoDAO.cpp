#include "PresupuestoDAO.h"
#include <QSqlQuery>
#include <QSqlError>
#include <QSqlRecord>
#include <QVariant>
#include <QDebug>

PresupuestoDAO::PresupuestoDAO(const QSqlDatabase& db) : m_db(db) {}

bool PresupuestoDAO::insertar(const Model::Presupuesto& p, QString* error) {
    QSqlQuery query(m_db);
    query.prepare(
        "EXECUTE PROCEDURE sp_insert_presupuesto("
        " :p_id_presupuesto, :p_id_usuario, :p_nombre, "
        " :p_anio_inicio, :p_mes_inicio, :p_anio_fin, :p_mes_fin, "
        " :p_estado, :p_creado_por)"
    );

    query.bindValue(":p_id_presupuesto", p.id_presupuesto);
    query.bindValue(":p_id_usuario", p.id_usuario);
    query.bindValue(":p_nombre", p.nombre);
    query.bindValue(":p_anio_inicio", p.anio_inicio);
    query.bindValue(":p_mes_inicio", p.mes_inicio);
    query.bindValue(":p_anio_fin", p.anio_fin);
    query.bindValue(":p_mes_fin", p.mes_fin);
    query.bindValue(":p_estado", p.estado);
    query.bindValue(":p_creado_por", p.creado_por.isEmpty() ? QStringLiteral("app") : p.creado_por);

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error insertar presupuesto:" << query.lastError().text();
        return false;
    }
    return true;
}

bool PresupuestoDAO::actualizar(const Model::Presupuesto& p, QString* error) {
    QSqlQuery query(m_db);
    query.prepare(
        "EXECUTE PROCEDURE sp_update_presupuesto("
        " :p_id_presupuesto, :p_nombre, :p_anio_inicio, :p_mes_inicio, "
        " :p_anio_fin, :p_mes_fin, :p_estado, :p_modificado_por)"
    );

    query.bindValue(":p_id_presupuesto", p.id_presupuesto);
    query.bindValue(":p_nombre", p.nombre);
    query.bindValue(":p_anio_inicio", p.anio_inicio);
    query.bindValue(":p_mes_inicio", p.mes_inicio);
    query.bindValue(":p_anio_fin", p.anio_fin);
    query.bindValue(":p_mes_fin", p.mes_fin);
    query.bindValue(":p_estado", p.estado);
    query.bindValue(":p_modificado_por", p.modificado_por.isEmpty() ? QStringLiteral("app") : p.modificado_por);

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error actualizar presupuesto:" << query.lastError().text();
        return false;
    }
    return true;
}

bool PresupuestoDAO::eliminar(const QString& idPresupuesto, QString* error) {
    QSqlQuery query(m_db);
    query.prepare("EXECUTE PROCEDURE sp_delete_presupuesto(:p_id_presupuesto)");
    query.bindValue(":p_id_presupuesto", idPresupuesto);

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error eliminar presupuesto:" << query.lastError().text();
        return false;
    }
    return true;
}

std::optional<Model::Presupuesto> PresupuestoDAO::obtenerPorId(const QString& idPresupuesto, QString* error) {
    QSqlQuery query(m_db);
    query.prepare("SELECT * FROM sp_get_presupuesto_by_id(:p_id_presupuesto)");
    query.bindValue(":p_id_presupuesto", idPresupuesto);

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error obtener presupuesto por id:" << query.lastError().text();
        return std::nullopt;
    }

    if (!query.next()) {
        return std::nullopt;
    }

    QSqlRecord rec = query.record();
    Model::Presupuesto p;
    p.id_presupuesto = rec.value("r_id_presupuesto").toString();
    p.id_usuario = rec.value("r_id_usuario").toString();
    p.nombre = rec.value("r_nombre").toString();
    p.anio_inicio = rec.value("r_anio_inicio").toInt();
    p.mes_inicio = rec.value("r_mes_inicio").toInt();
    p.anio_fin = rec.value("r_anio_fin").toInt();
    p.mes_fin = rec.value("r_mes_fin").toInt();
    p.total_ingresos = rec.value("r_total_ingresos").toDouble();
    p.total_gastos = rec.value("r_total_gastos").toDouble();
    p.total_ahorro = rec.value("r_total_ahorro").toDouble();
    p.fecha_creacion = rec.value("r_fecha_creacion").toDateTime();
    p.estado = rec.value("r_estado").toString();
    p.creado_por = rec.value("r_creado_por").toString();
    p.modificado_por = rec.value("r_modificado_por").toString();
    p.creado_en = rec.value("r_creado_en").toDateTime();
    p.modificado_en = rec.value("r_modificado_en").toDateTime();
    return p;
}

std::vector<Model::Presupuesto> PresupuestoDAO::obtenerPorUsuario(const QString& idUsuario, QString* error) {
    std::vector<Model::Presupuesto> lista;
    QSqlQuery query(m_db);

    query.prepare("SELECT "
                  "Id_presupuesto, Id_usuario, nombre, anio_inicio, mes_inicio, anio_fin, mes_fin, "
                  "total_ingresos, total_gastos, total_ahorro, fecha_creacion, estado, "
                  "creado_por, modificado_por, creado_en, modificado_en "
                  "FROM Presupuesto "
                  "WHERE Id_usuario = :p_id_usuario");
    query.bindValue(":p_id_usuario", idUsuario);

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error obtener presupuestos por usuario:" << query.lastError().text();
        return lista;
    }

    while (query.next()) {
        QSqlRecord rec = query.record();
        Model::Presupuesto p;
        p.id_presupuesto = rec.value("Id_presupuesto").toString();
        p.id_usuario = rec.value("Id_usuario").toString();
        p.nombre = rec.value("nombre").toString();
        p.anio_inicio = rec.value("anio_inicio").toInt();
        p.mes_inicio = rec.value("mes_inicio").toInt();
        p.anio_fin = rec.value("anio_fin").toInt();
        p.mes_fin = rec.value("mes_fin").toInt();
        p.total_ingresos = rec.value("total_ingresos").toDouble();
        p.total_gastos = rec.value("total_gastos").toDouble();
        p.total_ahorro = rec.value("total_ahorro").toDouble();
        p.fecha_creacion = rec.value("fecha_creacion").toDateTime();
        p.estado = rec.value("estado").toString();
        p.creado_por = rec.value("creado_por").toString();
        p.modificado_por = rec.value("modificado_por").toString();
        p.creado_en = rec.value("creado_en").toDateTime();
        p.modificado_en = rec.value("modificado_en").toDateTime();
        lista.push_back(p);
    }
    return lista;
}

bool PresupuestoDAO::recalcularTotales(const QString& idPresupuesto, QString* error) {
    QSqlQuery query(m_db);
    query.prepare("EXECUTE PROCEDURE sp_recalcular_totales_presupuesto(:p_id_presupuesto)");
    query.bindValue(":p_id_presupuesto", idPresupuesto);

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error recalcular totales presupuesto:" << query.lastError().text();
        return false;
    }
    return true;
}

bool PresupuestoDAO::cerrarPresupuesto(const QString& idPresupuesto, const QString& usuario, QString* error) {
    QSqlQuery query(m_db);
    query.prepare("EXECUTE PROCEDURE sp_cerrar_presupuesto(:p_id_presupuesto, :p_modificado_por)");
    query.bindValue(":p_id_presupuesto", idPresupuesto);
    query.bindValue(":p_modificado_por", usuario.isEmpty() ? QStringLiteral("app") : usuario);

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error cerrar presupuesto:" << query.lastError().text();
        return false;
    }
    return true;
}

bool PresupuestoDAO::reabrirPresupuesto(const QString& idPresupuesto, const QString& usuario, QString* error) {
    QSqlQuery query(m_db);
    query.prepare("EXECUTE PROCEDURE sp_reabrir_presupuesto(:p_id_presupuesto, :p_modificado_por)");
    query.bindValue(":p_id_presupuesto", idPresupuesto);
    query.bindValue(":p_modificado_por", usuario.isEmpty() ? QStringLiteral("app") : usuario);

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error reabrir presupuesto:" << query.lastError().text();
        return false;
    }
    return true;
}
