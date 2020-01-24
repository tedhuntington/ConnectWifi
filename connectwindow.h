#ifndef CONNECTWINDOW_H
#define CONNECTWINDOW_H

#include <QObject>
#include <QString>
#include <QTimer>
//#include <QDebug>
#include <QQuickView>
#include <QQuickItem>

#define CONF_FOLDER     "WorldPro"


class ConnectWindow : public QObject
{
    Q_OBJECT
public:        
    explicit ConnectWindow(QObject *parent = nullptr);
    // ~ConnectWindow();
    void runConnectWindow();

signals:

public slots:
    void TimerEvent();
    void onEscapeKeyExit();
    void onConnectWiFiButton();

private:
    QQuickView *m_rootView;
    QTimer *m_scanAPs_timer;  //timer to scan for WiFi APs
};

#endif // CONNECTWINDOW_H
