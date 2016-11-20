#ifndef UTILSIOS_H
#define UTILSIOS_H

#include <QObject>

class UtilsIOS : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString imagePath READ imagePath NOTIFY imagePathChanged)

public:
    explicit UtilsIOS(QObject *parent = 0);

    QString imagePath() {
        return m_imagePath;
    }


    bool saveImgToGallery(const QImage& qimg4Album);

signals:
    void imagePathChanged();

public slots:

private:
    QString m_imagePath;
};

#endif // UTILSIOS_H

