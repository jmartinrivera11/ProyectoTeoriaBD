#pragma once
#include <QMainWindow>

class QTabWidget;
class UsuarioWidget;
class CategoriaSubcategoriaWidget;
class PresupuestoWidget;
class TransaccionWidget;
class MetaAhorroWidget;
class ObligacionFijaWidget;

class MainWindow : public QMainWindow {
    Q_OBJECT
public:
    explicit MainWindow(QWidget* parent = nullptr);

private:
    QTabWidget* m_tabs = nullptr;
    UsuarioWidget* m_usuarioWidget = nullptr;
    CategoriaSubcategoriaWidget* m_catSubWidget = nullptr;
    PresupuestoWidget* m_presupuestoWidget = nullptr;
    TransaccionWidget* m_transaccionWidget = nullptr;
    MetaAhorroWidget* m_metaWidget = nullptr;
    ObligacionFijaWidget* m_obligacionWidget = nullptr;
};
