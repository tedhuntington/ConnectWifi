#include <unistd.h>
#include <sys/types.h>
#include <pwd.h>
#include "scanapthread.h"
#include "commdef.h"


ScanAPThread::ScanAPThread(QObject *parent) : QThread(parent)
{
    restart = false;
}

ScanAPThread::~ScanAPThread()
{
    mutex.lock();
    //abort = true;
    condition.wakeOne();
    mutex.unlock();

    wait();
}


void ScanAPThread::scanAPs(void)
{
    QMutexLocker locker(&mutex);

    if (!isRunning()) {
        start(LowPriority);
    } else {
        restart = true;
        condition.wakeOne();
    }
}


void ScanAPThread::run()
{
    char tempstr[300];
    char tempfile[1024];
    const char *homedir;

   // forever {


     //scan wifi APs available
     homedir = getpwuid(getuid())->pw_dir;
     snprintf(tempfile,sizeof(tempfile),"%s/%s/epro_wifi_temp.txt",homedir,CONF_FOLDER);
     //ifconfig | grep wlo1  - returns wlo1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500

     //snprintf(tempstr,sizeof(tempstr),"sudo iwlist wlo1 scanning | egrep 'Cell |Encryption|Quality|Last beacon|ESSID' > %s",tempfile);
     snprintf(tempstr,sizeof(tempstr),"sudo iwlist wlo1 scanning | egrep 'ESSID' > %s",tempfile);
     system(tempstr);

 //    m_scanAPs_timer->stop(); //restart timer for a 5 second interval
 //    m_scanAPs_timer->start(1000); //start scan wifi timer

      emit APScanComplete();  //emit signal indicating that scan is complete
   // } //forever

}
