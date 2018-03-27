#ifndef APPMAIN_H
#define APPMAIN_H

#include <QObject>
#include <QQuickItem>
#include <QQuickView>
#include <QQmlContext>
#include <QQmlEngine>
#include <QDebug>
#include "UIBridge.h"
#include "screendefine.h"

class UIBridge;

class AppMain : public QObject
{
    Q_OBJECT
public:
    QQuickView view;
    QObject *obj;
    QObject *mainLoader;
    UIBridge *m_uibridge;
public:
    AppMain();
    virtual ~AppMain();
private:
    void Connection();
public:
    void onScreen();
public slots:
    void onScreenChange(QString source);
    void onInfo(QString info);
};

#endif // APPMAIN_H
