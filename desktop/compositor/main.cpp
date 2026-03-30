#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtWaylandCompositor/QWaylandCompositor>

int main(int argc, char *argv[])
{
    QGuiApplication::setApplicationName("CircleOS Compositor");
    QGuiApplication::setApplicationVersion(CIRCLEOS_VERSION);
    
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));

    return app.exec();
}
