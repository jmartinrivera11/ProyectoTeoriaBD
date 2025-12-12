#include "TransaccionDAO.h"
#include <QSqlQuery>
#include <QSqlError>
#include <QSqlRecord>
#include <QVariant>
#include <QDebug>

TransaccionDAO::TransaccionDAO(const QSqlDatabase& db) : m_db(db) {}

bool TransaccionDAO::insertar(const Model::Transaccion& t, QString* error) {
    QSqlQuery query(m_db);
    query.prepare(
        "EXECUTE PROCEDURE sp_insert_transaccion("
        " :p_id_transaccion, :p_id_usuario, :p_id_presupuesto, :p_id_subcategoria, :p_id_obligacion_fija, "
        " :p_anio, :p_mes, :p_tipo, :p_descripcion, :p_monto, :p_fecha, "
        " :p_metodo_pago, :p_numero_factura, :p_observaciones, :p_creado_por)"
    );

    query.bindValue(":p_id_transaccion", t.id_transaccion);
    query.bindValue(":p_id_usuario", t.id_usuario);
    query.bindValue(":p_id_presupuesto", t.id_presupuesto);
    query.bindValue(":p_id_subcategoria", t.id_subcategoria);
    query.bindValue(":p_id_obligacion_fija", t.id_obligacion_fija);
    query.bindValue(":p_anio", t.anio);
    query.bindValue(":p_mes", t.mes);
    query.bindValue(":p_tipo", t.tipo);
    query.bindValue(":p_descripcion", t.descripcion);
    query.bindValue(":p_monto", t.monto);
    query.bindValue(":p_fecha", t.fecha);
    query.bindValue(":p_metodo_pago", t.metodo_pago);
    query.bindValue(":p_numero_factura", t.numero_factura);
    query.bindValue(":p_observaciones", t.observaciones);
    query.bindValue(":p_creado_por", t.creado_por.isEmpty() ? QStringLiteral("app") : t.creado_por);

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error insertar transaccion:" << query.lastError().text();
        return false;
    }
    return true;
}

bool TransaccionDAO::actualizar(const Model::Transaccion& t, QString* error) {
    QSqlQuery query(m_db);
    query.prepare(
        "EXECUTE PROCEDURE sp_update_transaccion("
        " :p_id_transaccion, :p_anio, :p_mes, :p_tipo, :p_descripcion, :p_monto, :p_fecha, "
        " :p_metodo_pago, :p_numero_factura, :p_observaciones, :p_modificado_por)"
    );

    query.bindValue(":p_id_transaccion", t.id_transaccion);
    query.bindValue(":p_anio", t.anio);
    query.bindValue(":p_mes", t.mes);
    query.bindValue(":p_tipo", t.tipo);
    query.bindValue(":p_descripcion", t.descripcion);
    query.bindValue(":p_monto", t.monto);
    query.bindValue(":p_fecha", t.fecha);
    query.bindValue(":p_metodo_pago", t.metodo_pago);
    query.bindValue(":p_numero_factura", t.numero_factura);
    query.bindValue(":p_observaciones", t.observaciones);
    query.bindValue(":p_modificado_por", t.modificado_por.isEmpty() ? QStringLiteral("app") : t.modificado_por);

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error actualizar transaccion:" << query.lastError().text();
        return false;
    }
    return true;
}

bool TransaccionDAO::eliminar(const QString& idTransaccion, QString* error) {
    QSqlQuery query(m_db);
    query.prepare("EXECUTE PROCEDURE sp_delete_transaccion(:p_id_transaccion)");
    query.bindValue(":p_id_transaccion", idTransaccion);

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error eliminar transaccion:" << query.lastError().text();
        return false;
    }
    return true;
}

std::optional<Model::Transaccion> TransaccionDAO::obtenerPorId(const QString& idTransaccion, QString* error) {
    QSqlQuery query(m_db);
    query.prepare("SELECT * FROM sp_get_transaccion_by_id(:p_id_transaccion)");
    query.bindValue(":p_id_transaccion", idTransaccion);

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error obtener transaccion por id:" << query.lastError().text();
        return std::nullopt;
    }

    if (!query.next()) {
        return std::nullopt;
    }

    QSqlRecord rec = query.record();
    Model::Transaccion t;
    t.id_transaccion = rec.value("r_id_transaccion").toString();
    t.id_usuario = rec.value("r_id_usuario").toString();
    t.id_presupuesto = rec.value("r_id_presupuesto").toString();
    t.id_subcategoria = rec.value("r_id_subcategoria").toString();
    t.id_obligacion_fija = rec.value("r_id_obligacion_fija").toString();
    t.anio = rec.value("r_anio").toInt();
    t.mes = rec.value("r_mes").toInt();
    t.tipo = rec.value("r_tipo").toString();
    t.descripcion = rec.value("r_descripcion").toString();
    t.monto = rec.value("r_monto").toDouble();
    t.fecha = rec.value("r_fecha").toDateTime();
    t.metodo_pago = rec.value("r_metodo_pago").toString();
    t.numero_factura = rec.value("r_numero_factura").toString();
    t.observaciones = rec.value("r_observaciones").toString();
    t.fecha_registro = rec.value("r_fecha_registro").toDateTime();
    t.creado_por = rec.value("r_creado_por").toString();
    t.modificado_por = rec.value("r_modificado_por").toString();
    t.creado_en = rec.value("r_creado_en").toDateTime();
    t.modificado_en = rec.value("r_modificado_en").toDateTime();
    return t;
}

