TEMPLATE = aux

DEVICE = SAMD51

DEVICE_FILES *= \
    qmldir \
    SAMD51.qml \
    SAMD51BootConfigApplet.qml \
    SAMD51Config.qml \
    SAMD51Labyrinth.qml \
    samd51-bootcfg.js \
    applets/applet-test.bin

include(../device.pri)

metadata.files = \
    board_samd51-labyrinth.json \
    device_samd51.json
metadata.path = /metadata
INSTALLS *= metadata

OTHER_FILES += \
    $$DEVICE_FILES \
    module_samba_device_samd51.qdoc
