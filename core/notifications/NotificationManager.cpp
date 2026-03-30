#include "NotificationManager.h"
#include <QDBusConnection>
#include <QDBusMessage>
#include <QTimer>

namespace CircleOS {
namespace Core {

class NotificationManager::Private {
public:
    int nextId = 1;
};

NotificationManager::NotificationManager(QObject *parent)
    : QObject(parent)
    , d(std::make_unique<Private>())
{
}

NotificationManager::~NotificationManager() = default;

void NotificationManager::sendNotification(const QString &title, 
                                          const QString &message,
                                          const QString &icon,
                                          int timeout)
{
    int id = d->nextId++;
    
    qInfo() << "Notification:" << title << "-" << message;
    
    emit notificationReceived(id, title, message, icon);
    
    // Auto-clear after timeout
    if (timeout > 0) {
        QTimer::singleShot(timeout, this, [this, id]() {
            clearNotification(id);
        });
    }
}

void NotificationManager::clearNotification(int id) {
    emit notificationCleared(id);
}

void NotificationManager::clearAll() {
    emit allCleared();
}

} // namespace Core
} // namespace CircleOS
