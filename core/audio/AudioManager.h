#pragma once

#include <QObject>
#include <memory>

namespace CircleOS {
namespace Core {

class AudioManager : public QObject {
    Q_OBJECT
    Q_PROPERTY(int volume READ volume NOTIFY volumeChanged)
    Q_PROPERTY(bool isMuted READ isMuted NOTIFY mutedChanged)

public:
    explicit AudioManager(QObject *parent = nullptr);
    ~AudioManager() override;

    int volume() const;
    bool isMuted() const;

public slots:
    void setVolume(int volume);
    void setMuted(bool muted);
    void increaseVolume();
    void decreaseVolume();
    void toggleMute();
    void updateVolume();

signals:
    void volumeChanged(int volume);
    void mutedChanged();

private:
    class Private;
    std::unique_ptr<Private> d;
};

} // namespace Core
} // namespace CircleOS
