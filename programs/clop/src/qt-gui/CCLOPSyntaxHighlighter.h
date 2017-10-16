#ifndef CCLOPSYNTAXHIGHLIGHTER_H
#define CCLOPSYNTAXHIGHLIGHTER_H

#include <QSyntaxHighlighter>
#include <QTextEdit>

class CCLOPSyntaxHighlighter : public QSyntaxHighlighter
{
     Q_OBJECT

 public:
     CCLOPSyntaxHighlighter(QTextEdit *parent = 0);

 protected:
     void highlightBlock(const QString &text);

 private:
     struct HighlightingRule
     {
         QRegExp pattern;
         QTextCharFormat format;
     };
     QVector<HighlightingRule> highlightingRules;
 };

#endif // CCLOPSYNTAXHIGHLIGHTER_H
