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

    readonly property var _highlightRegex: new RegExp(searchTerm.replace(/([-.[\](){}\\*?*^$|])/g, "\\$1"), 'i')

    property string searchTerm
    readonly property int defaultLimit: 3
    property int limitResults: defaultLimit

    signal tagSelected(var tag)

    height: implicitHeight
    spacing: Theme.paddingSmall
    leftPadding: Theme.horizontalPageMargin
    rightPadding: leftPadding

    Behavior on height {
        NumberAnimation {
            duration: 200
        }
    }

    SortFilterProxyModel {
        id: tagSuggestionsModel
        sourceModel: searchTerm !== "" ? appWindow.tagsModel : null

        sorters: StringSorter {
            roleName: "text"
        }

        filters: AnyOf {
            RegExpFilter {
                roleName: "text"
                pattern: searchTerm
                caseSensitivity: Qt.CaseInsensitive
                syntax: RegExpFilter.WildcardUnix
            }

            RegExpFilter {
                roleName: "normalized"
                pattern: appWindow.normalizeText(searchTerm)
                caseSensitivity: Qt.CaseInsensitive
                syntax: RegExpFilter.FixedString
            }
        }
    }

    Repeater {
        id: repeater

        model: tagSuggestionsModel

        delegate: TagFlowButton {
            flow: root
            rawText: model.text
            coloredText: Theme.highlightText(model.text, root._highlightRegex, Theme.highlightColor)
            visible: index < root.limitResults

            onClicked: root.tagSelected(model) 
        }

        onCountChanged: {
            if (count != limitResults) {
                limitResults = defaultLimit
            }
        }
    }

    SecondaryButton {
        property int remaining: Math.max(0, repeater.count - root.limitResults)

        visible: remaining > 0
        text: qsTr("Show %1 more").arg(remaining)
        icon.source: "image://theme/icon-splus-new"

        onClicked: root.limitResults = repeater.count
    }
}
