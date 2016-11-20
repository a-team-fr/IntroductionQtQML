QT += core qml quick sensors multimedia

CONFIG += c++11

SOURCES += main.cpp

RESOURCES += qml.qrc

macx {
    QMAKE_MAC_SDK = macosx10.12
}

lupdate_only{
    SOURCES = *.qml \
              *.js \
              qml/*.qml \
}
TRANSLATIONS = translations/QtQML_fr.ts

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
