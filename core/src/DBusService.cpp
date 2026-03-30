#include "DBusService.h"
#include <QDBusConnection>
#include <QDBusError>
#include <QDebug>

namespace CircleOS {
namespace Core {

class DBusService::Private {
public:
    bool registered = false;
    QString serviceName = "org.circleos.Shell";
    QString objectPath = "/org/circleos/Shell";
};

DBusService::DBusService(QObject *parent)
    : QObject(parent)
    , d(std::make_unique<Private>())
{
}

DBusService::~DBusService() {
    if (d->registered) {
        unregisterService();
    }
}

bool DBusService::registerService() {
    if (d->registered) return true;
    
    QDBusConnection bus = QDBusConnection::sessionBus();
    
    if (!bus.registerService(d->serviceName)) {
        qWarning() << "Failed to register D-Bus service:" << bus.lastError().message();
        return false;
    }
    
    if (!bus.registerObject(d->objectPath, this, QDBusConnection::ExportAllSlots)) {
        qWarning() << "Failed to register D-Bus object:" << bus.lastError().message();
        bus.unregisterService(d->serviceName);
        return false;
    }
    
    d->registered = true;
    qInfo() << "D-Bus service registered:" << d->serviceName;
    
    return true;
}

void DBusService::unregisterService() {
    if (!d->registered) return;
    
    QDBusConnection bus = QDBusConnection::sessionBus();
    bus.unregisterObject(d->objectPath);
    bus.unregisterService(d->serviceName);
    
    d->registered = false;
    qInfo() << "D-Bus service unregistered";
}

bool DBusService::isRegistered() const {
    return d->registered;
}

} // namespace Core
} // namespace CircleOS
