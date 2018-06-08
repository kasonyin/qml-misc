#include "pagemodeltest.h"
#include <QSqlQuery>
#include <QDebug>

PageModelTest::PageModelTest(QObject *parent)
{
}

QVariant PageModelTest::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() < 0 || m_data.size() <= index.row()) {
        return QVariant();
    }

    const TestData &data = m_data.at(index.row());

    switch (role) {
    case idRole:    return data.pid;
    case nameRole:  return data.strName;
    case ageRole:   return data.age;
    default: break;
    }

    return QVariant();
}

int PageModelTest::rowCount(const QModelIndex &parent) const
{
    return m_data.size();
}

QHash<int, QByteArray> PageModelTest::roleNames() const
{
    static QHash<int, QByteArray>names;

    if (0 == names.size()) {
        names.insert(idRole, "pid");
        names.insert(nameRole, "name");
        names.insert(ageRole, "age");
    }

    return names;
}

void PageModelTest::update(QSqlQuery &query)
{
    beginResetModel();

    m_data.clear();

    while (query.next()) {
        TestData data;
        data.pid = query.value("id").toInt();
        data.strName = query.value("name").toString();
        data.age = query.value("age").toInt();

        m_data.append(data);
    }
    endResetModel();
}
