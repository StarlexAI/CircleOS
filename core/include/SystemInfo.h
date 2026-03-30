#pragma once

#include <QObject>
#include <QString>
#include <memory>

namespace CircleOS {
namespace Core {

class SystemInfo : public QObject {
    Q_OBJECT
    Q_PROPERTY(QString hostname READ hostname NOTIFY updated)
    Q_PROPERTY(QString kernel READ kernel NOTIFY updated)
    Q_PROPERTY(QString osVersion READ osVersion NOTIFY updated)
    Q_PROPERTY(quint64 totalMemory READ totalMemory NOTIFY updated)
    Q_PROPERTY(int cpuCores READ cpuCores NOTIFY updated)

public:
    explicit SystemInfo(QObject *parent = nullptr);
    ~SystemInfo() override;

    QString hostname() const;
    QString kernel() const;
    QString osVersion() const;
    quint64 totalMemory() const;
    int cpuCores() const;

    Q_INVOKABLE void refresh();

signals:
    void updated();

private:
    class Private;
    std::unique_ptr<Private> d;
};

} // namespace Core
} // namespace CircleOS
