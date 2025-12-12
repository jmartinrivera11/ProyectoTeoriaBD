#include <QString>
#include <optional>
#include <vector>
#include <QSqlDatabase>
#include "../models/PresupuestoDetalle.h"

class PresupuestoDetalleDAO {
public:
    explicit PresupuestoDetalleDAO(const QSqlDatabase& db);
    bool insertar(const Model::PresupuestoDetalle& d, QString* error = nullptr);
    bool actualizar(const Model::PresupuestoDetalle& d, QString* error = nullptr);
    bool eliminar(const QString& idPresupuestoDetalle, QString* error = nullptr);
    std::optional<Model::PresupuestoDetalle> obtenerPorId(const QString& idPresupuestoDetalle, QString* error = nullptr);
    std::vector<Model::PresupuestoDetalle> obtenerPorPresupuesto(const QString& idPresupuesto, QString* error = nullptr);

private:
    QSqlDatabase m_db;
};
