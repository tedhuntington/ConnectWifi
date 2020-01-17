#ifndef CONNECTWINDOW_H
#define CONNECTWINDOW_H
#include <QObject>
#include <QQuickView>
#include <QQuickItem>
#include <QString>


#define CONF_FOLDER     "WorldPro"


class ConnectWindow
{
public:
    ConnectWindow();
    void runConnectWindow();
private:
    QQuickView* m_rootView;
};

#endif // CONNECTWINDOW_H
