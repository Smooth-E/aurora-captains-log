/*
 * This file is part of Captain's Log.
 * SPDX-FileCopyrightText: 2021  Lukáš Karas
 * SPDX-FileCopyrightText: 2021-2022  Mirian Margiani
 * SPDX-FileCopyrightText: 2025-2026 Smooth-E
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

#include <QtQuick>
#include <QDebug>
#include <auroraapp.h>
#include "requires_defines.h"

int main(int argc, char *argv[])
{
    if (qputenv("PYTHONHOME", QString("/usr/share/moe.smoothie.captainslog/").toUtf8().constData())) {
        qDebug() << "Successfully set python home";
    } else {
        qDebug() << "Failed to set python home";
    }
    
    QScopedPointer<QGuiApplication> app(Aurora::Application::application(argc, argv));
    app->setOrganizationName("moe.smoothie");
    app->setApplicationName("captainslog");

    QScopedPointer<QQuickView> view(Aurora::Application::createView());
    view->rootContext()->setContextProperty("APP_VERSION", QString(APP_VERSION));
    view->rootContext()->setContextProperty("APP_RELEASE", QString(APP_RELEASE));

    // Opal modules
    view->engine()->addImportPath(Aurora::Application::pathTo("qml/modules").toString());

    // Vendored pyotherside
    view->engine()->addImportPath(Aurora::Application::pathTo("lib/qt5/qml").toString());

    view->setSource(Aurora::Application::pathToMainQml());
    view->show();

    return app->exec();
}