std::vector<Model::Transaccion> TransaccionDAO::obtenerPorPresupuesto(const QString& idPresupuesto, QString* error) {
    std::vector<Model::Transaccion> lista;
    QSqlQuery query(m_db);

    query.prepare("SELECT "
                  "Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija, "
                  "anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, "
                  "observaciones, fecha_registro, creado_por, modificado_por, creado_en, modificado_en "
                  "FROM Transaccion "
                  "WHERE Id_presupuesto = :p_id_presupuesto");
    query.bindValue(":p_id_presupuesto", idPresupuesto);

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error obtener transacciones por presupuesto:" << query.lastError().text();
        return lista;
    }

    while (query.next()) {
        QSqlRecord rec = query.record();
        Model::Transaccion t;
        t.id_transaccion = rec.value("Id_transaccion").toString();
        t.id_usuario = rec.value("Id_usuario").toString();
        t.id_presupuesto = rec.value("Id_presupuesto").toString();
        t.id_subcategoria = rec.value("Id_subcategoria").toString();
        t.id_obligacion_fija = rec.value("Id_obligacion_fija").toString();
        t.anio = rec.value("anio").toInt();
        t.mes = rec.value("mes").toInt();
        t.tipo = rec.value("tipo").toString();
        t.descripcion = rec.value("descripcion").toString();
        t.monto = rec.value("monto").toDouble();
        t.fecha = rec.value("fecha").toDateTime();
        t.metodo_pago = rec.value("metodo_pago").toString();
        t.numero_factura = rec.value("numero_factura").toString();
        t.observaciones = rec.value("observaciones").toString();
        t.fecha_registro = rec.value("fecha_registro").toDateTime();
        t.creado_por = rec.value("creado_por").toString();
        t.modificado_por = rec.value("modificado_por").toString();
        t.creado_en = rec.value("creado_en").toDateTime();
        t.modificado_en = rec.value("modificado_en").toDateTime();
        lista.push_back(t);
    }

    return lista;
}

bool TransaccionDAO::registrarNegocio(const Model::Transaccion& t, QString* error) {
    QSqlQuery query(m_db);
    query.prepare(
        "EXECUTE PROCEDURE sp_registrar_transaccion_negocio("
        " :p_id_transaccion, :p_id_usuario, :p_id_presupuesto, :p_id_subcategoria, :p_id_obligacion_fija, "
        " :p_anio, :p_mes, :p_tipo, :p_descripcion, :p_monto, :p_fecha, "
        " :p_metodo_pago, :p_numero_factura, :p_observaciones, :p_creado_por)"
    );

    query.bindValue(":p_id_transaccion", t.id_transaccion);
    query.bindValue(":p_id_usuario", t.id_usuario);
    query.bindValue(":p_id_presupuesto", t.id_presupuesto);
    query.bindValue(":p_id_subcategoria", t.id_subcategoria);
    query.bindValue(":p_id_obligacion_fija", t.id_obligacion_fija);
    query.bindValue(":p_anio", t.anio);
    query.bindValue(":p_mes", t.mes);
    query.bindValue(":p_tipo", t.tipo);
    query.bindValue(":p_descripcion", t.descripcion);
    query.bindValue(":p_monto", t.monto);
    query.bindValue(":p_fecha", t.fecha);
    query.bindValue(":p_metodo_pago", t.metodo_pago);
    query.bindValue(":p_numero_factura", t.numero_factura);
    query.bindValue(":p_observaciones", t.observaciones);
    query.bindValue(":p_creado_por", t.creado_por.isEmpty() ? QStringLiteral("app") : t.creado_por);

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error registrar transaccion negocio:" << query.lastError().text();
        return false;
    }
    return true;
}

std::vector<ResumenMensual> TransaccionDAO::resumenMensualPorUsuario(const QString& idUsuario, QString* error) {
    std::vector<ResumenMensual> lista;
    QSqlQuery query(m_db);

    query.prepare("SELECT * FROM sp_generar_resumen_mensual_usuario(:p_id_usuario)");
    query.bindValue(":p_id_usuario", idUsuario);

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error resumen mensual por usuario:" << query.lastError().text();
        return lista;
    }

    while (query.next()) {
        QSqlRecord rec = query.record();
        ResumenMensual r;
        r.anio = rec.value("r_anio").toInt();
        r.mes = rec.value("r_mes").toInt();
        r.total_ingresos = rec.value("r_total_ingresos").toDouble();
        r.total_gastos = rec.value("r_total_gastos").toDouble();
        r.total_ahorro = rec.value("r_total_ahorro").toDouble();
        r.saldo_neto = rec.value("r_saldo_neto").toDouble();
        lista.push_back(r);
    }

    return lista;
}

std::vector<ResumenCategoriaPresupuesto> TransaccionDAO::resumenPorPresupuesto(const QString& idPresupuesto, QString* error) {
    std::vector<ResumenCategoriaPresupuesto> lista;
    QSqlQuery query(m_db);

    query.prepare("SELECT * FROM sp_generar_resumen_presupuesto(:p_id_presupuesto)");
    query.bindValue(":p_id_presupuesto", idPresupuesto);

    if (!query.exec()) {
        if (error) *error = query.lastError().text();
        qDebug() << "Error resumen por presupuesto:" << query.lastError().text();
        return lista;
    }

    while (query.next()) {
        QSqlRecord rec = query.record();
        ResumenCategoriaPresupuesto r;
        r.id_categoria = rec.value("r_id_categoria").toString();
        r.nombre_categoria = rec.value("r_nombre_categoria").toString();
        r.tipo_categoria = rec.value("r_tipo_categoria").toString();
        r.total_monto = rec.value("r_total_monto").toDouble();
        lista.push_back(r);
    }

    return lista;
}
