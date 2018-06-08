#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QSqlDatabase>
#include <QDebug>
#include <QSqlQuery>
#include <QSqlError>
#include "pagemodeltest.h"


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
//    db.setHostName("bigblue");
    db.setDatabaseName("data.db");
//    db.setUserName("kason");
//    db.setPassword("123456");

    if (!db.open()) {
        qDebug() << "[main]-Info:open database: data.db failed!";
    } else {
        QSqlQuery query;
        QString sql = QString("create Table if not exists test("
                              "id       INTEGER         PRIMARY KEY AUTOINCREMENT,"
                              "name     VARCHAR(32)     DEFAULT NULL, "
                              "age      INTEGER         NOT NULL)");

        if (!query.exec(sql)) {
            qDebug() << "[main]-Error: " << query.lastError().text();
        }
    }

    qmlRegisterType<PageModelTest>("Misc", 1, 0, "PageModelTest");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
