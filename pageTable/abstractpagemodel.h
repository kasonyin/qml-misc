#ifndef ABSTRACTPAGEMODEL_H
#define ABSTRACTPAGEMODEL_H

#include <QAbstractListModel>


/**
 * @note AbstractPageModel 是一个用于实现分页、翻页表格的一个抽象基类，主要
 *       封装了 首页，上一页，下一页，尾页 四个方法。
 *       使用时，需实现 QAbstractListModel 的 data() ， roleNames() ，rowCount()
 *       三个函数，以及本类的 update() 虚函数，update() 函数是为了方便子类更新 Model
 *       数据使用。
 *
 *       需要子类实现的几个函数：
 *
 *       QVariant data(const QModelIndex &index, int role) const;
 *       int rowCount(const QModelIndex &parent) const;
 *       QHash<int, QByteArray>roleNames() const;
 *       void update(QSqlQuery &query);
 *
 ******************************************************************/

class QSqlQuery;
class AbstractPageModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(qint32 pageCurrent READ pageCurrent NOTIFY pageCurrentChanged)
    Q_PROPERTY(qint32 pageCount READ pageCount NOTIFY pageCountChanged)
    Q_PROPERTY(qint32 resultCount READ resultCount NOTIFY resultCountChanged)

    Q_PROPERTY(qint32 resultCurrent READ resultCurrent WRITE setResultCurrent NOTIFY resultCurrentChanged)
    Q_PROPERTY(QString tableName READ tableName WRITE setTableName CONSTANT)
    Q_PROPERTY(QString orderSql READ orderSql WRITE setOrderSql CONSTANT)
    Q_PROPERTY(QString whereSql READ whereSql WRITE setWhereSql CONSTANT)
public:
    explicit AbstractPageModel(QObject *parent = 0);

signals:
    void pageCurrentChanged();      // 当前页改变的信号
    void pageCountChanged();        // 总页数改变的信号
    void resultCurrentChanged();    // 总记录数改变的信号
    void resultCountChanged();      // 每页记录数改变的信号

public slots:
    /**
     * @brief initialize 初始化，因目前的设计为每页显示的记录数可改变，
     *                    因此，需要手动调用一下本方法，否则无法正常使用
     */
    void initialize();

    void first();       // 首页
    void previous();    // 上一页
    void next();        // 下一页
    void last();        // 尾页

protected:
    /**
     * @brief update 更新 Model ，子类通过重写本方法来更新数据
     * @param query 从数据库查询到的数据
     */
    virtual void update(QSqlQuery &query) {}

    qint32 pageCurrent() { return m_pageCurrent; }          // 获取 当前是第几页
    qint32 pageCount() { return m_pageCount; }              // 获取 总页数
    qint32 resultCount() { return m_resultCount; }          // 获取 总数据条数

    qint32 resultCurrent() { return m_resultCurrent; }      // 获取 当前每页显示多少条数据
    void setResultCurrent(int num);                         // 设置 每页显示的记录数

    QString tableName() { return m_tableName; }             // 获取 数据库表名
    void setTableName(QString name) { m_tableName = name;}  // 设置 数据库表名

    QString orderSql() { return m_orderSql; }                       // 获取 排序方式
    void setOrderSql(QString strOrder) { m_orderSql = strOrder; }   // 设置 排序方式

    QString whereSql() { return m_whereSql; }                       // 获取 查询条件
    void setWhereSql(QString strWhere) { m_whereSql = strWhere; }   // 设置 查询条件

    void select();                                                  // 选择 需要显示的数据

protected:
    qint32 m_pageCurrent = 0;       // 当前第几页
    qint32 m_pageCount = 0;         // 总页数
    qint32 m_resultCurrent = 10;    // 每页显示记录数
    qint32 m_resultCount = 0;       // 总记录数

    QString m_tableName = "";       // 数据表名
    QString m_orderSql = "";     // 排序方式
    QString m_whereSql = "";        // 查找条件
    qint32 startIndex = 0;          // 分页开始索引，每次翻页都变动

    QString sql;                    // sql 查询语句
};

#endif // ABSTRACTPAGEMODEL_H
