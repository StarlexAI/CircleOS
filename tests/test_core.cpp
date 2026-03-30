#include <QtTest/QtTest>
#include "../core/include/Application.h"
#include "../core/include/ConfigManager.h"
#include "../core/include/SystemInfo.h"

class TestCore : public QObject {
    Q_OBJECT

private slots:
    void initTestCase() {
        qDebug() << "Starting CircleOS core tests";
    }

    void testApplicationVersion() {
        CircleOS::Core::Application app;
        QVERIFY(!app.version().isEmpty());
        QCOMPARE(app.version(), QString(CIRCLEOS_VERSION));
    }

    void testApplicationInitialization() {
        CircleOS::Core::Application app;
        QVERIFY(!app.isRunning());
        
        app.initialize();
        QVERIFY(app.isRunning());
        
        app.shutdown();
        QVERIFY(!app.isRunning());
    }

    void testConfigManager() {
        CircleOS::Core::ConfigManager config;
        
        // Test set and get
        config.setValue("test/key", "value");
        QCOMPARE(config.value("test/key").toString(), QString("value"));
        
        // Test contains
        QVERIFY(config.contains("test/key"));
        QVERIFY(!config.contains("nonexistent/key"));
        
        // Test remove
        config.remove("test/key");
        QVERIFY(!config.contains("test/key"));
    }

    void testSystemInfo() {
        CircleOS::Core::SystemInfo sysInfo;
        
        // Test hostname
        QVERIFY(!sysInfo.hostname().isEmpty());
        
        // Test kernel version
        QVERIFY(!sysInfo.kernel().isEmpty());
        
        // Test OS version
        QCOMPARE(sysInfo.osVersion(), QString(CIRCLEOS_VERSION));
        
        // Test CPU cores
        QVERIFY(sysInfo.cpuCores() > 0);
        
        // Test total memory
        QVERIFY(sysInfo.totalMemory() > 0);
    }

    void cleanupTestCase() {
        qDebug() << "Core tests completed";
    }
};

QTEST_MAIN(TestCore)
#include "test_core.moc"
