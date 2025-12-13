#include <QApplication>
#include <QDir>
#include <QMessageBox>
#include "../database/DBManager.h"
#include "../../../frontend/src/gui/MainWindow.h"

int main(int argc, char *argv[]) {
    QApplication a(argc, argv);
    QString basePath = QDir(QCoreApplication::applicationDirPath())
                           .absoluteFilePath("../../ProyectoPresupuestoBD/database/PRESUPUESTO.fdb");

    auto& dbManager = DatabaseManager::instance();
    if (!dbManager.open(basePath)) {
        QMessageBox::critical(nullptr, "BD", "No se pudo abrir la base de datos.");
        return -1;
    }

    MainWindow w;
    w.show();
    return a.exec();
}
