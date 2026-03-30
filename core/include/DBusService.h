#pragma once

#include <QObject>
#include <memory>

namespace CircleOS {
namespace Core {

class DBusService : public QObject {
    Q_OBJECT
    Q_PROPERTY(bool isRegistered READ isRegistered NOTIFY registeredChanged)

public:
    explicit DBusService(QObject *parent = nullptr);
    ~DBusService() override;

    bool isRegistered() const;

public slots:
    bool registerService();
    void unregisterService();

signals:
    void registeredChanged();

private:
    class Private;
    std::unique_ptr<Private> d;
};

} // namespace Core
} // namespace CircleOS
