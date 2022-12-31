#include "UnixSystem.hpp"


// UNIX Command List
QString bash_program = "/bin/bash";
QStringList bash_arg_CheckUSBDevices = QStringList() << "-c" << "sudo df -Th | grep media";
QStringList bash_arg_unmountUSB = QStringList() << "-c" << "sudo umount -l ";
QStringList bash_arg_formatFAT32 = QStringList() << "-c" << "sudo mkfs.vfat ";
QStringList bash_arg_formatNTFS = QStringList() << "-c" << "sudo mkfs.ntfs ";
QStringList bash_arg_formatEXFAT = QStringList() << "-c" << "sudo mkfs.exfat ";


UnixSystem::UnixSystem()
{
}


bool UnixSystem::CheckUSBDevices()
{
    //QString cmd = "/bin/bash -c \"sudo df -Th | grep media\" ";
    //qDebug() << QProcess::splitCommand(cmd);

    std::unique_ptr<QProcess> processCheckUSBDevices(new QProcess(this));
    processCheckUSBDevices->start(bash_program, bash_arg_CheckUSBDevices);

    if (!processCheckUSBDevices->waitForStarted()) {
        qDebug() << "fail on CheckUSBDevices::waitForStarted()";
        return false;
    }
    if (!processCheckUSBDevices->waitForFinished()) {
        qDebug() << "fail on CheckUSBDevices::waitForFinished()";
        return false;
    }

    QByteArray result = processCheckUSBDevices->readAllStandardOutput();
    if(result == "") {
        qDebug() << "fail on CheckUSBDevices::readAllStandardOutput()";
        return false;
    }

    QList<QByteArray> splittedResult = result.simplified().split(' ');
    int deviceCount = splittedResult.size()/7;
    qDebug() << "Device Count : " << splittedResult.size()/7;

    for(int i=0; i<deviceCount; i++) {
        QVector<QString> deviceInfo;
        QString devicePath = splittedResult[0+7*i];
        QString deviceFormat = splittedResult[1+7*i];
        QString deviceSize = splittedResult[2+7*i];
        QString deviceUsagePercentageTemp = splittedResult[5+7*i];
        QString deviceUsagePercentage;
        for(int i=0; i<deviceUsagePercentageTemp.size()-1; i++) {
            deviceUsagePercentage += deviceUsagePercentageTemp[i];
        }
        deviceUsagePercentage = QString::number(deviceUsagePercentage.toInt() / 100.0);

        QString deviceName = splittedResult[6+7*i].simplified().split('/')[3];

        deviceInfo.push_back(deviceName);
        deviceInfo.push_back(devicePath);
        deviceInfo.push_back(deviceFormat);
        deviceInfo.push_back(deviceSize);
        deviceInfo.push_back(deviceUsagePercentage);

        usbDevices.push_back(deviceInfo);

        qDebug() << "Device Found :";
        qDebug() << "---->>> Device Name : " << deviceName;
        qDebug() << "---->>> Device Path : " << devicePath;
        qDebug() << "---->>> Device Format : " << deviceFormat;
        qDebug() << "---->>> Device Size : " << deviceSize;
        qDebug() << "---->>> Device Usage : " << deviceUsagePercentage;
    }

    return true;
}

QVector<QVector<QString> > UnixSystem::getUsbDevices()
{
    return usbDevices;
}

void UnixSystem::format(QString type, QString usb_path)
{
    qDebug() << usb_path << "  | FAT32 Formatting Started ...";

    bash_arg_unmountUSB[bash_arg_unmountUSB.size()-1] = bash_arg_unmountUSB[bash_arg_unmountUSB.size()-1] + usb_path;
    bash_arg_formatFAT32[bash_arg_formatFAT32.size()-1] = bash_arg_formatFAT32[bash_arg_formatFAT32.size()-1] + usb_path;
    bash_arg_formatNTFS[bash_arg_formatNTFS.size()-1] = bash_arg_formatNTFS[bash_arg_formatNTFS.size()-1] + usb_path;
    bash_arg_formatEXFAT[bash_arg_formatEXFAT.size()-1] = bash_arg_formatEXFAT[bash_arg_formatEXFAT.size()-1] + usb_path;
    QStringList formatCommand;

    if(type == "fat32") {
        formatCommand = bash_arg_formatFAT32;
    }
    else if(type == "ntfs") {
        formatCommand = bash_arg_formatNTFS;
    }
    else if(type == "exfat") {
        formatCommand = bash_arg_formatEXFAT;
    }


    std::unique_ptr<QProcess> processUnmountUSB(new QProcess(this));
    processUnmountUSB->start(bash_program, bash_arg_unmountUSB);

    if (!processUnmountUSB->waitForStarted()) {
        qDebug() << "fail on formatFAT32::waitForStarted()";
        emit formatFailured();
    }
    if (!processUnmountUSB->waitForFinished()) {
        qDebug() << "fail on formatFAT32::waitForFinished()";
        emit formatFailured();
    }

    qDebug() << processUnmountUSB->readAllStandardOutput();


    std::unique_ptr<QProcess> processFormatUSB(new QProcess(this));
    qDebug() << "COMMAND : " << formatCommand;
    processFormatUSB->start(bash_program, formatCommand);

    if (!processFormatUSB->waitForStarted()) {
        qDebug() << "fail on formatFAT32::waitForStarted()";
        emit formatFailured();
    }
    if (!processFormatUSB->waitForFinished()) {
        qDebug() << "fail on formatFAT32::waitForFinished()";
        emit formatFailured();
    }

    qDebug() << processFormatUSB->readAllStandardOutput();

    emit formatSuccess();
}


