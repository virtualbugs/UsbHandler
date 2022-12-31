#ifndef UNIXSYSTEM_HPP
#define UNIXSYSTEM_HPP

#include <QStringList>
#include <QProcess>
#include <QDebug>
#include <QRegularExpression>
#include <memory>


class UnixSystem: public QObject
{
    Q_OBJECT
public:
    UnixSystem();
    bool CheckUSBDevices();
    QVector<QVector<QString>> getUsbDevices();

public slots:
    void format(QString, QString);

signals:
    void formatFailured();
    void formatSuccess();

private:
    QVector<QVector<QString>> usbDevices;
};

#endif // UNIXSYSTEM_HPP
