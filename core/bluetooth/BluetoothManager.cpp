#include "BluetoothManager.h"
#include <QDBusConnection>
#include <QDBusInterface>

namespace CircleOS {
namespace Core {

class BluetoothManager::Private {
public:
    bool enabled = false;
    bool discovering = false;
    QStringList devices;
};

BluetoothManager::BluetoothManager(QObject *parent)
    : QObject(parent)
    , d(std::make_unique<Private>())
{
}

BluetoothManager::~BluetoothManager() = default;

bool BluetoothManager::enabled() const {
    return d->enabled;
}

bool BluetoothManager::discovering() const {
    return d->discovering;
}

QStringList BluetoothManager::devices() const {
    return d->devices;
}

void BluetoothManager::setEnabled(bool enabled) {
    if (d->enabled == enabled) return;
    d->enabled = enabled;
    emit enabledChanged();
}

void BluetoothManager::startDiscovery() {
    d->discovering = true;
    emit discoveringChanged();
}

void BluetoothManager::stopDiscovery() {
    d->discovering = false;
    emit discoveringChanged();
}

void BluetoothManager::connectToDevice(const QString &address) {
    qInfo() << "Connecting to Bluetooth device:" << address;
    emit deviceConnected(address);
}

void BluetoothManager::disconnectDevice(const QString &address) {
    qInfo() << "Disconnecting Bluetooth device:" << address;
    emit deviceDisconnected(address);
}

} // namespace Core
} // namespace CircleOS
