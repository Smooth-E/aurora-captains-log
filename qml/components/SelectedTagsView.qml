/*
 * This file is part of Captain's Log.
 * SPDX-FileCopyrightText: 2023 Mirian Margiani
 * SPDX-FileCopyrightText: 2026 Smooth-E
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

import QtQuick 2.6
import Sailfish.Silica 1.0
import Opal.SortFilterProxyModel 1.0

Flow {
    id: root

    property var tagsList: ([])

    signal removeRequested(var tag)

    layoutDirection: Flow.LeftToRight
    spacing: Theme.paddingSmall
    leftPadding: Theme.horizontalPageMargin
    rightPadding: Theme.horizontalPageMargin

    Repeater {
        model: tagsList

        delegate: TagFlowButton {
            flow: root
            coloredText: modelData
            icon.source: "image://theme/icon-splus-clear"

            onClicked: root.removeRequested(modelData)
        }
    }
}
