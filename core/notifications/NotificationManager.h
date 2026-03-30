#pragma once

#include <QObject>
#include <QString>
#include <QVariantMap>
#include <memory>

namespace CircleOS {
namespace Core {

class NotificationManager : public QObject {
    Q_OBJECT

public:
    explicit NotificationManager(QObject *parent = nullptr);
    ~NotificationManager() override;

    Q_INVOKABLE void sendNotification(const QString &title, 
                                     const QString &message,
                                     const QString &icon = QString(),
                                     int timeout = 5000);
    
    Q_INVOKABLE void clearNotification(int id);
    Q_INVOKABLE void clearAll();

signals:
    void notificationReceived(int id, const QString &title, const QString &message, const QString &icon);
    void notificationCleared(int id);
    void allCleared();

private:
    class Private;
    std::unique_ptr<Private> d;
};

} // namespace Core
} // namespace CircleOS
