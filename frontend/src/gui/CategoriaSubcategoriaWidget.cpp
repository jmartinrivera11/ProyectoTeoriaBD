#include "CategoriaSubcategoriaWidget.h"

#include <QHBoxLayout>
#include <QVBoxLayout>
#include <QTableWidget>
#include <QHeaderView>
#include <QPushButton>
#include <QMessageBox>
#include <QUuid>

#include "../../../backend/src/database/DBManager.h"
#include "../../../backend/src/dao/CategoriaDAO.h"
#include "../../../backend/src/dao/SubcategoriaDAO.h"
#include "CategoriaDialog.h"
#include "SubcategoriaDialog.h"

CategoriaSubcategoriaWidget::CategoriaSubcategoriaWidget(QWidget* parent)
    : QWidget(parent)
{
    // Tablas
    m_tblCategorias = new QTableWidget(this);
    m_tblCategorias->setColumnCount(5);
    m_tblCategorias->setHorizontalHeaderLabels({"Id_categoria", "Nombre", "Tipo", "Orden", "Color"});
    m_tblCategorias->horizontalHeader()->setStretchLastSection(true);
    m_tblCategorias->setSelectionBehavior(QAbstractItemView::SelectRows);
    m_tblCategorias->setSelectionMode(QAbstractItemView::SingleSelection);
    m_tblCategorias->setEditTriggers(QAbstractItemView::NoEditTriggers);

    m_tblSubcategorias = new QTableWidget(this);
    m_tblSubcategorias->setColumnCount(5);
    m_tblSubcategorias->setHorizontalHeaderLabels({"Id_subcategoria", "Nombre", "Activa", "Defecto", "Descripción"});
    m_tblSubcategorias->horizontalHeader()->setStretchLastSection(true);
    m_tblSubcategorias->setSelectionBehavior(QAbstractItemView::SelectRows);
    m_tblSubcategorias->setSelectionMode(QAbstractItemView::SingleSelection);
    m_tblSubcategorias->setEditTriggers(QAbstractItemView::NoEditTriggers);

    connect(m_tblCategorias, &QTableWidget::itemSelectionChanged, this, &CategoriaSubcategoriaWidget::onCategoriaSeleccionada);

    // Botones categorías
    m_btnCatRefrescar = new QPushButton("Refrescar", this);
    m_btnCatNuevo = new QPushButton("Nuevo", this);
    m_btnCatEditar = new QPushButton("Editar", this);
    m_btnCatEliminar = new QPushButton("Eliminar", this);

    connect(m_btnCatRefrescar, &QPushButton::clicked, this, &CategoriaSubcategoriaWidget::refrescarCategorias);
    connect(m_btnCatNuevo, &QPushButton::clicked, this, &CategoriaSubcategoriaWidget::onCategoriaNuevo);
    connect(m_btnCatEditar, &QPushButton::clicked, this, &CategoriaSubcategoriaWidget::onCategoriaEditar);
    connect(m_btnCatEliminar, &QPushButton::clicked, this, &CategoriaSubcategoriaWidget::onCategoriaEliminar);

    auto* barCat = new QHBoxLayout;
    barCat->addWidget(m_btnCatRefrescar);
    barCat->addStretch();
    barCat->addWidget(m_btnCatNuevo);
    barCat->addWidget(m_btnCatEditar);
    barCat->addWidget(m_btnCatEliminar);

    auto* left = new QVBoxLayout;
    left->addLayout(barCat);
    left->addWidget(m_tblCategorias);

    // Botones subcategorías
    m_btnSubNuevo = new QPushButton("Nueva", this);
    m_btnSubEditar = new QPushButton("Editar", this);
    m_btnSubEliminar = new QPushButton("Eliminar", this);

    connect(m_btnSubNuevo, &QPushButton::clicked, this, &CategoriaSubcategoriaWidget::onSubcategoriaNuevo);
    connect(m_btnSubEditar, &QPushButton::clicked, this, &CategoriaSubcategoriaWidget::onSubcategoriaEditar);
    connect(m_btnSubEliminar, &QPushButton::clicked, this, &CategoriaSubcategoriaWidget::onSubcategoriaEliminar);

    auto* barSub = new QHBoxLayout;
    barSub->addStretch();
    barSub->addWidget(m_btnSubNuevo);
    barSub->addWidget(m_btnSubEditar);
    barSub->addWidget(m_btnSubEliminar);

    auto* right = new QVBoxLayout;
    right->addLayout(barSub);
    right->addWidget(m_tblSubcategorias);

    // Layout principal
    auto* root = new QHBoxLayout(this);
    root->addLayout(left, 1);
    root->addLayout(right, 1);
    setLayout(root);

    refrescarCategorias();
}

