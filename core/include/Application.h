#pragma once

#include <QObject>
#include <QString>
#include <memory>

namespace CircleOS {
namespace Core {

class Application : public QObject {
    Q_OBJECT
    Q_PROPERTY(QString version READ version CONSTANT)
    Q_PROPERTY(bool isRunning READ isRunning NOTIFY runningChanged)

public:
    explicit Application(QObject *parent = nullptr);
    ~Application() override;

    QString version() const;
    bool isRunning() const;

    Q_INVOKABLE void initialize();
    Q_INVOKABLE void shutdown();

signals:
    void runningChanged();
    void initialized();
    void shutdownRequested();

private:
    class Private;
    std::unique_ptr<Private> d;
};

} // namespace Core
} // namespace CircleOS
