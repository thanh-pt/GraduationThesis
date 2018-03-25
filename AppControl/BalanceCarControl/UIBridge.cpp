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
