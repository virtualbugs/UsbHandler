#ifndef BACKENDMAIN_HPP
#define BACKENDMAIN_HPP

#include "UnixSystem.hpp"

#include <QObject>
#include <QString>
#include <qqml.h>

class BackEndCore: public QObject
{
    Q_OBJECT

public:
    explicit BackEndCore(QObject *parent = nullptr);

signals:
    void usbDevicesFound(QVector<QVector<QString>>);
    void formatSuccess();
    void formatFailured();
    void format(QString, QString);
public slots:
    void checkUSBDevices(QString s);

private:
    UnixSystem unixSystem;
};

#endif // BACKENDMAIN_HPP
