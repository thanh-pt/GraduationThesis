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
    Q_INVOKABLE void ChangeScreen(QString screenId);
signals:
    void eventChangeScreen(QString screenId);
};

#endif // UIBRIDGE_H
