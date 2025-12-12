#include <QString>
#include <optional>
#include <vector>
#include <QSqlDatabase>
#include "../models/MetaAhorro.h"

class MetaAhorroDAO {
public:
    explicit MetaAhorroDAO(const QSqlDatabase& db);
    bool insertar(const Model::MetaAhorro& m, QString* error = nullptr);
    bool actualizar(const Model::MetaAhorro& m, QString* error = nullptr);
    bool eliminar(const QString& idMeta, QString* error = nullptr);
    std::optional<Model::MetaAhorro> obtenerPorId(const QString& idMeta, QString* error = nullptr);
    std::optional<Model::MetaAhorro> obtenerPorNombreUsuario(const QString& idUsuario, const QString& nombre, QString* error = nullptr);
    std::vector<Model::MetaAhorro> obtenerPorUsuario(const QString& idUsuario, QString* error = nullptr);
    bool aplicarAporte(const QString& idMeta, double monto, const QString& usuario, QString* error = nullptr);
    bool recalcularEstado(const QString& idMeta, const QString& usuario, QString* error = nullptr);

private:
    QSqlDatabase m_db;
};
