#ifndef MODIFIEDMARTELLDATATYPE_H
#define MODIFIEDMARTELLDATATYPE_H

#include "../MalamuteCore/InheritedClasses/DataType.h"

struct runData
{
public:
    runData(QList<double> percentWomen, QList<double> averageScore, int promotionCycles,
double impactFactor, double oddsRatio) :
        m_percentWomen(percentWomen),
        m_averageScore(averageScore),
        m_promotionCycles(promotionCycles),
        m_impactFactor(impactFactor),
        m_oddsRatio(oddsRatio)
    {

    }

    QList<double> percentWomen() const;
    QList<double> averageScore() const;
    int promotionCycles() const;
    double impactFactor() const;
    double oddsRatio() const;

private:
    QList<double> m_percentWomen;
    QList<double> m_averageScore;
    int m_promotionCycles;
    double m_impactFactor;
    double m_oddsRatio;
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
