#include "InputManager.h"

namespace CircleOS {
namespace Core {

class InputManager::Private {
public:
    QString keyboardLayout = "us";
    int keyRepeatDelay = 500;
    int keyRepeatRate = 30;
    double mouseSpeed = 1.0;
};

InputManager::InputManager(QObject *parent)
    : QObject(parent)
    , d(std::make_unique<Private>())
{
}

InputManager::~InputManager() = default;

QString InputManager::keyboardLayout() const {
    return d->keyboardLayout;
}

int InputManager::keyRepeatDelay() const {
    return d->keyRepeatDelay;
}

int InputManager::keyRepeatRate() const {
    return d->keyRepeatRate;
}

double InputManager::mouseSpeed() const {
    return d->mouseSpeed;
}

void InputManager::setKeyboardLayout(const QString &layout) {
    if (d->keyboardLayout == layout) return;
    d->keyboardLayout = layout;
    emit keyboardLayoutChanged();
}

void InputManager::setKeyRepeatDelay(int delay) {
    if (d->keyRepeatDelay == delay) return;
    d->keyRepeatDelay = delay;
    emit keyRepeatDelayChanged();
}

void InputManager::setKeyRepeatRate(int rate) {
    if (d->keyRepeatRate == rate) return;
    d->keyRepeatRate = rate;
    emit keyRepeatRateChanged();
}

void InputManager::setMouseSpeed(double speed) {
    if (d->mouseSpeed == speed) return;
    d->mouseSpeed = speed;
    emit mouseSpeedChanged();
}

} // namespace Core
} // namespace CircleOS
