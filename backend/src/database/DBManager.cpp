#include "DBManager.h"
#include <QSqlError>
#include <QDebug>

DatabaseManager::DatabaseManager(){}

DatabaseManager& DatabaseManager::instance() {
    static DatabaseManager instance;
    return instance;
}

bool DatabaseManager::open(const QString& dbPath, const QString& user, const QString& password, const QString& connectionName) {
    m_connectionName = connectionName;
    if (QSqlDatabase::contains(connectionName)) {
        m_db = QSqlDatabase::database(connectionName);
    } else {
        m_db = QSqlDatabase::addDatabase(QStringLiteral("QIBASE"), connectionName);
    }
    m_db.setDatabaseName(dbPath);
    m_db.setUserName(user);
    m_db.setPassword(password);
    if (!m_db.open()) {
        qDebug() << "Error abriendo base de datos";
        return false;
    }
    qDebug() << "Conexion establecida";
    return true;
}

QSqlDatabase DatabaseManager::database() const {
    return m_db;
}

bool DatabaseManager::isOpen() const {
    return m_db.isOpen();
}
