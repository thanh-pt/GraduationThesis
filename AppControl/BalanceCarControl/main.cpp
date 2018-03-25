//#include <QGuiApplication>
#include <QtWidgets/QApplication>
#include "AppMain.h"

int main(int argc, char *argv[])
{
//    QGuiApplication app(argc, argv);
    QApplication app(argc, argv);
    AppMain appMain;
    appMain.onScreen();
    return app.exec();
}
