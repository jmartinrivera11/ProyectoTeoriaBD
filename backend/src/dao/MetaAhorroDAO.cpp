#include "MetaAhorroDAO.h"
#include <QSqlQuery>
#include <QSqlError>
#include <QSqlRecord>
#include <QVariant>
#include <QDebug>

MetaAhorroDAO::MetaAhorroDAO(const QSqlDatabase& db) : m_db(db) {}

bool MetaAhorroDAO::insertar(const Model::MetaAhorro& m, QString* error) {
    QSqlQuery query(m_db);
    query.prepare(
        "EXECUTE PROCEDURE sp_insert_meta_ahorro("
        " :p_id_meta_ahorro, :p_id_usuario, :p_id_subcategoria, :p_nombre, :p_descripcion, "
        " :p_monto_total, :p_monto_ahorrado, :p_fecha_inicio, :p_fecha_objetivo, "
        " :p_prioridad, :p_estado, :p_creado_por)"
    );

    query.bindValue(":p_id_meta_ahorro", m.id_meta_ahorro);
    query.bindValue(":p_id_usuario", m.id_usuario);
    query.bindValue(":p_id_subcategoria", m.id_subcategoria);
    query.bindValue(":p_nombre", m.nombre);
    query.bindValue(":p_descripcion", m.descripcion);
    query.bindValue(":p_monto_total", m.monto_total);
    query.bindValue(":p_monto_ahorrado", m.monto_ahorrado);
    query.bindValue(":p_fecha_inicio", m.fecha_inicio);
    query.bindValue(":p_fecha_objetivo", m.fecha_objetivo);
    query.bindValue(":p_prioridad", m.prioridad);
    query.bindValue(":p_estado", m.estado);
    query.bindValue(":p_creado_por", m.creado_por.isEmpty() ? QStringLiteral("app") : m.creado_por);

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error insertar meta_ahorro:" << query.lastError().text();
        return false;
    }
    return true;
}

bool MetaAhorroDAO::actualizar(const Model::MetaAhorro& m, QString* error) {
    QSqlQuery query(m_db);
    query.prepare(
        "EXECUTE PROCEDURE sp_update_meta_ahorro("
        " :p_id_meta_ahorro, :p_nombre, :p_descripcion, :p_monto_total, :p_monto_ahorrado, "
        " :p_fecha_objetivo, :p_prioridad, :p_estado, :p_modificado_por)"
    );

    query.bindValue(":p_id_meta_ahorro", m.id_meta_ahorro);
    query.bindValue(":p_nombre", m.nombre);
    query.bindValue(":p_descripcion", m.descripcion);
    query.bindValue(":p_monto_total", m.monto_total);
    query.bindValue(":p_monto_ahorrado", m.monto_ahorrado);
    query.bindValue(":p_fecha_objetivo", m.fecha_objetivo);
    query.bindValue(":p_prioridad", m.prioridad);
    query.bindValue(":p_estado", m.estado);
    query.bindValue(":p_modificado_por", m.modificado_por.isEmpty() ? QStringLiteral("app") : m.modificado_por);

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error actualizar meta_ahorro:" << query.lastError().text();
        return false;
    }
    return true;
}

bool MetaAhorroDAO::eliminar(const QString& idMeta, QString* error) {
    QSqlQuery query(m_db);
    query.prepare("EXECUTE PROCEDURE sp_delete_meta_ahorro(:p_id_meta_ahorro)");
    query.bindValue(":p_id_meta_ahorro", idMeta);

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error eliminar meta_ahorro:" << query.lastError().text();
        return false;
    }
    return true;
}

std::optional<Model::MetaAhorro> MetaAhorroDAO::obtenerPorId(const QString& idMeta, QString* error) {
    QSqlQuery query(m_db);
    query.prepare("SELECT * FROM sp_get_meta_ahorro_by_id(:p_id_meta_ahorro)");
    query.bindValue(":p_id_meta_ahorro", idMeta);

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error obtener meta_ahorro por id:" << query.lastError().text();
        return std::nullopt;
    }

    if (!query.next()) {
        return std::nullopt;
    }

    QSqlRecord rec = query.record();
    Model::MetaAhorro m;
    m.id_meta_ahorro = rec.value("r_id_meta_ahorro").toString();
    m.id_usuario = rec.value("r_id_usuario").toString();
    m.id_subcategoria = rec.value("r_id_subcategoria").toString();
    m.nombre = rec.value("r_nombre").toString();
    m.descripcion = rec.value("r_descripcion").toString();
    m.monto_total = rec.value("r_monto_total").toDouble();
    m.monto_ahorrado = rec.value("r_monto_ahorrado").toDouble();
    m.fecha_inicio = rec.value("r_fecha_inicio").toDateTime();
    m.fecha_objetivo = rec.value("r_fecha_objetivo").toDateTime();
    m.prioridad = rec.value("r_prioridad").toString();
    m.estado = rec.value("r_estado").toString();
    m.creado_por = rec.value("r_creado_por").toString();
    m.modificado_por = rec.value("r_modificado_por").toString();
    m.creado_en = rec.value("r_creado_en").toDateTime();
    m.modificado_en = rec.value("r_modificado_en").toDateTime();
    return m;
}

