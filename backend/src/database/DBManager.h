#include <QSqlDatabase>
#include <QString>

class DatabaseManager {
public:
    static DatabaseManager& instance();
    bool open(const QString& dbPath, const QString& user = QStringLiteral("sysdba"), const QString& password = QStringLiteral("masterkey"), const QString& connectionName = QStringLiteral("presupuesto"));
    QSqlDatabase database() const;
    bool isOpen() const;

private:
    DatabaseManager();
    DatabaseManager(const DatabaseManager&) = delete;
    DatabaseManager& operator=(const DatabaseManager&) = delete;
    QSqlDatabase m_db;
    QString m_connectionName;
};
