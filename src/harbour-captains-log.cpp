/*
 * This file is part of Captain's Log.
 * SPDX-FileCopyrightText: 2021  Lukáš Karas
 * SPDX-FileCopyrightText: 2021-2022  Mirian Margiani
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

#include <QtQuick>
#include <QDebug>
#include <auroraapp.h>
#include "requires_defines.h"

int main(int argc, char *argv[])
{
    QScopedPointer<QGuiApplication> app(Aurora::Application::application(argc, argv));
    app->setOrganizationName("harbour-captains-log"); // needed for Sailjail
    app->setApplicationName("harbour-captains-log");

    QScopedPointer<QQuickView> view(Aurora::Application::createView());
    view->rootContext()->setContextProperty("APP_VERSION", QString(APP_VERSION));
    view->rootContext()->setContextProperty("APP_RELEASE", QString(APP_RELEASE));

    view->engine()->addImportPath(Aurora::Application::pathTo("qml/modules").toString());
    view->setSource(Aurora::Application::pathTo("qml/harbour-captains-log.qml"));
    view->show();
    return app->exec();
}