QString CategoriaSubcategoriaWidget::selectedCategoriaId() const
{
    auto ranges = m_tblCategorias->selectedRanges();
    if (ranges.isEmpty()) return {};
    int row = ranges.first().topRow();
    auto* item = m_tblCategorias->item(row, 0);
    return item ? item->text() : QString();
}

QString CategoriaSubcategoriaWidget::selectedSubcategoriaId() const
{
    auto ranges = m_tblSubcategorias->selectedRanges();
    if (ranges.isEmpty()) return {};
    int row = ranges.first().topRow();
    auto* item = m_tblSubcategorias->item(row, 0);
    return item ? item->text() : QString();
}

void CategoriaSubcategoriaWidget::refrescarCategorias()
{
    auto db = DatabaseManager::instance().database();
    CategoriaDAO catDao(db);

    QString err;
    auto cats = catDao.obtenerTodas(&err);
    if (!err.isEmpty()) {
        QMessageBox::critical(this, "BD", "Error cargando categorías:\n" + err);
        return;
    }

    QString keepId = selectedCategoriaId();

    m_tblCategorias->setRowCount(0);
    for (const auto& c : cats) {
        int r = m_tblCategorias->rowCount();
        m_tblCategorias->insertRow(r);

        m_tblCategorias->setItem(r, 0, new QTableWidgetItem(c.id_categoria));
        m_tblCategorias->setItem(r, 1, new QTableWidgetItem(c.nombre));
        m_tblCategorias->setItem(r, 2, new QTableWidgetItem(c.tipo));
        m_tblCategorias->setItem(r, 3, new QTableWidgetItem(QString::number(c.orden)));
        m_tblCategorias->setItem(r, 4, new QTableWidgetItem(c.color_hex));
    }

    m_tblCategorias->resizeColumnsToContents();

    // Re-seleccionar si se puede
    if (!keepId.isEmpty()) {
        for (int r = 0; r < m_tblCategorias->rowCount(); ++r) {
            if (m_tblCategorias->item(r, 0)->text() == keepId) {
                m_tblCategorias->selectRow(r);
                break;
            }
        }
    }

    // Si no hay selección, limpiar subcategorías
    if (selectedCategoriaId().isEmpty()) {
        m_tblSubcategorias->setRowCount(0);
    } else {
        refrescarSubcategorias();
    }
}

void CategoriaSubcategoriaWidget::onCategoriaSeleccionada()
{
    refrescarSubcategorias();
}

void CategoriaSubcategoriaWidget::refrescarSubcategorias()
{
    QString idCat = selectedCategoriaId();
    if (idCat.isEmpty()) {
        m_tblSubcategorias->setRowCount(0);
        return;
    }

    auto db = DatabaseManager::instance().database();
    SubcategoriaDAO subDao(db);

    QString err;
    auto subs = subDao.obtenerPorCategoria(idCat, &err);
    if (!err.isEmpty()) {
        QMessageBox::critical(this, "BD", "Error cargando subcategorías:\n" + err);
        return;
    }

    m_tblSubcategorias->setRowCount(0);
    for (const auto& s : subs) {
        int r = m_tblSubcategorias->rowCount();
        m_tblSubcategorias->insertRow(r);

        m_tblSubcategorias->setItem(r, 0, new QTableWidgetItem(s.id_subcategoria));
        m_tblSubcategorias->setItem(r, 1, new QTableWidgetItem(s.nombre));
        m_tblSubcategorias->setItem(r, 2, new QTableWidgetItem(s.activa ? "Sí" : "No"));
        m_tblSubcategorias->setItem(r, 3, new QTableWidgetItem(s.es_defecto ? "Sí" : "No"));
        m_tblSubcategorias->setItem(r, 4, new QTableWidgetItem(s.descripcion));
    }

    m_tblSubcategorias->resizeColumnsToContents();
}

void CategoriaSubcategoriaWidget::onCategoriaNuevo()
{
    CategoriaDialog dlg(this);
    if (dlg.exec() != QDialog::Accepted) return;

    auto c = dlg.categoria();
    if (c.nombre.isEmpty()) {
        QMessageBox::warning(this, "Validación", "El nombre es obligatorio.");
        return;
    }

    c.id_categoria = QUuid::createUuid().toString(QUuid::WithoutBraces);
    c.creado_por = "app";

    auto db = DatabaseManager::instance().database();
    CategoriaDAO dao(db);

    QString err;
    if (!dao.insertar(c, &err)) {
        QMessageBox::critical(this, "BD", "No se pudo insertar:\n" + err);
        return;
    }

    refrescarCategorias();
}

