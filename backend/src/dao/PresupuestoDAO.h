#include <QString>
#include <optional>
#include <vector>
#include <QSqlDatabase>
#include "../models/Presupuesto.h"

class PresupuestoDAO {
public:
    explicit PresupuestoDAO(const QSqlDatabase& db);
    bool insertar(const Model::Presupuesto& p, QString* error = nullptr);
    bool actualizar(const Model::Presupuesto& p, QString* error = nullptr);
    bool eliminar(const QString& idPresupuesto, QString* error = nullptr);
    std::optional<Model::Presupuesto> obtenerPorId(const QString& idPresupuesto, QString* error = nullptr);
    std::vector<Model::Presupuesto> obtenerPorUsuario(const QString& idUsuario, QString* error = nullptr);
    bool recalcularTotales(const QString& idPresupuesto, QString* error = nullptr);
    bool cerrarPresupuesto(const QString& idPresupuesto, const QString& usuario, QString* error = nullptr);
    bool reabrirPresupuesto(const QString& idPresupuesto, const QString& usuario, QString* error = nullptr);

private:
    QSqlDatabase m_db;
};
