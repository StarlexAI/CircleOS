#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication::setApplicationName("CircleOS Shell");
    QGuiApplication::setApplicationVersion(CIRCLEOS_VERSION);
    
    QGuiApplication app(argc, argv);
    
    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/CircleOS/Shell/qml/main.qml"));
    engine.load(url);
    
    if (engine.rootObjects().isEmpty()) {
        qWarning() << "Failed to load QML from:" << url;
        return -1;
    }

    return app.exec();
}
