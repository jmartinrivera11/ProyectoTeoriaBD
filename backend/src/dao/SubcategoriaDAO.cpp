#include "SubcategoriaDAO.h"
#include <QSqlQuery>
#include <QSqlError>
#include <QSqlRecord>
#include <QVariant>
#include <QDebug>

SubcategoriaDAO::SubcategoriaDAO(const QSqlDatabase& db) : m_db(db) {}

bool SubcategoriaDAO::insertar(const Model::Subcategoria& s, QString* error) {
    QSqlQuery query(m_db);
    query.prepare(
        "EXECUTE PROCEDURE sp_insert_subcategoria("
        " :p_id_subcategoria, :p_id_categoria, :p_nombre, :p_descripcion, "
        " :p_activa, :p_es_defecto, :p_creado_por)"
    );

    query.bindValue(":p_id_subcategoria", s.id_subcategoria);
    query.bindValue(":p_id_categoria", s.id_categoria);
    query.bindValue(":p_nombre", s.nombre);
    query.bindValue(":p_descripcion", s.descripcion);
    query.bindValue(":p_activa", s.activa);
    query.bindValue(":p_es_defecto", s.es_defecto);
    query.bindValue(":p_creado_por", s.creado_por.isEmpty() ? QStringLiteral("app") : s.creado_por);

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error insertar subcategoria:" << query.lastError().text();
        return false;
    }
    return true;
}

bool SubcategoriaDAO::actualizar(const Model::Subcategoria& s, QString* error) {
    QSqlQuery query(m_db);
    query.prepare(
        "EXECUTE PROCEDURE sp_update_subcategoria("
        " :p_id_subcategoria, :p_id_categoria, :p_nombre, :p_descripcion, "
        " :p_activa, :p_es_defecto, :p_modificado_por)"
    );

    query.bindValue(":p_id_subcategoria", s.id_subcategoria);
    query.bindValue(":p_id_categoria", s.id_categoria);
    query.bindValue(":p_nombre", s.nombre);
    query.bindValue(":p_descripcion", s.descripcion);
    query.bindValue(":p_activa", s.activa);
    query.bindValue(":p_es_defecto", s.es_defecto);
    query.bindValue(":p_modificado_por", s.modificado_por.isEmpty() ? QStringLiteral("app") : s.modificado_por);

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error actualizar subcategoria:" << query.lastError().text();
        return false;
    }
    return true;
}

bool SubcategoriaDAO::eliminar(const QString& idSubcategoria, QString* error) {
    QSqlQuery query(m_db);
    query.prepare("EXECUTE PROCEDURE sp_delete_subcategoria(:p_id_subcategoria)");
    query.bindValue(":p_id_subcategoria", idSubcategoria);

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error eliminar subcategoria:" << query.lastError().text();
        return false;
    }
    return true;
}

std::optional<Model::Subcategoria> SubcategoriaDAO::obtenerPorId(const QString& idSubcategoria, QString* error) {
    QSqlQuery query(m_db);
    query.prepare("SELECT * FROM sp_get_subcategoria_by_id(:p_id_subcategoria)");
    query.bindValue(":p_id_subcategoria", idSubcategoria);

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error obtener subcategoria por id:" << query.lastError().text();
        return std::nullopt;
    }

    if (!query.next()) {
        return std::nullopt;
    }

    QSqlRecord rec = query.record();
    Model::Subcategoria s;
    s.id_subcategoria = rec.value("r_id_subcategoria").toString();
    s.id_categoria = rec.value("r_id_categoria").toString();
    s.nombre = rec.value("r_nombre").toString();
    s.descripcion = rec.value("r_descripcion").toString();
    s.activa = rec.value("r_activa").toBool();
    s.es_defecto = rec.value("r_es_defecto").toBool();
    s.creado_por = rec.value("r_creado_por").toString();
    s.modificado_por = rec.value("r_modificado_por").toString();
    s.creado_en = rec.value("r_creado_en").toDateTime();
    s.modificado_en = rec.value("r_modificado_en").toDateTime();
    return s;
}

std::vector<Model::Subcategoria> SubcategoriaDAO::obtenerPorCategoria(const QString& idCategoria, QString* error) {
    std::vector<Model::Subcategoria> lista;
    QSqlQuery query(m_db);

    query.prepare("SELECT "
                  "Id_subcategoria, Id_categoria, nombre, descripcion, activa, es_defecto, "
                  "creado_por, modificado_por, creado_en, modificado_en "
                  "FROM Subcategoria "
                  "WHERE Id_categoria = :p_id_categoria");
    query.bindValue(":p_id_categoria", idCategoria);

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error obtener subcategorias por categoria:" << query.lastError().text();
        return lista;
    }

    while (query.next()) {
        QSqlRecord rec = query.record();
        Model::Subcategoria s;
        s.id_subcategoria = rec.value("Id_subcategoria").toString();
        s.id_categoria = rec.value("Id_categoria").toString();
        s.nombre = rec.value("nombre").toString();
        s.descripcion = rec.value("descripcion").toString();
        s.activa = rec.value("activa").toBool();
        s.es_defecto = rec.value("es_defecto").toBool();
        s.creado_por = rec.value("creado_por").toString();
        s.modificado_por = rec.value("modificado_por").toString();
        s.creado_en = rec.value("creado_en").toDateTime();
        s.modificado_en = rec.value("modificado_en").toDateTime();
        lista.push_back(s);
    }
    return lista;
}
