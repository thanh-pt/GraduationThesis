#include "UIBridge.h"

UIBridge::UIBridge()
{
}

UIBridge::~UIBridge()
{
}

void UIBridge::changeScreen(QString screenId)
{
    emit eventChangeScreen(screenId);
}

void UIBridge::Info(QString info)
{
    emit eventInfo(info);
}

