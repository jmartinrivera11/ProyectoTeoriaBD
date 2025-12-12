#include <QCoreApplication>
#include <QDir>
#include <QDebug>
#include "../database/DBManager.h"
#include <QUuid>

int main(int argc, char *argv[]) {
    QCoreApplication a(argc, argv);
    QString basePath = QDir(QCoreApplication::applicationDirPath())
                           .absoluteFilePath("../../ProyectoPresupuestoBD/database/PRESUPUESTO.fdb");
    auto& dbManager = DatabaseManager::instance();
    if (!dbManager.open(basePath)) {
        qDebug() << "No se pudo abrir la base de datos";
        return -1;
    }
    return a.exec();
}
