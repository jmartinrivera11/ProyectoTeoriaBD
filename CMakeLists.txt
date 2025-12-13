cmake_minimum_required(VERSION 3.16)

project(ProyectoPresupuestoBD VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Widgets Sql)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Widgets Sql)

set(PROJECT_SOURCES

)

if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
    qt_add_executable(ProyectoPresupuestoBD
        MANUAL_FINALIZATION
        ${PROJECT_SOURCES}
        backend/src/app/main.cpp
        backend/src/database/DBManager.cpp backend/src/database/DBManager.h
        backend/src/dao/UsuarioDAO.cpp backend/src/dao/UsuarioDAO.h
        backend/src/models/Usuario.h
        backend/src/dao/SubcategoriaDAO.cpp backend/src/dao/SubcategoriaDAO.h backend/src/dao/CategoriaDAO.cpp backend/src/dao/CategoriaDAO.h
        backend/src/models/Categoria.h backend/src/models/MetaAhorro.h backend/src/models/ObligacionFija.h backend/src/models/Presupuesto.h backend/src/models/PresupuestoDetalle.h backend/src/models/Subcategoria.h backend/src/models/Transaccion.h
        backend/src/dao/TransaccionDAO.cpp backend/src/dao/TransaccionDAO.h backend/src/dao/MetaAhorroDAO.cpp backend/src/dao/MetaAhorroDAO.h backend/src/dao/ObligacionFijaDAO.cpp backend/src/dao/ObligacionFijaDAO.h backend/src/dao/PresupuestoDetalleDAO.cpp backend/src/dao/PresupuestoDetalleDAO.h backend/src/dao/PresupuestoDAO.cpp backend/src/dao/PresupuestoDAO.h
        frontend/src/gui/MainWindow.cpp frontend/src/gui/MainWindow.h frontend/src/gui/UsuarioDialog.cpp frontend/src/gui/UsuarioDialog.h frontend/src/gui/UsuarioWidget.cpp frontend/src/gui/UsuarioWidget.h
        frontend/src/gui/CategoriaSubcategoriaWidget.cpp frontend/src/gui/CategoriaSubcategoriaWidget.h frontend/src/gui/SubcategoriaDialog.cpp frontend/src/gui/SubcategoriaDialog.h frontend/src/gui/CategoriaDialog.cpp frontend/src/gui/CategoriaDialog.h
        frontend/src/gui/PresupuestoWidget.cpp frontend/src/gui/PresupuestoWidget.h frontend/src/gui/PresupuestoDetalleDialog.cpp frontend/src/gui/PresupuestoDetalleDialog.h frontend/src/gui/PresupuestoDialog.cpp frontend/src/gui/PresupuestoDialog.h
        frontend/src/gui/TransaccionWidget.cpp frontend/src/gui/TransaccionWidget.h frontend/src/gui/TransaccionDialog.cpp frontend/src/gui/TransaccionDialog.h
        frontend/src/gui/MetaAhorroWidget.cpp frontend/src/gui/MetaAhorroWidget.h frontend/src/gui/MetaAhorroDialog.cpp frontend/src/gui/MetaAhorroDialog.h
        frontend/src/gui/ObligacionFijaWidget.cpp frontend/src/gui/ObligacionFijaWidget.h frontend/src/gui/ObligacionFijaDialog.cpp frontend/src/gui/ObligacionFijaDialog.h
    )
# Define target properties for Android with Qt 6 as:
#    set_property(TARGET ProyectoPresupuestoBD APPEND PROPERTY QT_ANDROID_PACKAGE_SOURCE_DIR
#                 ${CMAKE_CURRENT_SOURCE_DIR}/android)
# For more information, see https://doc.qt.io/qt-6/qt-add-executable.html#target-creation
else()
    if(ANDROID)
        add_library(ProyectoPresupuestoBD SHARED
            ${PROJECT_SOURCES}
        )
# Define properties for Android with Qt 5 after find_package() calls as:
#    set(ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android")
    else()
        add_executable(ProyectoPresupuestoBD
            ${PROJECT_SOURCES}
        )
    endif()
endif()

target_link_libraries(ProyectoPresupuestoBD PRIVATE
    Qt${QT_VERSION_MAJOR}::Widgets
    Qt${QT_VERSION_MAJOR}::Sql
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
if(${QT_VERSION} VERSION_LESS 6.1.0)
  set(BUNDLE_ID_OPTION MACOSX_BUNDLE_GUI_IDENTIFIER com.example.ProyectoPresupuestoBD)
endif()
set_target_properties(ProyectoPresupuestoBD PROPERTIES
    ${BUNDLE_ID_OPTION}
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

include(GNUInstallDirs)
install(TARGETS ProyectoPresupuestoBD
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

if(QT_VERSION_MAJOR EQUAL 6)
    qt_finalize_executable(ProyectoPresupuestoBD)
endif()
