import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQml.Models 2.15
import QtMultimedia 5.12

import Player 1.0
import Tapper 1.0
import Picker 1.0

Window{
    property alias playerController: player.controller
    property alias tapperController: tapper.controller
    property alias tempoController: tempoPicker.controller
    property alias accentController: accentPicker.controller
    property alias tempoTumbler: tempoPicker.tumbler

    property string iconSett: "qrc:/icons/setting_line.svg"

    width: 400
    height: 500
    maximumHeight: height
    maximumWidth: width
    minimumHeight: height
    minimumWidth: width

    visible: true
    title: qsTr("Metronome")

    ColumnLayout{
        spacing: 0
        anchors.fill: parent

        RowLayout{
            spacing: 0
            Layout.maximumHeight: settButton.height
            Layout.minimumHeight: settButton.height
            Item{
                Layout.fillWidth: true
                Layout.fillHeight: true
                Rectangle{
                    id: background
                    anchors.fill: parent
                    color: "#E0E0E0"
                }
            }
            Item{
                Layout.preferredWidth: settButton.width
                Layout.alignment: Qt.AlignRight
                Button{
                    id: settButton
                    width: 50;
                    height: 40;
                    anchors.centerIn: parent
                    icon.source: iconSett;
                }
            }
        }

        RowLayout{
            spacing: 4
            Layout.minimumHeight: tempoPicker.height
            Item{
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
            Item{
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                TempoPicker{
                    id: tempoPicker
                    anchors.centerIn: parent
                    delegateComponent.model: playerController.range
                    controller.maxTempo: playerController.tempoMax
                    controller.minTempo: playerController.tempoMin
                    tumbler.currentIndex: playerController.tempo - playerController.tempoMin
                }
            }
            Item{
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignRight
                Tapper{
                    id: tapper
                    anchors.centerIn: parent
                }
            }
        }

        Player{
            id: player
            Layout.alignment: Qt.AlignHCenter
        }

        RowLayout{
            spacing: 2
            Layout.minimumHeight: accentPicker.height
            Item{
                Layout.fillWidth: true
                Layout.fillHeight: true
                DurationPicker{
                    id: durationPicker
                    anchors.centerIn: parent
                }
            }
            Item{
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                DurationPicker{
                    id: durationPicker_2
                    anchors.centerIn: parent
                }
            }
            Item{
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                AccentPicker{
                    id: accentPicker
                    delegateComponent.model: 13
                    anchors.centerIn: parent
                }
            }
        }
    }

    Connections{
        target: tempoController
        function onIndexChanged(){
            playerController.tempo = tempoController.tempo;
        }

    }

    Connections{
        target: tempoController
        function onTempoChanged(){
            playerController.tempo = tempoController.tempo;
            tempoTumbler.currentIndex = tempoController.index;
        }
    }

    Connections{
        target: tapperController
        function onTempoChanged(){
            tempoController.tempo = tapperController.tempo;
        }
    }

    Connections{
        target: accentController
        function onIndexChanged(){
            playerController.accent = accentController.index;
        }
    }
}