std::optional<Model::MetaAhorro> MetaAhorroDAO::obtenerPorNombreUsuario(const QString& idUsuario, const QString& nombre, QString* error) {
    QSqlQuery query(m_db);
    query.prepare("SELECT * FROM sp_get_meta_ahorro_por_nombre_usuario(:p_id_usuario, :p_nombre)");
    query.bindValue(":p_id_usuario", idUsuario);
    query.bindValue(":p_nombre", nombre);

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error obtener meta_ahorro por nombre/usuario:" << query.lastError().text();
        return std::nullopt;
    }

    if (!query.next()) {
        return std::nullopt;
    }

    QSqlRecord rec = query.record();
    Model::MetaAhorro m;
    m.id_meta_ahorro = rec.value("r_id_meta_ahorro").toString();
    m.id_subcategoria = rec.value("r_id_subcategoria").toString();
    m.nombre = rec.value("r_nombre").toString();
    m.monto_total = rec.value("r_monto_total").toDouble();
    m.monto_ahorrado = rec.value("r_monto_ahorrado").toDouble();
    m.estado = rec.value("r_estado").toString();
    m.id_usuario = idUsuario;
    return m;
}

std::vector<Model::MetaAhorro> MetaAhorroDAO::obtenerPorUsuario(const QString& idUsuario, QString* error) {
    std::vector<Model::MetaAhorro> lista;
    QSqlQuery query(m_db);

    query.prepare("SELECT "
                  "Id_meta_ahorro, Id_usuario, Id_subcategoria, nombre, descripcion, "
                  "monto_total, monto_ahorrado, fecha_inicio, fecha_objetivo, "
                  "prioridad, estado, creado_por, modificado_por, creado_en, modificado_en "
                  "FROM Meta_ahorro "
                  "WHERE Id_usuario = :p_id_usuario");
    query.bindValue(":p_id_usuario", idUsuario);

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error obtener metas por usuario:" << query.lastError().text();
        return lista;
    }

    while (query.next()) {
        QSqlRecord rec = query.record();
        Model::MetaAhorro m;
        m.id_meta_ahorro = rec.value("Id_meta_ahorro").toString();
        m.id_usuario = rec.value("Id_usuario").toString();
        m.id_subcategoria = rec.value("Id_subcategoria").toString();
        m.nombre = rec.value("nombre").toString();
        m.descripcion = rec.value("descripcion").toString();
        m.monto_total = rec.value("monto_total").toDouble();
        m.monto_ahorrado = rec.value("monto_ahorrado").toDouble();
        m.fecha_inicio = rec.value("fecha_inicio").toDateTime();
        m.fecha_objetivo = rec.value("fecha_objetivo").toDateTime();
        m.prioridad = rec.value("prioridad").toString();
        m.estado = rec.value("estado").toString();
        m.creado_por = rec.value("creado_por").toString();
        m.modificado_por = rec.value("modificado_por").toString();
        m.creado_en = rec.value("creado_en").toDateTime();
        m.modificado_en = rec.value("modificado_en").toDateTime();
        lista.push_back(m);
    }
    return lista;
}

bool MetaAhorroDAO::aplicarAporte(const QString& idMeta, double monto, const QString& usuario, QString* error) {
    QSqlQuery query(m_db);
    query.prepare("EXECUTE PROCEDURE sp_aplicar_aporte_meta(:p_id_meta_ahorro, :p_monto_aporte, :p_modificado_por)");
    query.bindValue(":p_id_meta_ahorro", idMeta);
    query.bindValue(":p_monto_aporte", monto);
    query.bindValue(":p_modificado_por", usuario.isEmpty() ? QStringLiteral("app") : usuario);

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error aplicar aporte meta:" << query.lastError().text();
        return false;
    }
    return true;
}

bool MetaAhorroDAO::recalcularEstado(const QString& idMeta, const QString& usuario, QString* error) {
    QSqlQuery query(m_db);
    query.prepare("EXECUTE PROCEDURE sp_recalcular_estado_meta(:p_id_meta_ahorro, :p_modificado_por)");
    query.bindValue(":p_id_meta_ahorro", idMeta);
    query.bindValue(":p_modificado_por", usuario.isEmpty() ? QStringLiteral("app") : usuario);

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error recalcular estado meta:" << query.lastError().text();
        return false;
    }
    return true;
}
