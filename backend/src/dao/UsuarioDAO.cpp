#include "UsuarioDAO.h"
#include <QSqlQuery>
#include <QSqlError>
#include <QVariant>
#include <QSqlRecord>
#include <QDebug>

UsuarioDAO::UsuarioDAO(const QSqlDatabase& db) : m_db(db) {}

bool UsuarioDAO::insertar(const Model::Usuario& usuario, QString* error) {
    QSqlQuery query(m_db);
    query.prepare(
        "EXECUTE PROCEDURE sp_insert_usuario("
        " :p_id_usuario, :p_nombre, :p_apellido, :p_correo, "
        " :p_salario_mensual_base, :p_estado, :p_creado_por)"
    );

    query.bindValue(":p_id_usuario", usuario.id_usuario);
    query.bindValue(":p_nombre", usuario.nombre);
    query.bindValue(":p_apellido", usuario.apellido);
    query.bindValue(":p_correo", usuario.correo);
    query.bindValue(":p_salario_mensual_base", usuario.salario_mensual_base);
    query.bindValue(":p_estado", usuario.estado);
    query.bindValue(":p_creado_por", usuario.creado_por.isEmpty()
                                      ? QStringLiteral("app")
                                      : usuario.creado_por);

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error insertar usuario:" << query.lastError().text();
        return false;
    }

    return true;
}

bool UsuarioDAO::actualizar(const Model::Usuario& usuario, QString* error) {
    QSqlQuery query(m_db);
    query.prepare(
        "EXECUTE PROCEDURE sp_update_usuario("
        " :p_id_usuario, :p_nombre, :p_apellido, :p_correo, "
        " :p_salario_mensual_base, :p_estado, :p_modificado_por)"
    );

    query.bindValue(":p_id_usuario", usuario.id_usuario);
    query.bindValue(":p_nombre", usuario.nombre);
    query.bindValue(":p_apellido", usuario.apellido);
    query.bindValue(":p_correo", usuario.correo);
    query.bindValue(":p_salario_mensual_base", usuario.salario_mensual_base);
    query.bindValue(":p_estado", usuario.estado);
    query.bindValue(":p_modificado_por", usuario.modificado_por.isEmpty()
                                         ? QStringLiteral("app")
                                         : usuario.modificado_por);

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error actualizar usuario:" << query.lastError().text();
        return false;
    }

    return true;
}

bool UsuarioDAO::eliminar(const QString& idUsuario, QString* error) {
    QSqlQuery query(m_db);
    query.prepare("EXECUTE PROCEDURE sp_delete_usuario(:p_id_usuario)");
    query.bindValue(":p_id_usuario", idUsuario);

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error eliminar usuario:" << query.lastError().text();
        return false;
    }

    return true;
}

std::optional<Model::Usuario> UsuarioDAO::obtenerPorId(const QString& idUsuario, QString* error) {
    QSqlQuery query(m_db);
    query.prepare("SELECT * FROM sp_get_usuario_by_id(:p_id_usuario)");
    query.bindValue(":p_id_usuario", idUsuario);

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error obtener usuario por id:" << query.lastError().text();
        return std::nullopt;
    }

    if (!query.next()) {
        return std::nullopt;
    }

    QSqlRecord rec = query.record();
    Model::Usuario u;
    u.id_usuario = rec.value("r_id_usuario").toString();
    u.nombre = rec.value("r_nombre").toString();
    u.apellido = rec.value("r_apellido").toString();
    u.correo = rec.value("r_correo").toString();
    u.fecha_registro = rec.value("r_fecha_registro").toDateTime();
    u.salario_mensual_base = rec.value("r_salario_mensual_base").toDouble();
    u.estado = rec.value("r_estado").toString();
    u.creado_por = rec.value("r_creado_por").toString();
    u.modificado_por = rec.value("r_modificado_por").toString();
    u.creado_en = rec.value("r_creado_en").toDateTime();
    u.modificado_en = rec.value("r_modificado_en").toDateTime();
    return u;
}

std::optional<Model::Usuario> UsuarioDAO::obtenerPorCorreo(const QString& correo, QString* error) {
    QSqlQuery query(m_db);
    query.prepare("SELECT * FROM sp_get_usuario_por_correo(:p_correo)");
    query.bindValue(":p_correo", correo);

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error obtener usuario por correo:" << query.lastError().text();
        return std::nullopt;
    }

    if (!query.next()) {
        return std::nullopt;
    }

    QSqlRecord rec = query.record();
    Model::Usuario u;
    u.id_usuario = rec.value("r_id_usuario").toString();
    u.nombre = rec.value("r_nombre").toString();
    u.apellido = rec.value("r_apellido").toString();
    u.correo = rec.value("r_correo").toString();
    u.fecha_registro = rec.value("r_fecha_registro").toDateTime();
    u.salario_mensual_base = rec.value("r_salario_mensual_base").toDouble();
    u.estado = rec.value("r_estado").toString();
    return u;
}

std::vector<Model::Usuario> UsuarioDAO::obtenerTodos(QString* error) {
    std::vector<Model::Usuario> usuarios;

    QSqlQuery query(m_db);
    if (!query.exec("SELECT "
                    "Id_usuario, nombre, apellido, correo, fecha_registro, "
                    "salario_mensual_base, estado, creado_por, modificado_por, "
                    "creado_en, modificado_en "
                    "FROM Usuario")) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error obtener todos los usuarios:" << query.lastError().text();
        return usuarios;
    }

    while (query.next()) {
        QSqlRecord rec = query.record();
        Model::Usuario u;
        u.id_usuario = rec.value("Id_usuario").toString();
        u.nombre = rec.value("nombre").toString();
        u.apellido = rec.value("apellido").toString();
        u.correo = rec.value("correo").toString();
        u.fecha_registro = rec.value("fecha_registro").toDateTime();
        u.salario_mensual_base = rec.value("salario_mensual_base").toDouble();
        u.estado = rec.value("estado").toString();
        u.creado_por = rec.value("creado_por").toString();
        u.modificado_por = rec.value("modificado_por").toString();
        u.creado_en = rec.value("creado_en").toDateTime();
        u.modificado_en = rec.value("modificado_en").toDateTime();
        usuarios.push_back(u);
    }

    return usuarios;
}
