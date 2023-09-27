#include "ModifiedMartellDataType.h"

QList<double> runData::percentWomen() const
{
    return m_percentWomen;
}

QList<double> runData::averageScore() const
{
    return m_averageScore;
}

int runData::promotionCycles() const
{
    return m_promotionCycles;
}

double runData::impactFactorTop() const
{
    return m_impactFactorTop;
}

double runData::impactFactorTop2() const
{
    return m_impactFactorTop2;
}

double runData::impactFactorBottom() const
{
    return m_impactFactorBottom;
}

double runData::oddsRatioTop() const
{
    return m_oddsRatioTop;
}

double runData::oddsRatioTop2() const
{
    return m_oddsRatioTop2;
}

double runData::oddsRatioBottom() const
{
    return m_oddsRatioBottom;
}

ModifiedMartellDataTypeAttributes::ModifiedMartellDataTypeAttributes()
{
    m_name = "Modified Martell simulation data output";
    m_color = "#6a6acc";
    m_abbreviation = "data";
    m_description = "Holds the data for export for Modified Martell.";
    m_authors << "dBob";
}

DataTypeAttributes ModifiedMartellDataType::getAttributes()
{
    return Magic<ModifiedMartellDataTypeAttributes>::cast();
}

QList<runData> ModifiedMartellDataType::getRunData() const
{
    return m_runData;
}

int ModifiedMartellDataType::getNumRuns() const
{
    return m_numRuns;
}

QList<int> ModifiedMartellDataType::getPositionsAtLevel() const
{
    return m_positionsAtLevel;
}

ModifiedMartellDataType::ModifiedMartellDataType()
{
    m_numRuns = 0;
    m_runData = QList<runData>();
}

ModifiedMartellDataType::ModifiedMartellDataType(int numRuns, QList<int> positionsAtLevel,
                                                 QList<runData> m_runData) :
    m_numRuns(numRuns),
    m_positionsAtLevel(positionsAtLevel),
    m_runData(m_runData)
{

}

