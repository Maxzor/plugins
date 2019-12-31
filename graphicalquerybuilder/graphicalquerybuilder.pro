# graphicalquerybuilder.pro (reviewed version)
#
# Adapted by: Maxime Chambonnet <maxzor@maxzor.eu> - 12/16/2019
# Refactored by: Lisandro Damián Nicanor Pérez Meyer <perezmeyer@gmail.com>
# Refactored code: https://github.com/perezmeyer/pgmodeler/tree/shared_libs
# Reviewed by: Raphal Araújo e Silva <raphael@pgmodeler.com.br>
#
# NOTE: Reviewed code is not a direct merge from refactored version but based upon the
# refactored code, containing almost all changes done by the refactoring author.

# Unix or Windows directory configuration
PGMODELER_SRC_DIR=../../

!exists($$PGMODELER_SRC_DIR) {
 warning("The pgModeler source code directory '$$PGMODELER_SRC_DIR' could not be found! Make sure the variable PGMODELER_SRC_DIR points to a valid location!")
 error("qmake aborted.")
}

include(../plugins.pro)

CONFIG += plugin qt uic4
QT += core gui uitools
TEMPLATE = lib
TARGET = graphicalquerybuilder
TRANSLATIONS += $$PWD/lang/$$TARGET.en_US.ts
OTHER_FILES += graphicalquerybuilder.json
CODECFORTR = UTF8
DEPENDPATH = ". res src ui moc obj"
MOC_DIR = moc
OBJECTS_DIR = obj
UI_DIR = src

HEADERS += src/graphicalquerybuilder.h \
            src/graphicalquerybuildercorewidget.h \
            src/graphicalquerybuilderpathwidget.h \
            src/graphicalquerybuildersqlwidget.h


SOURCES += src/graphicalquerybuilder.cpp \
            src/graphicalquerybuildercorewidget.cpp \
            src/graphicalquerybuilderpathwidget.cpp \
            src/graphicalquerybuildersqlwidget.cpp

FORMS += ui/graphicalquerybuildercorewidget.ui \
            ui/graphicalquerybuilderpathwidget.ui \
            ui/graphicalquerybuildersqlwidget.ui

windows: DESTDIR += $$PWD

unix|windows: LIBS += -L$$OUT_PWD/../../libpgmodeler_ui/ -lpgmodeler_ui \
                    -L$$OUT_PWD/../../libobjrenderer/ -lobjrenderer \
                    -L$$OUT_PWD/../../libpgconnector/ -lpgconnector \
                    -L$$OUT_PWD/../../libpgmodeler/ -lpgmodeler \
                    -L$$OUT_PWD/../../libparsers/ -lparsers \
                    -L$$OUT_PWD/../../libutils/ -lutils

!exists(paal) {
PKG_ERROR = "Make sure to run the setup script, or to configure the plugin dependencies (paal & boost)!"
VARIABLE = "$$PWD/paal"
}

!isEmpty(PKG_ERROR) {
warning("$$PKG_ERROR Paal files were not found at \"$$VARIABLE\"!")
error("pgModeler compilation aborted : graphical query builder plugin errorred out.")

}

INCLUDEPATH += $$PWD/../../libpgmodeler_ui \
               $$PWD/../../libpgmodeler_ui/src \
               $$PWD/../../libobjrenderer/src \
               $$PWD/../../libpgconnector/src \
               $$PWD/../../libpgmodeler/src \
               $$PWD/../../libparsers/src \
               $$PWD/../../libutils/src \
               $$PWD/paal/include \
			   $$PWD/paal/boost

DEPENDPATH += $$PWD/../../libpgmodeler_ui \
              $$PWD/../../libobjrenderer \
              $$PWD/../../libpgconnector \
              $$PWD/../../libpgmodeler \
              $$PWD/../../libparsers \
              $$PWD/../../libutils \
              $$PWD/paal/include \
			  $$PWD/paal/boost

target.path = $$PLUGINSDIR/$$TARGET

resources.path = $$PLUGINSDIR/$$TARGET
resources.files += res/graphicalquerybuilder.png lang graphicalquerybuilder.json

INSTALLS += target resources
