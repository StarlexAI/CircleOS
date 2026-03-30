#pragma once

#include <QObject>
#include <QString>
#include <memory>

namespace CircleOS {
namespace Core {

class SessionManager : public QObject {
    Q_OBJECT
    Q_PROPERTY(bool isLocked READ isLocked NOTIFY lockedChanged)
    Q_PROPERTY(QString sessionId READ sessionId CONSTANT)

public:
    explicit SessionManager(QObject *parent = nullptr);
    ~SessionManager() override;

    bool isLocked() const;
    QString sessionId() const;

public slots:
    void lock();
    void unlock();
    void logout();
    void shutdown();
    void reboot();

signals:
    void lockedChanged();
    void logoutRequested();
    void shutdownRequested();
    void rebootRequested();

private:
    class Private;
    std::unique_ptr<Private> d;
};

} // namespace Core
} // namespace CircleOS