void CategoriaSubcategoriaWidget::onCategoriaEditar()
{
    QString id = selectedCategoriaId();
    if (id.isEmpty()) {
        QMessageBox::information(this, "Categorías", "Selecciona una categoría.");
        return;
    }

    auto db = DatabaseManager::instance().database();
    CategoriaDAO dao(db);

    QString err;
    auto opt = dao.obtenerPorId(id, &err);
    if (!err.isEmpty()) {
        QMessageBox::critical(this, "BD", "Error consultando:\n" + err);
        return;
    }
    if (!opt) {
        QMessageBox::information(this, "Categorías", "La categoría ya no existe.");
        refrescarCategorias();
        return;
    }

    CategoriaDialog dlg(this);
    dlg.setCategoria(*opt);

    if (dlg.exec() != QDialog::Accepted) return;

    auto c = dlg.categoria();
    if (c.nombre.isEmpty()) {
        QMessageBox::warning(this, "Validación", "El nombre es obligatorio.");
        return;
    }

    c.modificado_por = "app";

    if (!dao.actualizar(c, &err)) {
        QMessageBox::critical(this, "BD", "No se pudo actualizar:\n" + err);
        return;
    }

    refrescarCategorias();
}

void CategoriaSubcategoriaWidget::onCategoriaEliminar()
{
    QString id = selectedCategoriaId();
    if (id.isEmpty()) {
        QMessageBox::information(this, "Categorías", "Selecciona una categoría.");
        return;
    }

    if (QMessageBox::question(this, "Eliminar", "¿Eliminar la categoría seleccionada?") != QMessageBox::Yes)
        return;

    auto db = DatabaseManager::instance().database();
    CategoriaDAO dao(db);

    QString err;
    if (!dao.eliminar(id, &err)) {
        QMessageBox::critical(this, "BD",
                              "No se pudo eliminar.\n"
                              "Si tiene subcategorías asociadas, primero elimínalas.\n\n" + err);
        return;
    }

    refrescarCategorias();
}

void CategoriaSubcategoriaWidget::onSubcategoriaNuevo()
{
    QString idCat = selectedCategoriaId();
    if (idCat.isEmpty()) {
        QMessageBox::information(this, "Subcategorías", "Selecciona una categoría primero.");
        return;
    }

    SubcategoriaDialog dlg(this);
    dlg.setIdCategoria(idCat);

    if (dlg.exec() != QDialog::Accepted) return;

    auto s = dlg.subcategoria();
    if (s.nombre.isEmpty()) {
        QMessageBox::warning(this, "Validación", "El nombre es obligatorio.");
        return;
    }

    s.id_subcategoria = QUuid::createUuid().toString(QUuid::WithoutBraces);
    s.creado_por = "app";

    auto db = DatabaseManager::instance().database();
    SubcategoriaDAO dao(db);

    QString err;
    if (!dao.insertar(s, &err)) {
        QMessageBox::critical(this, "BD", "No se pudo insertar:\n" + err);
        return;
    }

    refrescarSubcategorias();
}

void CategoriaSubcategoriaWidget::onSubcategoriaEditar()
{
    QString idSub = selectedSubcategoriaId();
    if (idSub.isEmpty()) {
        QMessageBox::information(this, "Subcategorías", "Selecciona una subcategoría.");
        return;
    }

    // Nota: tu SubcategoriaDAO no tiene obtenerPorId selectivo? Sí lo tiene: obtenerPorId
    auto db = DatabaseManager::instance().database();
    SubcategoriaDAO dao(db);

    QString err;
    auto opt = dao.obtenerPorId(idSub, &err);
    if (!err.isEmpty()) {
        QMessageBox::critical(this, "BD", "Error consultando:\n" + err);
        return;
    }
    if (!opt) {
        QMessageBox::information(this, "Subcategorías", "La subcategoría ya no existe.");
        refrescarSubcategorias();
        return;
    }

    SubcategoriaDialog dlg(this);
    dlg.setSubcategoria(*opt);

    if (dlg.exec() != QDialog::Accepted) return;

    auto s = dlg.subcategoria();
    if (s.nombre.isEmpty()) {
        QMessageBox::warning(this, "Validación", "El nombre es obligatorio.");
        return;
    }

    s.modificado_por = "app";

    if (!dao.actualizar(s, &err)) {
        QMessageBox::critical(this, "BD", "No se pudo actualizar:\n" + err);
        return;
    }

    refrescarSubcategorias();
}

void CategoriaSubcategoriaWidget::onSubcategoriaEliminar()
{
    QString idSub = selectedSubcategoriaId();
    if (idSub.isEmpty()) {
        QMessageBox::information(this, "Subcategorías", "Selecciona una subcategoría.");
        return;
    }

    if (QMessageBox::question(this, "Eliminar", "¿Eliminar la subcategoría seleccionada?") != QMessageBox::Yes)
        return;

    auto db = DatabaseManager::instance().database();
    SubcategoriaDAO dao(db);

    QString err;
    if (!dao.eliminar(idSub, &err)) {
        QMessageBox::critical(this, "BD",
                              "No se pudo eliminar.\n"
                              "Si está usada en presupuesto/transacción/obligación/meta, primero elimina esas referencias.\n\n" + err);
        return;
    }

    refrescarSubcategorias();
}
