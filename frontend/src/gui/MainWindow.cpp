#include "MainWindow.h"

#include <QTabWidget>
#include "UsuarioWidget.h"
#include "CategoriaSubcategoriaWidget.h"
#include "PresupuestoWidget.h"
#include "TransaccionWidget.h"
#include "MetaAhorroWidget.h"
#include "ObligacionFijaWidget.h"

MainWindow::MainWindow(QWidget* parent)
    : QMainWindow(parent)
{
    setWindowTitle("Sistema de Presupuesto - Demo");

    m_tabs = new QTabWidget(this);
    setCentralWidget(m_tabs);

    m_usuarioWidget = new UsuarioWidget(this);
    m_tabs->addTab(m_usuarioWidget, "Usuarios");

    m_catSubWidget = new CategoriaSubcategoriaWidget(this);
    m_tabs->addTab(m_catSubWidget, "Categorías / Subcategorías");

    m_presupuestoWidget = new PresupuestoWidget(this);
    m_tabs->addTab(m_presupuestoWidget, "Presupuestos");

    m_transaccionWidget = new TransaccionWidget(this);
    m_tabs->addTab(m_transaccionWidget, "Transacciones");

    m_metaWidget = new MetaAhorroWidget(this);
    m_tabs->addTab(m_metaWidget, "Metas de ahorro");

    m_obligacionWidget = new ObligacionFijaWidget(this);
    m_tabs->addTab(m_obligacionWidget, "Obligaciones fijas");

    resize(1200, 650);
}
