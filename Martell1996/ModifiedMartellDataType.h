#ifndef MODIFIEDMARTELLDATATYPE_H
#define MODIFIEDMARTELLDATATYPE_H

#include "../MalamuteCore/InheritedClasses/DataType.h"

struct runData
{
public:
    runData(QList<double> percentWomen, QList<double> averageScore, int promotionCycles,
            double impactFactorTop, double impactFactorTop2, double impactFactorBottom,
            double oddsRatioTop, double oddsRatioTop2, double oddsRatioBottom) :
        m_percentWomen(percentWomen),
        m_averageScore(averageScore),
        m_promotionCycles(promotionCycles),

        m_impactFactorTop(impactFactorTop),
        m_impactFactorTop2(impactFactorTop2),
        m_impactFactorBottom(impactFactorBottom),
        m_oddsRatioTop(oddsRatioTop),
        m_oddsRatioTop2(oddsRatioTop2),
        m_oddsRatioBottom(oddsRatioBottom)
    {

    }

    QList<double> percentWomen() const;
    QList<double> averageScore() const;
    int promotionCycles() const;

    double impactFactorTop() const;
    double impactFactorTop2() const;
    double impactFactorBottom() const;

    double oddsRatioTop() const;
    double oddsRatioTop2() const;
    double oddsRatioBottom() const;

private:
    QList<double> m_percentWomen;
    QList<double> m_averageScore;
    int m_promotionCycles;

    double m_impactFactorTop;
    double m_impactFactorTop2;
    double m_impactFactorBottom;

    double m_oddsRatioTop;
    double m_oddsRatioTop2;
    double m_oddsRatioBottom;
};

struct ModifiedMartellDataTypeAttributes : public DataTypeAttributes
{
    ModifiedMartellDataTypeAttributes();
};

class ModifiedMartellDataType : public DataType
{
public:
    explicit ModifiedMartellDataType();
    explicit ModifiedMartellDataType(int numRuns, QList<int> positionsAtLevel, QList<runData> m_runData);

    DataTypeAttributes getAttributes() override;

    QList<runData> getRunData() const;
    int getNumRuns() const;
    QList<int> getPositionsAtLevel() const;

private:
    int m_numRuns;
    QList<int> m_positionsAtLevel;
    QList<runData> m_runData;
};

#endif // MODIFIEDMARTELLDATATYPE_H
