#include "Application.h"
#include <QDebug>
#include <systemd/sd-daemon.h>

namespace CircleOS {
namespace Core {

class Application::Private {
public:
    bool running = false;
    QString version = CIRCLEOS_VERSION;
};

Application::Application(QObject *parent)
    : QObject(parent)
    , d(std::make_unique<Private>())
{
    qDebug() << "CircleOS Core Application initialized";
}

Application::~Application() = default;

QString Application::version() const {
    return d->version;
}

bool Application::isRunning() const {
    return d->running;
}

void Application::initialize() {
    if (d->running) return;
    
    qInfo() << "Initializing CircleOS version" << d->version;
    
    // Notify systemd we're ready
    sd_notify(0, "READY=1");
    
    d->running = true;
    emit runningChanged();
    emit initialized();
}

void Application::shutdown() {
    if (!d->running) return;
    
    qInfo() << "Shutting down CircleOS";
    
    sd_notify(0, "STOPPING=1");
    
    d->running = false;
    emit runningChanged();
    emit shutdownRequested();
}

} // namespace Core
} // namespace CircleOS
