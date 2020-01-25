#ifndef CONNECTWINDOW_H
#define CONNECTWINDOW_H

#include <QObject>
#include <QString>
#include <QTimer>
//#include <QDebug>
#include <QQuickView>
#include <QQuickItem>
#include <scanapthread.h>


class ConnectWindow : public QObject
{
    Q_OBJECT
public:        
    explicit ConnectWindow(QObject *parent = nullptr);
    // ~ConnectWindow();
    void runConnectWindow();

signals:

public slots:
    //void TimerEvent();
    void onEscapeKeyExit();
    void onConnectWiFiButton();
    void onScanComplete(); //after scan fill entries

private:
    QQuickView *m_rootView;
    int m_timerCount; //counts timer events
    bool m_completedAPScan; //completed AP scan
    //QTimer *m_scanAPs_timer;  //timer to scan for WiFi APs
    ScanAPThread thread;
};

#endif // CONNECTWINDOW_H
