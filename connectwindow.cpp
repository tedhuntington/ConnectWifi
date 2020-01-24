#include <unistd.h>
#include <sys/types.h>
#include <pwd.h>
#include "connectwindow.h"


ConnectWindow::ConnectWindow(QObject *parent) : QObject(parent), m_rootView(nullptr)
{

    //todo: add hourglass or pop up "Scanning..."
    m_scanAPs_timer = new QTimer(this);
    connect(m_scanAPs_timer, SIGNAL(timeout()), this, SLOT(TimerEvent()));
}

void ConnectWindow::TimerEvent(void)
{
    QObject*obj = m_rootView->rootObject();

    //call ScanAPs thread

    //scan wifi APs available
    const char *homedir;

    homedir = getpwuid(getuid())->pw_dir;
    char tempfile[1024];
    snprintf(tempfile,sizeof(tempfile),"%s/%s/epro_wifi_temp.txt",homedir,CONF_FOLDER);
    char tempstr[300];
    //ifconfig | grep wlo1  - returns wlo1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500

    //snprintf(tempstr,sizeof(tempstr),"sudo iwlist wlo1 scanning | egrep 'Cell |Encryption|Quality|Last beacon|ESSID' > %s",tempfile);
    snprintf(tempstr,sizeof(tempstr),"sudo iwlist wlo1 scanning | egrep 'ESSID' > %s",tempfile);
    system(tempstr);
    QFile file(tempfile);

    //QMetaObject::invokeMethod(obj, "next");


    bool openrv = file.open(QIODevice::ReadOnly);
    if (openrv) {
        qint64 filesize = 0;
        filesize = file.size();
        if (filesize > 0) {
            QTextStream in(&file);
            int numline;
            numline=0;
            QMetaObject::invokeMethod(obj, "clearRecord", Qt::DirectConnection);
            while (!in.atEnd())
            {
               QString line = in.readLine();
               line = line.replace("ESSID:","");
               line = line.replace("\"","");
               //add ESSID to scroll area
               //QMetaObject::invokeMethod(obj, "addRecord", Q_ARG(QString, line));
               //line = '<style="font-size:20pt;">' + line + '</style>';
               QMetaObject::invokeMethod(obj, "addRecord", Qt::DirectConnection,Q_ARG(QVariant, line.trimmed()));

               //obj->setProperty("scrollView", angle);
               //page.dataModel.push(newItem)
               //page.dataModelChanged()

               // signal change in data model to trigger UI update (list view)
               numline++;
            }
            if (numline>1) {  //more than one process name with ePRO
                /*
                //popup a window and exit
                QMessageBox msgBox;
                msgBox.setText("ePRO icon was double clicked and program has opened twice.  Please exit the program and click the ePRO icon only once.");
                msgBox.setWindowFlags(msgBox.windowFlags() | Qt::WindowStaysOnTopHint);
                msgBox.exec();
                msgBox.raise();
                file.close();
                file.remove();
                return(1);
                */
            }
        }  //filesize>0
    file.close();
    file.remove();
    //return(0);
    }  //if openrv
    m_scanAPs_timer->stop(); //restart timer for a 5 second interval
    m_scanAPs_timer->start(5000); //start scan wifi timer

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
    QObject::connect(item,SIGNAL(escapeKeyExit()), this,SLOT(onEscapeKeyExit()));
    QObject::connect(item,SIGNAL(connectWiFiButton()), this,SLOT(onConnectWiFiButton()));

    m_scanAPs_timer->start(200); //start scan wifi timer

    //connect qml signals
    //QObject::connect(item,SIGNAL(pushStartRequest()), this,SLOT(onPushStartRequest()));
    //QObject::connect(item,SIGNAL(escapeKeyExit()), this,SLOT(onEscapeKeyExit()));
}


void ConnectWindow::onEscapeKeyExit()
{
    qApp->exit();
}

void ConnectWindow::onConnectWiFiButton()
{
    //Try to connect to AP
    const char *homedir;

    homedir = getpwuid(getuid())->pw_dir;
    char tempfile[1024];
    snprintf(tempfile,sizeof(tempfile),"%s/%s/epro_wifi_temp.txt",homedir,CONF_FOLDER);
    char tempstr[300];
    //ifconfig | grep wlo1  - returns wlo1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500

    QObject*obj = m_rootView->rootObject();

    QString qssid = obj->property("ssid").toString();
    QString qpw = obj->property("password").toString();

    const char *ssid = qssid.toStdString().c_str();
    const char *pw = qpw.toStdString().c_str();

    snprintf(tempstr,sizeof(tempstr),"sudo iwconfig wlo1 essid \"%s\" key \"%s\"",ssid,pw);
    system(tempstr);

    snprintf(tempstr,sizeof(tempstr),"sudo ifconfig wlo1 up");
    system(tempstr);


    //qApp->exit();
}
