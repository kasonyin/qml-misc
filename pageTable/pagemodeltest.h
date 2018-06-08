#ifndef PAGEMODELTEST_H
#define PAGEMODELTEST_H

#include "abstractpagemodel.h"
#include <QVector>

struct TestData
{
    int pid;
    QString strName;
    int age;
};

class PageModelTest : public AbstractPageModel
{
    Q_OBJECT
public:
    explicit PageModelTest(QObject *parent = 0);

    enum TestRoleName{
        idRole = Qt::UserRole + 1,
        nameRole,
        ageRole
    };

    QVariant data(const QModelIndex &index, int role) const;
    int rowCount(const QModelIndex &parent) const;
    QHash<int, QByteArray> roleNames() const;

    void update(QSqlQuery &query);

private:
    QVector<TestData> m_data;
};

#endif // PAGEMODELTEST_H
