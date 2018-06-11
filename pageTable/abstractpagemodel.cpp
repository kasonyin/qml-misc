/********************************************************************
* Copyright (c) 2016,深圳市达科为医疗科技有限公司
* All rights reserved.
*
* 文件名称： abstractpagemodel.cpp
* 文件摘要： 部件监控管理类
* 修订历史：    Date               Author             Modification
*            1.2018-6-11           Yinkai             Create
********************************************************************/
#include "abstractpagemodel.h"
#include <QSqlDatabase>
#include <QSqlError>
#include <QDebug>
#include <QSqlQuery>

AbstractPageModel::AbstractPageModel(QObject *parent)
{

}

void AbstractPageModel::initialize()
{
    // step 1: 从数据库中取出对应表的大小
    sql = QString("select count(*) from %1").arg(m_tableName);

    QSqlQuery query;
    if (!query.exec(sql)) {
        qDebug() << "[APageModel]-Error: in initialize, " << query.lastError().text() << sql;
        return;
    }

    query.next();
    m_resultCount = query.value(0).toInt();

    // step 2:计算总页数
    int remainder = m_resultCount % m_resultCurrent;
    if (0 == remainder) {
        if (m_resultCount > 0 && m_resultCount < m_resultCurrent) {
            m_pageCount = 1;
        } else {
            m_pageCount = m_resultCount / m_resultCurrent;
        }
    } else {
        m_pageCount = (m_resultCount / m_resultCurrent) + 1;
    }

    m_pageCurrent = 1;

    emit resultCountChanged();
    emit pageCountChanged();
    emit pageCurrentChanged();

    // 将初始数据选择出来
    this->select();
}

void AbstractPageModel::first()
{
    m_pageCurrent = 1;
    this->select();
    emit pageCurrentChanged();
}

void AbstractPageModel::previous()
{
    if (m_pageCurrent > 1) {
        m_pageCurrent--;
    }
    this->select();
    emit pageCurrentChanged();
}

void AbstractPageModel::next()
{
    if (m_pageCurrent < m_pageCount) {
        m_pageCurrent++;
    }
    this->select();
    emit pageCurrentChanged();
}

void AbstractPageModel::last()
{
    m_pageCurrent = m_pageCount;
    this->select();
    emit pageCurrentChanged();
}

void AbstractPageModel::setResultCurrent(int num)
{
    if (num > 0)
        m_resultCurrent = num;

    return;
}

void AbstractPageModel::select()
{
    startIndex = (m_pageCurrent -1) * m_resultCurrent;
    QSqlQuery query;
    sql = QString("select * from %1 %2 %3 limit %4,%5").arg(m_tableName).arg(m_whereSql).arg(m_orderSql)
            .arg(startIndex).arg(m_resultCurrent);

    if (!query.exec(sql)) {
        qDebug() << "[APageModel]-Error: select data, " << query.lastQuery() << query.lastError().text();
        return;
    }

    qDebug() << query.lastQuery();

    this->update(query);

    return;
}
