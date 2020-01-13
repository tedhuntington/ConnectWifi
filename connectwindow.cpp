#include "connectwindow.h"

ConnectWindow::ConnectWindow()
{

}


void ConnectWindow::runConnectWindow()
{
    m_rootView = new QQuickView;
    m_rootView->setSource(QUrl(QStringLiteral("qrc:///main.qml")));
    m_rootView->setResizeMode(QQuickView::SizeRootObjectToView);
    //m_rootView->showFullScreen();
    m_rootView->showNormal();

    QObject*obj = m_rootView->rootObject();
    QQuickItem*item = qobject_cast<QQuickItem*>(obj);

    //connect qml signals
    //QObject::connect(item,SIGNAL(pushStartRequest()), this,SLOT(onPushStartRequest()));
    //QObject::connect(item,SIGNAL(escapeKeyExit()), this,SLOT(onEscapeKeyExit()));


}
