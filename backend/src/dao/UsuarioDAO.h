#include <QString>
#include <optional>
#include <vector>
#include <QSqlDatabase>
#include "../models/Usuario.h"

class UsuarioDAO {
public:
    explicit UsuarioDAO(const QSqlDatabase& db);
    bool insertar(const Model::Usuario& usuario, QString* error = nullptr);
    bool actualizar(const Model::Usuario& usuario, QString* error = nullptr);
    bool eliminar(const QString& idUsuario, QString* error = nullptr);
    std::optional<Model::Usuario> obtenerPorId(const QString& idUsuario, QString* error = nullptr);
    std::optional<Model::Usuario> obtenerPorCorreo(const QString& correo, QString* error = nullptr);
    std::vector<Model::Usuario> obtenerTodos(QString* error = nullptr);

private:
    QSqlDatabase m_db;
    Model::Usuario mapearDesdeRecord(const QSqlRecord& record) const;
};
