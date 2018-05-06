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

void UIBridge::info(QString info)
{
    emit eventInfo(info);
}

