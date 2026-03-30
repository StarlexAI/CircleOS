#pragma once

#include <QObject>
#include <QVariant>
#include <QString>
#include <memory>

namespace CircleOS {
namespace Core {

class ConfigManager : public QObject {
    Q_OBJECT
    Q_PROPERTY(QString configPath READ configPath CONSTANT)

public:
    explicit ConfigManager(QObject *parent = nullptr);
    ~ConfigManager() override;

    Q_INVOKABLE QVariant value(const QString &key, const QVariant &defaultValue = QVariant()) const;
    Q_INVOKABLE void setValue(const QString &key, const QVariant &value);
    Q_INVOKABLE void remove(const QString &key);
    Q_INVOKABLE bool contains(const QString &key) const;
    Q_INVOKABLE void sync();

    QString configPath() const;

signals:
    void valueChanged(const QString &key, const QVariant &value);

private:
    class Private;
    std::unique_ptr<Private> d;
};

} // namespace Core
} // namespace CircleOS
