#include "DisplayManager.h"
#include <QScreen>
#include <QGuiApplication>

namespace CircleOS {
namespace Core {

class DisplayManager::Private {
public:
    int brightness = 80;
    QSize resolution = QSize(1920, 1080);
    int refreshRate = 60;
    double scaling = 1.0;
};

DisplayManager::DisplayManager(QObject *parent)
    : QObject(parent)
    , d(std::make_unique<Private>())
{
    // Get current screen info
    if (QGuiApplication::primaryScreen()) {
        d->resolution = QGuiApplication::primaryScreen()->size();
        d->refreshRate = QGuiApplication::primaryScreen()->refreshRate();
    }
}

DisplayManager::~DisplayManager() = default;

int DisplayManager::brightness() const {
    return d->brightness;
}

QSize DisplayManager::resolution() const {
    return d->resolution;
}

int DisplayManager::refreshRate() const {
    return d->refreshRate;
}

double DisplayManager::scaling() const {
    return d->scaling;
}

void DisplayManager::setBrightness(int brightness) {
    if (brightness < 0) brightness = 0;
    if (brightness > 100) brightness = 100;
    
    if (d->brightness == brightness) return;
    d->brightness = brightness;
    emit brightnessChanged();
}

void DisplayManager::setResolution(const QSize &resolution) {
    if (d->resolution == resolution) return;
    d->resolution = resolution;
    emit resolutionChanged();
}

void DisplayManager::setRefreshRate(int rate) {
    if (d->refreshRate == rate) return;
    d->refreshRate = rate;
    emit refreshRateChanged();
}

void DisplayManager::setScaling(double scaling) {
    if (d->scaling == scaling) return;
    d->scaling = scaling;
    emit scalingChanged();
}

} // namespace Core
} // namespace CircleOS
