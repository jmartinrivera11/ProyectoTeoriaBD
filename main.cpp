// #include "mainwindow.h"
#include <QApplication>
#include <QSqlDatabase>
#include <QSqlError>
#include <QDebug>

int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);

    QSqlDatabase db = QSqlDatabase::addDatabase("QIBASE");
    db.setDatabaseName("PRESUPUESTO.fdb");
    db.setUserName("sysdba");
    db.setPassword("masterkey");

    if (!db.open()) {
        qDebug() << "Error:" << db.lastError().text();
    } else {
        qDebug() << "Conexión exitosa.";
    }

    return a.exec();
}
