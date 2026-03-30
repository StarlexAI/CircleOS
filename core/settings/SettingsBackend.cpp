#include "SettingsBackend.h"
#include <QSettings>
#include <QStandardPaths>

namespace CircleOS {
namespace Core {

class SettingsBackend::Private {
public:
    std::unique_ptr<QSettings> settings;
};

SettingsBackend::SettingsBackend(QObject *parent)
    : QObject(parent)
    , d(std::make_unique<Private>())
{
    QString configPath = QStandardPaths::writableLocation(QStandardPaths::ConfigLocation);
    configPath += "/circleos/settings.conf";
    
    d->settings = std::make_unique<QSettings>(configPath, QSettings::IniFormat);
}

SettingsBackend::~SettingsBackend() = default;

QVariant SettingsBackend::get(const QString &category, const QString &key, const QVariant &defaultValue) const {
    d->settings->beginGroup(category);
    QVariant value = d->settings->value(key, defaultValue);
    d->settings->endGroup();
    return value;
}

void SettingsBackend::set(const QString &category, const QString &key, const QVariant &value) {
    d->settings->beginGroup(category);
    d->settings->setValue(key, value);
    d->settings->endGroup();
    d->settings->sync();
    
    emit settingChanged(category, key, value);
}

QStringList SettingsBackend::categories() const {
    return d->settings->childGroups();
}

QStringList SettingsBackend::keys(const QString &category) const {
    d->settings->beginGroup(category);
    QStringList keyList = d->settings->childKeys();
    d->settings->endGroup();
    return keyList;
}

void SettingsBackend::reset(const QString &category) {
    d->settings->beginGroup(category);
    d->settings->remove("");
    d->settings->endGroup();
    d->settings->sync();
    
    emit categoryReset(category);
}

} // namespace Core
} // namespace CircleOS
