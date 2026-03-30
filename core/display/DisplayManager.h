#pragma once

#include <QObject>
#include <QString>
#include <QSize>
#include <memory>

namespace CircleOS {
namespace Core {

class DisplayManager : public QObject {
    Q_OBJECT
    Q_PROPERTY(int brightness READ brightness NOTIFY brightnessChanged)
    Q_PROPERTY(QSize resolution READ resolution NOTIFY resolutionChanged)
    Q_PROPERTY(int refreshRate READ refreshRate NOTIFY refreshRateChanged)
    Q_PROPERTY(double scaling READ scaling NOTIFY scalingChanged)

public:
    explicit DisplayManager(QObject *parent = nullptr);
    ~DisplayManager() override;

    int brightness() const;
    QSize resolution() const;
    int refreshRate() const;
    double scaling() const;

public slots:
    void setBrightness(int brightness);
    void setResolution(const QSize &resolution);
    void setRefreshRate(int rate);
    void setScaling(double scaling);

signals:
    void brightnessChanged();
    void resolutionChanged();
    void refreshRateChanged();
    void scalingChanged();

private:
    class Private;
    std::unique_ptr<Private> d;
};

} // namespace Core
} // namespace CircleOS
