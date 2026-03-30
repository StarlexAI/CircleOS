#pragma once

#include <QObject>
#include <QString>
#include <QStringList>
#include <memory>

namespace CircleOS {
namespace Core {

class BluetoothManager : public QObject {
    Q_OBJECT
    Q_PROPERTY(bool enabled READ enabled NOTIFY enabledChanged)
    Q_PROPERTY(bool discovering READ discovering NOTIFY discoveringChanged)
    Q_PROPERTY(QStringList devices READ devices NOTIFY devicesChanged)

public:
    explicit BluetoothManager(QObject *parent = nullptr);
    ~BluetoothManager() override;

    bool enabled() const;
    bool discovering() const;
    QStringList devices() const;

public slots:
    void setEnabled(bool enabled);
    void startDiscovery();
    void stopDiscovery();
    void connectToDevice(const QString &address);
    void disconnectDevice(const QString &address);

signals:
    void enabledChanged();
    void discoveringChanged();
    void devicesChanged();
    void deviceConnected(const QString &address);
    void deviceDisconnected(const QString &address);

private:
    class Private;
    std::unique_ptr<Private> d;
};

} // namespace Core
} // namespace CircleOS
