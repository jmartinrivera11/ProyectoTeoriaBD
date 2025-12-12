#include <QString>
#include <optional>
#include <vector>
#include <QSqlDatabase>
#include "../models/Transaccion.h"

struct ResumenMensual {
    int anio = 0;
    int mes = 0;
    double total_ingresos = 0.0;
    double total_gastos = 0.0;
    double total_ahorro = 0.0;
    double saldo_neto = 0.0;
};

struct ResumenCategoriaPresupuesto {
    QString id_categoria;
    QString nombre_categoria;
    QString tipo_categoria;
    double total_monto = 0.0;
};

class TransaccionDAO {
public:
    explicit TransaccionDAO(const QSqlDatabase& db);
    bool insertar(const Model::Transaccion& t, QString* error = nullptr);
    bool actualizar(const Model::Transaccion& t, QString* error = nullptr);
    bool eliminar(const QString& idTransaccion, QString* error = nullptr);
    std::optional<Model::Transaccion> obtenerPorId(const QString& idTransaccion, QString* error = nullptr);
    std::vector<Model::Transaccion> obtenerPorPresupuesto(const QString& idPresupuesto, QString* error = nullptr);
    bool registrarNegocio(const Model::Transaccion& t, QString* error = nullptr);
    std::vector<ResumenMensual> resumenMensualPorUsuario(const QString& idUsuario, QString* error = nullptr);
    std::vector<ResumenCategoriaPresupuesto> resumenPorPresupuesto(const QString& idPresupuesto, QString* error = nullptr);

private:
    QSqlDatabase m_db;
};
