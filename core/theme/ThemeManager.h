#pragma once

#include <QObject>
#include <QString>
#include <QStringList>
#include <QColor>
#include <memory>

namespace CircleOS {
namespace Core {

class ThemeManager : public QObject {
    Q_OBJECT
    Q_PROPERTY(QString currentTheme READ currentTheme NOTIFY currentThemeChanged)
    Q_PROPERTY(QString colorScheme READ colorScheme NOTIFY colorSchemeChanged)
    Q_PROPERTY(QColor primaryColor READ primaryColor NOTIFY primaryColorChanged)
    Q_PROPERTY(QColor accentColor READ accentColor NOTIFY accentColorChanged)

public:
    explicit ThemeManager(QObject *parent = nullptr);
    ~ThemeManager() override;

    QString currentTheme() const;
    QString colorScheme() const;
    QColor primaryColor() const;
    QColor accentColor() const;
    QStringList availableThemes() const;

public slots:
    void setTheme(const QString &theme);
    void setColorScheme(const QString &scheme); // "light", "dark", "auto"
    void setPrimaryColor(const QColor &color);
    void setAccentColor(const QColor &color);

signals:
    void currentThemeChanged();
    void colorSchemeChanged();
    void primaryColorChanged();
    void accentColorChanged();
    void themeChanged();

private:
    class Private;
    std::unique_ptr<Private> d;
};

} // namespace Core
} // namespace CircleOS
