#pragma once

#include <QObject>
#include <QString>
#include <memory>

namespace CircleOS {
namespace Core {

class PowerManager : public QObject {
    Q_OBJECT
    Q_PROPERTY(int batteryLevel READ batteryLevel NOTIFY batteryLevelChanged)
    Q_PROPERTY(bool isCharging READ isCharging NOTIFY chargingChanged)
    Q_PROPERTY(QString powerProfile READ powerProfile NOTIFY powerProfileChanged)

public:
    explicit PowerManager(QObject *parent = nullptr);
    ~PowerManager() override;

    int batteryLevel() const;
    bool isCharging() const;
    QString powerProfile() const;

public slots:
    void updateBatteryStatus();
    void setPowerProfile(const QString &profile);
    void suspend();
    void hibernate();

signals:
    void batteryLevelChanged(int level);
    void chargingChanged();
    void powerProfileChanged();

private:
    class Private;
    std::unique_ptr<Private> d;
};

} // namespace Core
} // namespace CircleOS
