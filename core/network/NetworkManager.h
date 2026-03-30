#pragma once

#include <QObject>
#include <QString>
#include <QStringList>
#include <memory>

namespace CircleOS {
namespace Core {

class NetworkManager : public QObject {
    Q_OBJECT
    Q_PROPERTY(bool isConnected READ isConnected NOTIFY connectedChanged)
    Q_PROPERTY(QString connectionType READ connectionType NOTIFY connectionTypeChanged)
    Q_PROPERTY(int signalStrength READ signalStrength NOTIFY signalStrengthChanged)
    Q_PROPERTY(QString ssid READ ssid NOTIFY ssidChanged)

public:
    explicit NetworkManager(QObject *parent = nullptr);
    ~NetworkManager() override;

    bool isConnected() const;
    QString connectionType() const;
    int signalStrength() const;
    QString ssid() const;

public slots:
    void updateStatus();
    void connectToWifi(const QString &ssid, const QString &password);
    void disconnect();
    QStringList availableNetworks();

signals:
    void connectedChanged();
    void connectionTypeChanged();
    void signalStrengthChanged();
    void ssidChanged();

private:
    class Private;
    std::unique_ptr<Private> d;
};

} // namespace Core
} // namespace CircleOS
