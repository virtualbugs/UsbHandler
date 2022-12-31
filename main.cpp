#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <QQuickItem>
#include <QQmlContext>

#include "cpp/BackEndCore.hpp"


int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));
    engine.load(url);

    QObject *item = engine.rootObjects().at(0);
    QQuickWindow *window = qobject_cast<QQuickWindow *>(item);

    BackEndCore backEndCore;

    engine.rootContext()->setContextProperty("qmlSlots", &backEndCore);

    engine.connect(window, SIGNAL(checkUSBDevices(QString)),
                     &backEndCore, SLOT(checkUSBDevices(QString)));
    engine.connect(window, SIGNAL(format(QString, QString)),
                     &backEndCore, SIGNAL(format(QString, QString)));

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);


    return app.exec();
}
