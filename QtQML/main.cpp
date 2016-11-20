#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QTranslator>
#include <QDebug>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    //Load translation file
    QTranslator translator;

    if (translator.load(":/translations/QtQML_fr-FR"))
        app.installTranslator(&translator);
    else {
        qDebug() << "Translator couldn't be loaded";
    }

    qmlRegisterSingletonType( QUrl("qrc:/Assets.qml"),"ATeam.QtQMLExemple.AssetsSingleton", 1, 0,"Assets");

    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}
