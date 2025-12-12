#include <QString>
#include <optional>
#include <vector>
#include <QSqlDatabase>
#include "../models/ObligacionFija.h"

class ObligacionFijaDAO {
public:
    explicit ObligacionFijaDAO(const QSqlDatabase& db);
    bool insertar(const Model::ObligacionFija& o, QString* error = nullptr);
    bool actualizar(const Model::ObligacionFija& o, QString* error = nullptr);
    bool eliminar(const QString& idObligacion, QString* error = nullptr);
    std::optional<Model::ObligacionFija> obtenerPorId(const QString& idObligacion, QString* error = nullptr);
    std::vector<Model::ObligacionFija> obtenerPorUsuario(const QString& idUsuario, QString* error = nullptr);
    bool actualizarVigenciaGlobal(QString* error = nullptr);

private:
    QSqlDatabase m_db;
};
