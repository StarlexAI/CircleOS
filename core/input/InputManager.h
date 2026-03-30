#pragma once

#include <QObject>
#include <QString>
#include <QVariantMap>
#include <memory>

namespace CircleOS {
namespace Core {

class InputManager : public QObject {
    Q_OBJECT
    Q_PROPERTY(QString keyboardLayout READ keyboardLayout NOTIFY keyboardLayoutChanged)
    Q_PROPERTY(int keyRepeatDelay READ keyRepeatDelay NOTIFY keyRepeatDelayChanged)
    Q_PROPERTY(int keyRepeatRate READ keyRepeatRate NOTIFY keyRepeatRateChanged)
    Q_PROPERTY(double mouseSpeed READ mouseSpeed NOTIFY mouseSpeedChanged)

public:
    explicit InputManager(QObject *parent = nullptr);
    ~InputManager() override;

    QString keyboardLayout() const;
    int keyRepeatDelay() const;
    int keyRepeatRate() const;
    double mouseSpeed() const;

public slots:
    void setKeyboardLayout(const QString &layout);
    void setKeyRepeatDelay(int delay);
    void setKeyRepeatRate(int rate);
    void setMouseSpeed(double speed);

signals:
    void keyboardLayoutChanged();
    void keyRepeatDelayChanged();
    void keyRepeatRateChanged();
    void mouseSpeedChanged();

private:
    class Private;
    std::unique_ptr<Private> d;
};

} // namespace Core
} // namespace CircleOS
