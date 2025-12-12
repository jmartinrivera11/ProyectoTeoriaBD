#include "ObligacionFijaDAO.h"
#include <QSqlQuery>
#include <QSqlError>
#include <QSqlRecord>
#include <QVariant>
#include <QDebug>

ObligacionFijaDAO::ObligacionFijaDAO(const QSqlDatabase& db) : m_db(db) {}

bool ObligacionFijaDAO::insertar(const Model::ObligacionFija& o, QString* error) {
    QSqlQuery query(m_db);
    query.prepare(
        "EXECUTE PROCEDURE sp_insert_obligacion_fija("
        " :p_id_obligacion_fija, :p_id_subcategoria, :p_id_usuario, :p_nombre, :p_descripcion, "
        " :p_monto_mensual, :p_dia_mes, :p_vigente, :p_fecha_inicio, :p_fecha_fin, :p_creado_por)"
    );

    query.bindValue(":p_id_obligacion_fija", o.id_obligacion_fija);
    query.bindValue(":p_id_subcategoria", o.id_subcategoria);
    query.bindValue(":p_id_usuario", o.id_usuario);
    query.bindValue(":p_nombre", o.nombre);
    query.bindValue(":p_descripcion", o.descripcion);
    query.bindValue(":p_monto_mensual", o.monto_mensual);
    query.bindValue(":p_dia_mes", o.dia_mes);
    query.bindValue(":p_vigente", o.vigente);
    query.bindValue(":p_fecha_inicio", o.fecha_inicio);
    query.bindValue(":p_fecha_fin", o.fecha_fin);
    query.bindValue(":p_creado_por", o.creado_por.isEmpty() ? QStringLiteral("app") : o.creado_por);

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error insertar obligacion_fija:" << query.lastError().text();
        return false;
    }
    return true;
}

bool ObligacionFijaDAO::actualizar(const Model::ObligacionFija& o, QString* error) {
    QSqlQuery query(m_db);
    query.prepare(
        "EXECUTE PROCEDURE sp_update_obligacion_fija("
        " :p_id_obligacion_fija, :p_nombre, :p_descripcion, :p_monto_mensual, "
        " :p_dia_mes, :p_vigente, :p_fecha_fin, :p_modificado_por)"
    );

    query.bindValue(":p_id_obligacion_fija", o.id_obligacion_fija);
    query.bindValue(":p_nombre", o.nombre);
    query.bindValue(":p_descripcion", o.descripcion);
    query.bindValue(":p_monto_mensual", o.monto_mensual);
    query.bindValue(":p_dia_mes", o.dia_mes);
    query.bindValue(":p_vigente", o.vigente);
    query.bindValue(":p_fecha_fin", o.fecha_fin);
    query.bindValue(":p_modificado_por", o.modificado_por.isEmpty() ? QStringLiteral("app") : o.modificado_por);

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error actualizar obligacion_fija:" << query.lastError().text();
        return false;
    }
    return true;
}

bool ObligacionFijaDAO::eliminar(const QString& idObligacion, QString* error) {
    QSqlQuery query(m_db);
    query.prepare("EXECUTE PROCEDURE sp_delete_obligacion_fija(:p_id_obligacion_fija)");
    query.bindValue(":p_id_obligacion_fija", idObligacion);

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error eliminar obligacion_fija:" << query.lastError().text();
        return false;
    }
    return true;
}

std::optional<Model::ObligacionFija> ObligacionFijaDAO::obtenerPorId(const QString& idObligacion, QString* error) {
    QSqlQuery query(m_db);
    query.prepare("SELECT * FROM sp_get_obligacion_fija_by_id(:p_id_obligacion_fija)");
    query.bindValue(":p_id_obligacion_fija", idObligacion);

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error obtener obligacion_fija por id:" << query.lastError().text();
        return std::nullopt;
    }

    if (!query.next()) {
        return std::nullopt;
    }
    QSqlRecord rec = query.record();
    Model::ObligacionFija o;
    o.id_obligacion_fija = rec.value("r_id_obligacion_fija").toString();
    o.id_subcategoria = rec.value("r_id_subcategoria").toString();
    o.id_usuario = rec.value("r_id_usuario").toString();
    o.nombre = rec.value("r_nombre").toString();
    o.descripcion = rec.value("r_descripcion").toString();
    o.monto_mensual = rec.value("r_monto_mensual").toDouble();
    o.dia_mes = rec.value("r_dia_mes").toInt();
    o.vigente = rec.value("r_vigente").toBool();
    o.fecha_inicio = rec.value("r_fecha_inicio").toDateTime();
    o.fecha_fin = rec.value("r_fecha_fin").toDateTime();
    o.creado_por = rec.value("r_creado_por").toString();
    o.modificado_por = rec.value("r_modificado_por").toString();
    o.creado_en = rec.value("r_creado_en").toDateTime();
    o.modificado_en = rec.value("r_modificado_en").toDateTime();
    return o;
}

std::vector<Model::ObligacionFija> ObligacionFijaDAO::obtenerPorUsuario(const QString& idUsuario, QString* error) {
    std::vector<Model::ObligacionFija> lista;
    QSqlQuery query(m_db);

    query.prepare("SELECT "
                  "Id_obligacion_fija, Id_subcategoria, Id_usuario, nombre, descripcion, "
                  "monto_mensual, dia_mes, vigente, fecha_inicio, fecha_fin, "
                  "creado_por, modificado_por, creado_en, modificado_en "
                  "FROM Obligacion_fija "
                  "WHERE Id_usuario = :p_id_usuario");
    query.bindValue(":p_id_usuario", idUsuario);

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error obtener obligaciones por usuario:" << query.lastError().text();
        return lista;
    }

    while (query.next()) {
        QSqlRecord rec = query.record();
        Model::ObligacionFija o;
        o.id_obligacion_fija = rec.value("Id_obligacion_fija").toString();
        o.id_subcategoria = rec.value("Id_subcategoria").toString();
        o.id_usuario = rec.value("Id_usuario").toString();
        o.nombre = rec.value("nombre").toString();
        o.descripcion = rec.value("descripcion").toString();
        o.monto_mensual = rec.value("monto_mensual").toDouble();
        o.dia_mes = rec.value("dia_mes").toInt();
        o.vigente = rec.value("vigente").toBool();
        o.fecha_inicio = rec.value("fecha_inicio").toDateTime();
        o.fecha_fin = rec.value("fecha_fin").toDateTime();
        o.creado_por = rec.value("creado_por").toString();
        o.modificado_por = rec.value("modificado_por").toString();
        o.creado_en = rec.value("creado_en").toDateTime();
        o.modificado_en = rec.value("modificado_en").toDateTime();
        lista.push_back(o);
    }
    return lista;
}

bool ObligacionFijaDAO::actualizarVigenciaGlobal(QString* error) {
    QSqlQuery query(m_db);
    query.prepare("EXECUTE PROCEDURE sp_actualizar_vigencia_obligaciones");

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error actualizar vigencia obligaciones:" << query.lastError().text();
        return false;
    }
    return true;
}
