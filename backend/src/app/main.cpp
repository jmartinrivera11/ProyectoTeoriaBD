#include <QCoreApplication>
#include <QDir>
#include <QSqlDatabase>
#include <QSqlError>
#include <QDebug>

int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);

    QString basePath = QDir(QCoreApplication::applicationDirPath())
                           .absoluteFilePath("../../ProyectoPresupuestoBD/database/PRESUPUESTO.fdb");

    QSqlDatabase db = QSqlDatabase::addDatabase("QIBASE");
    db.setDatabaseName(basePath);
    db.setUserName("sysdba");
    db.setPassword("masterkey");

    if (!db.open())
        qDebug() << "Error:" << db.lastError().text();
    else
        qDebug() << "Conexion establecida";

    return a.exec();
}
