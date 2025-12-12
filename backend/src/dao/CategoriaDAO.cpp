#include "CategoriaDAO.h"
#include <QSqlQuery>
#include <QSqlError>
#include <QSqlRecord>
#include <QVariant>
#include <QDebug>

CategoriaDAO::CategoriaDAO(const QSqlDatabase& db) : m_db(db) {}

bool CategoriaDAO::insertar(const Model::Categoria& c, QString* error) {
    QSqlQuery query(m_db);
    query.prepare(
        "EXECUTE PROCEDURE sp_insert_categoria("
        " :p_id_categoria, :p_nombre, :p_descripcion, :p_tipo, "
        " :p_icono, :p_color_hex, :p_orden, :p_creado_por)"
    );

    query.bindValue(":p_id_categoria", c.id_categoria);
    query.bindValue(":p_nombre", c.nombre);
    query.bindValue(":p_descripcion", c.descripcion);
    query.bindValue(":p_tipo", c.tipo);
    query.bindValue(":p_icono", c.icono);
    query.bindValue(":p_color_hex", c.color_hex);
    query.bindValue(":p_orden", c.orden);
    query.bindValue(":p_creado_por", c.creado_por.isEmpty() ? QStringLiteral("app") : c.creado_por);

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error insertar categoria:" << query.lastError().text();
        return false;
    }
    return true;
}

bool CategoriaDAO::actualizar(const Model::Categoria& c, QString* error) {
    QSqlQuery query(m_db);
    query.prepare(
        "EXECUTE PROCEDURE sp_update_categoria("
        " :p_id_categoria, :p_nombre, :p_descripcion, :p_tipo, "
        " :p_icono, :p_color_hex, :p_orden, :p_modificado_por)"
    );

    query.bindValue(":p_id_categoria", c.id_categoria);
    query.bindValue(":p_nombre", c.nombre);
    query.bindValue(":p_descripcion", c.descripcion);
    query.bindValue(":p_tipo", c.tipo);
    query.bindValue(":p_icono", c.icono);
    query.bindValue(":p_color_hex", c.color_hex);
    query.bindValue(":p_orden", c.orden);
    query.bindValue(":p_modificado_por", c.modificado_por.isEmpty() ? QStringLiteral("app") : c.modificado_por);

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error actualizar categoria:" << query.lastError().text();
        return false;
    }
    return true;
}

bool CategoriaDAO::eliminar(const QString& idCategoria, QString* error) {
    QSqlQuery query(m_db);
    query.prepare("EXECUTE PROCEDURE sp_delete_categoria(:p_id_categoria)");
    query.bindValue(":p_id_categoria", idCategoria);

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error eliminar categoria:" << query.lastError().text();
        return false;
    }
    return true;
}

std::optional<Model::Categoria> CategoriaDAO::obtenerPorId(const QString& idCategoria, QString* error) {
    QSqlQuery query(m_db);
    query.prepare("SELECT * FROM sp_get_categoria_by_id(:p_id_categoria)");
    query.bindValue(":p_id_categoria", idCategoria);

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error obtener categoria por id:" << query.lastError().text();
        return std::nullopt;
    }

    if (!query.next()) {
        return std::nullopt;
    }

    QSqlRecord rec = query.record();
    Model::Categoria c;
    c.id_categoria = rec.value("r_id_categoria").toString();
    c.nombre = rec.value("r_nombre").toString();
    c.descripcion = rec.value("r_descripcion").toString();
    c.tipo = rec.value("r_tipo").toString();
    c.icono = rec.value("r_icono").toString();
    c.color_hex = rec.value("r_color_hex").toString();
    c.orden = rec.value("r_orden").toInt();
    c.creado_por = rec.value("r_creado_por").toString();
    c.modificado_por = rec.value("r_modificado_por").toString();
    c.creado_en = rec.value("r_creado_en").toDateTime();
    c.modificado_en = rec.value("r_modificado_en").toDateTime();
    return c;
}

std::optional<Model::Categoria> CategoriaDAO::obtenerPorNombre(const QString& nombre, QString* error) {
    QSqlQuery query(m_db);
    query.prepare("SELECT * FROM sp_get_categoria_por_nombre(:p_nombre)");
    query.bindValue(":p_nombre", nombre);

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error obtener categoria por nombre:" << query.lastError().text();
        return std::nullopt;
    }

    if (!query.next()) {
        return std::nullopt;
    }

    QSqlRecord rec = query.record();
    Model::Categoria c;
    c.id_categoria = rec.value("r_id_categoria").toString();
    c.nombre = rec.value("r_nombre").toString();
    c.descripcion = rec.value("r_descripcion").toString();
    c.tipo = rec.value("r_tipo").toString();
    return c;
}

std::vector<Model::Categoria> CategoriaDAO::obtenerTodas(QString* error) {
    std::vector<Model::Categoria> categorias;
    QSqlQuery query(m_db);

    if (!query.exec("SELECT "
                    "Id_categoria, nombre, descripcion, tipo, icono, color_hex, orden, "
                    "creado_por, modificado_por, creado_en, modificado_en "
                    "FROM Categoria")) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error obtener todas las categorias:" << query.lastError().text();
        return categorias;
    }

    while (query.next()) {
        QSqlRecord rec = query.record();
        Model::Categoria c;
        c.id_categoria = rec.value("Id_categoria").toString();
        c.nombre = rec.value("nombre").toString();
        c.descripcion = rec.value("descripcion").toString();
        c.tipo = rec.value("tipo").toString();
        c.icono = rec.value("icono").toString();
        c.color_hex = rec.value("color_hex").toString();
        c.orden = rec.value("orden").toInt();
        c.creado_por = rec.value("creado_por").toString();
        c.modificado_por = rec.value("modificado_por").toString();
        c.creado_en = rec.value("creado_en").toDateTime();
        c.modificado_en = rec.value("modificado_en").toDateTime();
        categorias.push_back(c);
    }

    return categorias;
}
