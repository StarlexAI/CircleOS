#include "SystemInfo.h"
#include <QFile>
#include <QTextStream>
#include <QProcess>
#include <sys/sysinfo.h>
#include <unistd.h>

namespace CircleOS {
namespace Core {

class SystemInfo::Private {
public:
    QString hostname;
    QString kernel;
    QString osVersion;
    quint64 totalMemory = 0;
    int cpuCores = 0;
};

SystemInfo::SystemInfo(QObject *parent)
    : QObject(parent)
    , d(std::make_unique<Private>())
{
    refresh();
}

SystemInfo::~SystemInfo() = default;

void SystemInfo::refresh() {
    // Get hostname
    char hostnameBuffer[256];
    if (gethostname(hostnameBuffer, sizeof(hostnameBuffer)) == 0) {
        d->hostname = QString::fromLatin1(hostnameBuffer);
    }
    
    // Get kernel version
    QProcess uname;
    uname.start("uname", QStringList() << "-r");
    uname.waitForFinished();
    d->kernel = QString::fromUtf8(uname.readAllStandardOutput()).trimmed();
    
    // Get OS version
    d->osVersion = CIRCLEOS_VERSION;
    
    // Get memory info
    struct sysinfo si;
    if (sysinfo(&si) == 0) {
        d->totalMemory = si.totalram * si.mem_unit;
    }
    
    // Get CPU cores
    d->cpuCores = sysconf(_SC_NPROCESSORS_ONLN);
    
    emit updated();
}

QString SystemInfo::hostname() const {
    return d->hostname;
}

QString SystemInfo::kernel() const {
    return d->kernel;
}

QString SystemInfo::osVersion() const {
    return d->osVersion;
}

quint64 SystemInfo::totalMemory() const {
    return d->totalMemory;
}

int SystemInfo::cpuCores() const {
    return d->cpuCores;
}

} // namespace Core
} // namespace CircleOS
