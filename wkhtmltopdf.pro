# This file is part of wkhtmltopdf.
#
# wkhtmltopdf is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# wkhtmltopdf is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with wkhtmltopdf.  If not, see <http:#www.gnu.org/licenses/>.

DEFINES += MAJOR_VERSION=0 MINOR_VERSION=8 PATCH_VERSION=4

TEMP = $$[QT_INSTALL_LIBS] libQtGui.prl
PRL  = $$[QT_INSTALL_LIBS] QtGui.framework/QtGui.prl
include($$join(TEMP, "/"))
include($$join(PRL, "/"))

contains(QMAKE_PRL_CONFIG, shared) {
    DEFINES += QT_SHARED
} else {
    DEFINES += QT_STATIC
    QTPLUGIN += qjpeg qgif qtiff qmng
}

TEMPLATE = app
TARGET = 
DEPENDPATH += . src
INCLUDEPATH += . src

MOC_DIR = build

unix {
    man.target=wkhtmltopdf.1.gz
    man.commands=m4 wkhtmltopdf.man.m4 | gzip > $@
    man.depends=wkhtmltopdf wkhtmltopdf.man.m4 
    
    manins.target=manins
    manins.depends=man
    manins.files=wkhtmltopdf.1.gz
    manins.path=$$INSTALLBASE/share/man/man1

    QMAKE_EXTRA_UNIX_TARGETS += manins man
    INSTALLS += manins
}

win32 {
    CONFIG += console
}

INSTALLS += target
target.path=$$INSTALLBASE/bin

QT += webkit network

# Input
HEADERS += src/wkhtmltopdf.hh src/toc.hh src/pageconverter_p.hh src/pageconverter.hh

SOURCES += src/wkhtmltopdf.cc src/toc.cc src/arguments.cc src/commandlineparser.cc \
           src/docparts.cc src/outputter.cc src/manoutputter.cc src/settings.cc \
           src/htmloutputter.cc src/textoutputter.cc \
           src/multipageloader.cc src/pageconverter.cc
