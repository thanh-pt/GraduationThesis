#ifndef UIBRIDGE_H
#define UIBRIDGE_H
#include <QObject>
#include <QDebug>

class UIBridge : public QObject
{
    Q_OBJECT
public:
    UIBridge();
    ~UIBridge();
public:
    Q_INVOKABLE void changeScreen(QString screenId);
    Q_INVOKABLE void Info(QString info);
//    Q_INVOKABLE void RequestDevice(cmd, parameter);
signals:
    void eventChangeScreen(QString screenId);
    void eventInfo(QString info);
};

#endif // UIBRIDGE_H
