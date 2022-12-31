#include "BackEndCore.hpp"

BackEndCore::BackEndCore(QObject *parent) :
    QObject(parent)
{

    connect(&unixSystem, SIGNAL(formatSuccess()), this, SIGNAL(formatSuccess()));
    connect(&unixSystem, SIGNAL(formatFailured()), this, SIGNAL(formatFailured()));

    connect(this, SIGNAL(format(QString, QString)), &unixSystem, SLOT(format(QString, QString)));
}

void BackEndCore::checkUSBDevices(QString s)
{
    qDebug() << "clicked : " << s;
    unixSystem.CheckUSBDevices();

    emit usbDevicesFound(unixSystem.getUsbDevices());
}
