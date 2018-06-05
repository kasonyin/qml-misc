#ifndef PAGEMODEL_H
#define PAGEMODEL_H

#include <QAbstractListModel>

class PageModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(qint32 pageCurrent READ pageCurrent NOTIFY pageCurrentChanged)
    Q_PROPERTY(qint32 pageCount READ pageCount NOTIFY pageCountChanged)
    Q_PROPERTY(qint32 resultCurrent READ resultCurrent NOTIFY resultCurrentChanged)
    Q_PROPERTY(qint32 resultCount READ resultCount NOTIFY resultCountChanged)
    Q_PROPERTY(QString tableName READ tableName WRITE setTableName CONSTANT)

public:
    explicit PageModel(QObject *parent = nullptr);

    QVariant data(const QModelIndex &index, int role) const;
    int rowCount(const QModelIndex &parent) const;
    QHash<int, QByteArray>roleNames() const;

signals:
    void pageCurrentChanged();
    void pageCountChanged();
    void resultCurrentChanged();
    void resultCountChanged();

public slots:
    void first();
    void previous();
    void next();
    void last();

private:
    qint32 pageCurrent() { return m_pageCurrent; }
    qint32 pageCount() { return m_pageCount; }
    qint32 resultCurrent() { return m_resultCurrent; }
    qint32 resultCount() { return m_resultCount; }

    QString tableName() { return m_tableName; }
    void setTableName(QString name) { m_tableName = name;}

private:
    qint32 m_pageCurrent = 0;
    qint32 m_pageCount = 0;
    qint32 m_resultCurrent = 0;
    qint32 m_resultCount = 0;

    QString m_tableName;
};

#endif // PAGEMODEL_H
