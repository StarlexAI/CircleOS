#!/bin/bash

# Fix QML resource paths for all CircleOS applications

echo "🔧 Fixing QML resource paths..."

# Calculator
cat > apps/calculator/main.cpp << 'EOF'
#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication::setApplicationName("CircleOS Calculator");
    QGuiApplication::setApplicationVersion(CIRCLEOS_VERSION);
    
    QGuiApplication app(argc, argv);
    
    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/CircleOS/Calculator/qml/main.qml"));
    engine.load(url);
    
    if (engine.rootObjects().isEmpty()) {
        qWarning() << "Failed to load QML from:" << url;
        return -1;
    }

    return app.exec();
}
EOF

# Files
cat > apps/files/main.cpp << 'EOF'
#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication::setApplicationName("CircleOS Files");
    QGuiApplication::setApplicationVersion(CIRCLEOS_VERSION);
    
    QGuiApplication app(argc, argv);
    
    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/CircleOS/Files/qml/main.qml"));
    engine.load(url);
    
    if (engine.rootObjects().isEmpty()) {
        qWarning() << "Failed to load QML from:" << url;
        return -1;
    }

    return app.exec();
}
EOF

# Settings
cat > apps/settings/main.cpp << 'EOF'
#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication::setApplicationName("CircleOS Settings");
    QGuiApplication::setApplicationVersion(CIRCLEOS_VERSION);
    
    QGuiApplication app(argc, argv);
    
    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/CircleOS/Settings/qml/main.qml"));
    engine.load(url);
    
    if (engine.rootObjects().isEmpty()) {
        qWarning() << "Failed to load QML from:" << url;
        return -1;
    }

    return app.exec();
}
EOF

# Terminal
cat > apps/terminal/main.cpp << 'EOF'
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
EOF

# Music
cat > apps/music/main.cpp << 'EOF'
#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication::setApplicationName("CircleOS Music");
    QGuiApplication::setApplicationVersion(CIRCLEOS_VERSION);
    
    QGuiApplication app(argc, argv);
    
    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/CircleOS/Music/qml/main.qml"));
    engine.load(url);
    
    if (engine.rootObjects().isEmpty()) {
        qWarning() << "Failed to load QML from:" << url;
        return -1;
    }

    return app.exec();
}
EOF

# TextEditor
cat > apps/texteditor/main.cpp << 'EOF'
#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication::setApplicationName("CircleOS Text Editor");
    QGuiApplication::setApplicationVersion(CIRCLEOS_VERSION);
    
    QGuiApplication app(argc, argv);
    
    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/CircleOS/TextEditor/qml/main.qml"));
    engine.load(url);
    
    if (engine.rootObjects().isEmpty()) {
        qWarning() << "Failed to load QML from:" << url;
        return -1;
    }

    return app.exec();
}
EOF

# Calendar
cat > apps/calendar/main.cpp << 'EOF'
#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication::setApplicationName("CircleOS Calendar");
    QGuiApplication::setApplicationVersion(CIRCLEOS_VERSION);
    
    QGuiApplication app(argc, argv);
    
    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/CircleOS/Calendar/qml/main.qml"));
    engine.load(url);
    
    if (engine.rootObjects().isEmpty()) {
        qWarning() << "Failed to load QML from:" << url;
        return -1;
    }

    return app.exec();
}
EOF

# Weather
cat > apps/weather/main.cpp << 'EOF'
#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication::setApplicationName("CircleOS Weather");
    QGuiApplication::setApplicationVersion(CIRCLEOS_VERSION);
    
    QGuiApplication app(argc, argv);
    
    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/CircleOS/Weather/qml/main.qml"));
    engine.load(url);
    
    if (engine.rootObjects().isEmpty()) {
        qWarning() << "Failed to load QML from:" << url;
        return -1;
    }

    return app.exec();
}
EOF

# Photos
cat > apps/photos/main.cpp << 'EOF'
#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication::setApplicationName("CircleOS Photos");
    QGuiApplication::setApplicationVersion(CIRCLEOS_VERSION);
    
    QGuiApplication app(argc, argv);
    
    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/CircleOS/Photos/qml/main.qml"));
    engine.load(url);
    
    if (engine.rootObjects().isEmpty()) {
        qWarning() << "Failed to load QML from:" << url;
        return -1;
    }

    return app.exec();
}
EOF

# Mail
cat > apps/mail/main.cpp << 'EOF'
#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication::setApplicationName("CircleOS Mail");
    QGuiApplication::setApplicationVersion(CIRCLEOS_VERSION);
    
    QGuiApplication app(argc, argv);
    
    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/CircleOS/Mail/qml/main.qml"));
    engine.load(url);
    
    if (engine.rootObjects().isEmpty()) {
        qWarning() << "Failed to load QML from:" << url;
        return -1;
    }

    return app.exec();
}
EOF

# Browser
cat > apps/browser/main.cpp << 'EOF'
#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication::setApplicationName("CircleOS Browser");
    QGuiApplication::setApplicationVersion(CIRCLEOS_VERSION);
    
    QGuiApplication app(argc, argv);
    
    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/CircleOS/Browser/qml/main.qml"));
    engine.load(url);
    
    if (engine.rootObjects().isEmpty()) {
        qWarning() << "Failed to load QML from:" << url;
        return -1;
    }

    return app.exec();
}
EOF

# Videos
cat > apps/videos/main.cpp << 'EOF'
#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication::setApplicationName("CircleOS Videos");
    QGuiApplication::setApplicationVersion(CIRCLEOS_VERSION);
    
    QGuiApplication app(argc, argv);
    
    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/CircleOS/Videos/qml/main.qml"));
    engine.load(url);
    
    if (engine.rootObjects().isEmpty()) {
        qWarning() << "Failed to load QML from:" << url;
        return -1;
    }

    return app.exec();
}
EOF

# Store
cat > apps/store/main.cpp << 'EOF'
#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication::setApplicationName("CircleOS Store");
    QGuiApplication::setApplicationVersion(CIRCLEOS_VERSION);
    
    QGuiApplication app(argc, argv);
    
    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/CircleOS/Store/qml/main.qml"));
    engine.load(url);
    
    if (engine.rootObjects().isEmpty()) {
        qWarning() << "Failed to load QML from:" << url;
        return -1;
    }

    return app.exec();
}
EOF

# Desktop Shell
cat > desktop/shell/main.cpp << 'EOF'
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
EOF

# Lock Screen
cat > desktop/lockscreen/main.cpp << 'EOF'
#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication::setApplicationName("CircleOS Lock Screen");
    QGuiApplication::setApplicationVersion(CIRCLEOS_VERSION);
    
    QGuiApplication app(argc, argv);
    
    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/CircleOS/LockScreen/qml/LockScreen.qml"));
    engine.load(url);
    
    if (engine.rootObjects().isEmpty()) {
        qWarning() << "Failed to load QML from:" << url;
        return -1;
    }

    return app.exec();
}
EOF

echo "✅ All main.cpp files fixed!"
