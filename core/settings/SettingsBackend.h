#pragma once

#include <QObject>
#include <QVariant>
#include <QString>
#include <QStringList>
#include <memory>

namespace CircleOS {
namespace Core {

class SettingsBackend : public QObject {
    Q_OBJECT

public:
    explicit SettingsBackend(QObject *parent = nullptr);
    ~SettingsBackend() override;

    Q_INVOKABLE QVariant get(const QString &category, const QString &key, const QVariant &defaultValue = QVariant()) const;
    Q_INVOKABLE void set(const QString &category, const QString &key, const QVariant &value);
    Q_INVOKABLE QStringList categories() const;
    Q_INVOKABLE QStringList keys(const QString &category) const;
    Q_INVOKABLE void reset(const QString &category);

signals:
    void settingChanged(const QString &category, const QString &key, const QVariant &value);
    void categoryReset(const QString &category);

private:
    class Private;
    std::unique_ptr<Private> d;
};

} // namespace Core
} // namespace CircleOS
