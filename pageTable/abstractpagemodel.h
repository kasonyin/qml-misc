#ifndef ABSTRACTPAGEMODEL_H
#define ABSTRACTPAGEMODEL_H

#include <QAbstractListModel>

class QSqlQuery;
class AbstractPageModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(qint32 pageCurrent READ pageCurrent NOTIFY pageCurrentChanged)
    Q_PROPERTY(qint32 pageCount READ pageCount NOTIFY pageCountChanged)
    Q_PROPERTY(qint32 resultCount READ resultCount NOTIFY resultCountChanged)

    Q_PROPERTY(qint32 resultCurrent READ resultCurrent WRITE setResultCurrent NOTIFY resultCurrentChanged)
    Q_PROPERTY(QString tableName READ tableName WRITE setTableName CONSTANT)
public:
    explicit AbstractPageModel(QObject *parent = 0);

signals:
    void pageCurrentChanged();
    void pageCountChanged();
    void resultCurrentChanged();
    void resultCountChanged();

public slots:
    void initialize();
    void first();       // 首页
    void previous();    // 上一页
    void next();        // 下一页
    void last();        // 尾页

protected:
    /**
     * @brief update 更新 Model ，子类通过重写本方法来更新数据
     * @param query 一条从数据库查询到的数据
     */
    virtual void update(QSqlQuery &query) {}

    qint32 pageCurrent() { return m_pageCurrent; }          // 获取 当前是第几页
    qint32 pageCount() { return m_pageCount; }              // 获取 总页数
    qint32 resultCurrent() { return m_resultCurrent; }      // 获取 当前每页显示多少条数据
    qint32 resultCount() { return m_resultCount; }          // 获取 总数据条数

    QString tableName() { return m_tableName; }             // 获取 数据库表名
    void setTableName(QString name) { m_tableName = name;}  // 设置 数据库表名
    void setResultCurrent(int num);                         // 设置 每页显示的记录数

    void select();                                          // 选择 需要显示的数据

protected:
    qint32 m_pageCurrent = 0;       // 当前第几页
    qint32 m_pageCount = 0;         // 总页数
    qint32 m_resultCurrent = 10;    // 每页显示记录数
    qint32 m_resultCount = 0;       // 总记录数

    QString m_tableName;            // 数据表名
    qint32 startIndex = 0;          // 分页开始索引，每次翻页都变动

    QString sql;                    // sql 查询语句
};

#endif // ABSTRACTPAGEMODEL_H
