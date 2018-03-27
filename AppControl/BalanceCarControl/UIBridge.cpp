#include "UIBridge.h"

UIBridge::UIBridge()
{
}

UIBridge::~UIBridge()
{
}

void UIBridge::ChangeScreen(QString screenId)
{
    emit eventChangeScreen(screenId);
}

void UIBridge::Info(QString info)
{
    emit eventInfo(info);
}

