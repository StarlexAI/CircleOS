#pragma once

#include <QObject>
#include <QString>
#include <QStringList>
#include <memory>

namespace CircleOS {
namespace Core {

class WallpaperManager : public QObject {
    Q_OBJECT
    Q_PROPERTY(QString currentWallpaper READ currentWallpaper NOTIFY currentWallpaperChanged)
    Q_PROPERTY(QString wallpaperMode READ wallpaperMode NOTIFY wallpaperModeChanged)

public:
    explicit WallpaperManager(QObject *parent = nullptr);
    ~WallpaperManager() override;

    QString currentWallpaper() const;
    QString wallpaperMode() const;
    QStringList availableWallpapers() const;

public slots:
    void setWallpaper(const QString &path);
    void setWallpaperMode(const QString &mode); // "fill", "fit", "stretch", "tile", "center"
    void nextWallpaper();
    void previousWallpaper();

signals:
    void currentWallpaperChanged();
    void wallpaperModeChanged();

private:
    class Private;
    std::unique_ptr<Private> d;
};

} // namespace Core
} // namespace CircleOS
