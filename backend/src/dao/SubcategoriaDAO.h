#include <QString>
#include <optional>
#include <vector>
#include <QSqlDatabase>
#include "../models/Subcategoria.h"

class SubcategoriaDAO {
public:
    explicit SubcategoriaDAO(const QSqlDatabase& db);
    bool insertar(const Model::Subcategoria& s, QString* error = nullptr);
    bool actualizar(const Model::Subcategoria& s, QString* error = nullptr);
    bool eliminar(const QString& idSubcategoria, QString* error = nullptr);
    std::optional<Model::Subcategoria> obtenerPorId(const QString& idSubcategoria, QString* error = nullptr);
    std::vector<Model::Subcategoria> obtenerPorCategoria(const QString& idCategoria, QString* error = nullptr);

private:
    QSqlDatabase m_db;
};
