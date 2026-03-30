#include "ConfigManager.h"
#include <QSettings>
#include <QStandardPaths>
#include <QDir>

namespace CircleOS {
namespace Core {

class ConfigManager::Private {
public:
    std::unique_ptr<QSettings> settings;
    QString configPath;
};

ConfigManager::ConfigManager(QObject *parent)
    : QObject(parent)
    , d(std::make_unique<Private>())
{
    QString configDir = QStandardPaths::writableLocation(QStandardPaths::ConfigLocation);
    configDir += "/circleos";
    
    QDir dir;
    dir.mkpath(configDir);
    
    d->configPath = configDir + "/config.ini";
    d->settings = std::make_unique<QSettings>(d->configPath, QSettings::IniFormat);
}

ConfigManager::~ConfigManager() = default;

QVariant ConfigManager::value(const QString &key, const QVariant &defaultValue) const {
    return d->settings->value(key, defaultValue);
}

void ConfigManager::setValue(const QString &key, const QVariant &value) {
    d->settings->setValue(key, value);
    d->settings->sync();
    emit valueChanged(key, value);
}

void ConfigManager::remove(const QString &key) {
    d->settings->remove(key);
    d->settings->sync();
}

bool ConfigManager::contains(const QString &key) const {
    return d->settings->contains(key);
}

void ConfigManager::sync() {
    d->settings->sync();
}

QString ConfigManager::configPath() const {
    return d->configPath;
}

} // namespace Core
} // namespace CircleOS
