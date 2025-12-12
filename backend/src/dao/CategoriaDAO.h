#include <QString>
#include <optional>
#include <vector>
#include <QSqlDatabase>
#include "../models/Categoria.h"

class CategoriaDAO {
public:
    explicit CategoriaDAO(const QSqlDatabase& db);
    bool insertar(const Model::Categoria& c, QString* error = nullptr);
    bool actualizar(const Model::Categoria& c, QString* error = nullptr);
    bool eliminar(const QString& idCategoria, QString* error = nullptr);
    std::optional<Model::Categoria> obtenerPorId(const QString& idCategoria, QString* error = nullptr);
    std::optional<Model::Categoria> obtenerPorNombre(const QString& nombre, QString* error = nullptr);
    std::vector<Model::Categoria> obtenerTodas(QString* error = nullptr);

private:
    QSqlDatabase m_db;
};
