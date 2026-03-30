#pragma once

#include <QObject>
#include <QString>
#include <QImage>
#include <memory>

namespace CircleOS {
namespace Core {

class ClipboardManager : public QObject {
    Q_OBJECT
    Q_PROPERTY(QString text READ text NOTIFY textChanged)
    Q_PROPERTY(bool hasText READ hasText NOTIFY hasTextChanged)
    Q_PROPERTY(bool hasImage READ hasImage NOTIFY hasImageChanged)

public:
    explicit ClipboardManager(QObject *parent = nullptr);
    ~ClipboardManager() override;

    QString text() const;
    bool hasText() const;
    bool hasImage() const;
    QImage image() const;

public slots:
    void setText(const QString &text);
    void setImage(const QImage &image);
    void clear();

signals:
    void textChanged();
    void hasTextChanged();
    void hasImageChanged();
    void clipboardChanged();

private:
    class Private;
    std::unique_ptr<Private> d;
};

} // namespace Core
} // namespace CircleOS
