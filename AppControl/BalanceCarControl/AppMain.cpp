#include "AppMain.h"

AppMain::AppMain()
    : obj(nullptr)
    , mainLoader(nullptr)
    , m_uibridge(nullptr)
{
    m_uibridge = new UIBridge();
    view.engine()->rootContext()->setContextProperty("UIBridge",m_uibridge);
    view.setSource(QUrl(SCREEN_MAIN));
    obj = view.rootObject();
    mainLoader = obj->findChild<QObject*>("objMainLoader");
    Connection();
}

AppMain::~AppMain()
{
    delete obj;
    delete mainLoader;
    delete m_uibridge;
}

void AppMain::Connection()
{
    QObject::connect(m_uibridge, SIGNAL(eventChangeScreen(QString)),this,SLOT(onScreenChange(QString)));
    QObject::connect(m_uibridge, SIGNAL(eventInfo(QString)),this,SLOT(onInfo(QString)));
}

void AppMain::onScreen()
{
    view.show();
    if (mainLoader){
        mainLoader->setProperty("source","qrc:/pages/Menu.qml");
    }
}

void AppMain::onScreenChange(QString source)
{
    qDebug() << "[AppMain][onScreenChange]source: " << source;
    mainLoader->setProperty("source",source);
}

void AppMain::onInfo(QString info)
{
    qDebug() << "[AppMain][onInfo]source: " << info;
    obj->setProperty("infomation",info);
}

