#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication::setApplicationName("CircleOS Terminal");
    QGuiApplication::setApplicationVersion(CIRCLEOS_VERSION);
    
    QGuiApplication app(argc, argv);
    
    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/CircleOS/Terminal/qml/main.qml"));
    engine.load(url);
    
    if (engine.rootObjects().isEmpty()) {
        qWarning() << "Failed to load QML from:" << url;
        return -1;
    }

    return app.exec();
}
