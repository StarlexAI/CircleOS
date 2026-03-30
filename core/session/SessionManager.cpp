#include "SessionManager.h"
#include <QDBusConnection>
#include <QDBusInterface>
#include <QDBusReply>
#include <QProcess>
#include <systemd/sd-login.h>

namespace CircleOS {
namespace Core {

class SessionManager::Private {
public:
    bool locked = false;
    QString sessionId;
    QDBusInterface *logindInterface = nullptr;
};

SessionManager::SessionManager(QObject *parent)
    : QObject(parent)
    , d(std::make_unique<Private>())
{
    // Get current session ID
    char *session = nullptr;
    if (sd_pid_get_session(getpid(), &session) >= 0) {
        d->sessionId = QString::fromUtf8(session);
        free(session);
    }
    
    // Connect to systemd-logind
    d->logindInterface = new QDBusInterface(
        "org.freedesktop.login1",
        "/org/freedesktop/login1",
        "org.freedesktop.login1.Manager",
        QDBusConnection::systemBus(),
        this
    );
}

SessionManager::~SessionManager() = default;

bool SessionManager::isLocked() const {
    return d->locked;
}

void SessionManager::lock() {
    if (d->locked) return;
    
    // Launch lock screen
    QProcess::startDetached("circleos-lockscreen");
    
    d->locked = true;
    emit lockedChanged();
}

void SessionManager::unlock() {
    if (!d->locked) return;
    
    d->locked = false;
    emit lockedChanged();
}

void SessionManager::logout() {
    emit logoutRequested();
    
    // Terminate session via logind
    if (d->logindInterface && d->logindInterface->isValid()) {
        d->logindInterface->call("TerminateSession", d->sessionId);
    }
}

void SessionManager::shutdown() {
    emit shutdownRequested();
    
    // Shutdown via logind
    if (d->logindInterface && d->logindInterface->isValid()) {
        d->logindInterface->call("PowerOff", true);
    }
}

void SessionManager::reboot() {
    emit rebootRequested();
    
    // Reboot via logind
    if (d->logindInterface && d->logindInterface->isValid()) {
        d->logindInterface->call("Reboot", true);
    }
}

QString SessionManager::sessionId() const {
    return d->sessionId;
}

} // namespace Core
} // namespace CircleOS
