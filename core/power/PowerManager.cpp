#include "PowerManager.h"
#include <QDBusConnection>
#include <QDBusInterface>
#include <QDBusReply>
#include <QFile>
#include <QTextStream>

namespace CircleOS {
namespace Core {

class PowerManager::Private {
public:
    int batteryLevel = 0;
    bool isCharging = false;
    QString powerProfile = "balanced";
    QDBusInterface *upowerInterface = nullptr;
    QDBusInterface *logindInterface = nullptr;
};

PowerManager::PowerManager(QObject *parent)
    : QObject(parent)
    , d(std::make_unique<Private>())
{
    // Connect to UPower
    d->upowerInterface = new QDBusInterface(
        "org.freedesktop.UPower",
        "/org/freedesktop/UPower",
        "org.freedesktop.UPower",
        QDBusConnection::systemBus(),
        this
    );
    
    // Connect to systemd-logind
    d->logindInterface = new QDBusInterface(
        "org.freedesktop.login1",
        "/org/freedesktop/login1",
        "org.freedesktop.login1.Manager",
        QDBusConnection::systemBus(),
        this
    );
    
    // Initial update
    updateBatteryStatus();
}

PowerManager::~PowerManager() = default;

int PowerManager::batteryLevel() const {
    return d->batteryLevel;
}

bool PowerManager::isCharging() const {
    return d->isCharging;
}

QString PowerManager::powerProfile() const {
    return d->powerProfile;
}

void PowerManager::updateBatteryStatus() {
    // Read battery status from sysfs
    QFile capacityFile("/sys/class/power_supply/BAT0/capacity");
    if (capacityFile.open(QIODevice::ReadOnly)) {
        QTextStream in(&capacityFile);
        d->batteryLevel = in.readLine().toInt();
        emit batteryLevelChanged(d->batteryLevel);
    }
    
    QFile statusFile("/sys/class/power_supply/BAT0/status");
    if (statusFile.open(QIODevice::ReadOnly)) {
        QTextStream in(&statusFile);
        QString status = in.readLine().trimmed();
        bool charging = (status == "Charging" || status == "Full");
        if (charging != d->isCharging) {
            d->isCharging = charging;
            emit chargingChanged();
        }
    }
}

void PowerManager::setPowerProfile(const QString &profile) {
    if (profile != "performance" && profile != "balanced" && profile != "power-save") {
        qWarning() << "Invalid power profile:" << profile;
        return;
    }
    
    if (d->powerProfile == profile) return;
    
    d->powerProfile = profile;
    emit powerProfileChanged();
    
    // TODO: Apply power profile via power-profiles-daemon or similar
}

void PowerManager::suspend() {
    if (d->logindInterface && d->logindInterface->isValid()) {
        d->logindInterface->call("Suspend", true);
    }
}

void PowerManager::hibernate() {
    if (d->logindInterface && d->logindInterface->isValid()) {
        d->logindInterface->call("Hibernate", true);
    }
}

} // namespace Core
} // namespace CircleOS
