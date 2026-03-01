/*
 * SPDX-FileCopyrightText: 2026 Smooth-E
 * SPDX-License-Identifier: GPL-3.0-or-later
*/

import QtQuick 2.6
import Sailfish.Silica 1.0

Button {
    property Flow flow
    property string coloredText
    property string rawText: coloredText

    readonly property real maximumWidth: flow.width - flow.leftPadding - flow.rightPadding
    readonly property real minimumWidth: (icon.status === Image.Ready ? icon.width + Theme.paddingSmall : 0)
                                         + metrics.advanceWidth("# " + rawText) + Theme.paddingMedium * 2

    width: Math.min(minimumWidth, maximumWidth)
    layoutDirection: Qt.RightToLeft
    color: appWindow.stringToColor(rawText)
    text: "# " + coloredText

    FontMetrics {
        id: metrics

        font.pixelSize: Theme.fontSizeMedium
    }
}
