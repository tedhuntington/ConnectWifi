#ifndef CONNECTWINDOW_H
#define CONNECTWINDOW_H
#include <QObject>
#include <QQuickView>
#include <QQuickItem>
#include <QString>


class ConnectWindow
{
public:
    ConnectWindow();
    void runConnectWindow();
private:
    QQuickView* m_rootView;
};

#endif // CONNECTWINDOW_H
