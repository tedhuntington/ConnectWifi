#ifndef SCANAPTHREAD_H
#define SCANAPTHREAD_H

#include <QObject>
#include <QThread>
#include <QMutex>
#include <QWaitCondition>


class ScanAPThread : public QThread
{
    Q_OBJECT
public:
    ScanAPThread(QObject *parent = nullptr);
    ~ScanAPThread();
    void scanAPs(void);

signals:
    void APScanComplete();

protected:
    void run() override;


public slots:

private:
    QMutex mutex;
    QWaitCondition condition;
    bool restart;
};

#endif // SCANAPTHREAD_H
