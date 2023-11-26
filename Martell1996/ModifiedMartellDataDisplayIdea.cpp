#include "ModifiedMartellDataDisplayIdea.h"
#include <QRandomGenerator>

ModifiedMartellDataDisplayAttributes::ModifiedMartellDataDisplayAttributes()
{
    m_listName = "Modified Martell Data Display";
    m_displayName = "Modified Martell Data Display";
    m_authors << "dBob";
    m_description = "Handles data exporting for Martell et al 1996";
    m_iconPath = "qrc:/Icons/ModifiedMartellDataDisplay.png";

    m_dataTypesIn << Magic<ModifiedMartellDataTypeAttributes>::cast().id();

    m_embeddedQMLPath = ":/QML/ModifiedMartellDataDisplay.qml";
}

const IdeaAttributes ModifiedMartellDataDisplayIdea::attributes()
{
    return Magic<ModifiedMartellDataDisplayAttributes>::cast();
}

ModifiedMartellDataDisplayIdea::ModifiedMartellDataDisplayIdea()
{
    m_model = new ModifiedMartellDataDisplaySummaryTableModel(this);
}

void ModifiedMartellDataDisplayIdea::finishSetupQmlContext()
{
    setContextProperty("dataModel", m_model);
}

void ModifiedMartellDataDisplayIdea::onNewDataIn(std::shared_ptr<DataType> dataType, PlugNumber)
{
    m_input = std::dynamic_pointer_cast<ModifiedMartellDataType>(dataType);

    validate();
}

void ModifiedMartellDataDisplayIdea::validate()
{
    auto n = m_input.lock();

    m_model->clearData();

    if(n)
    {
        if(n->getNumRuns() == 0)
        {
            setStatus(IdeaStatus::StandBy, "Awaiting Data", "This box is currently not recieving any data. Run"
                                                            " the Martell et al 1996 simultaion in bulk mode to"
                                                            " send data to this box.");
        }
        else
        {
            setStatus(IdeaStatus::Working, "Holding data", "Ready to export/display data");
            prepareData();
        }
    }
    else
    {
        setDefaultStatus();
    }
}

void ModifiedMartellDataDisplayIdea::prepareData()
{
    auto n = m_input.lock();

    //Get the data from the dataType;
    QList<runData> runsData = n->getRunData();
    QList<int> positionsAtlevel = n->getPositionsAtLevel();

    //Get the number of levels
    int numLevels = runsData[0].averageScore().length();

    //Setup initial containers to contain 0's
    QList<double> averageScore;
    QList<double> averagePercentWomen;
    QList<double> averageScoreEx2;
    QList<double> averagePercentWomenEx2;
    QList<double> averageScoreErr;
    QList<double> averagePercentWomenErr;

    averageScore.reserve(numLevels);
    averagePercentWomen.reserve(numLevels);
    averageScoreEx2.reserve(numLevels);
    averagePercentWomenEx2.reserve(numLevels);
    averageScoreErr.reserve(numLevels);
    averagePercentWomenErr.reserve(numLevels);

    for(int i = 0; i < numLevels; i++)
    {
        averageScore.append(0);
        averagePercentWomen.append(0);
        averageScoreEx2.append(0);
        averagePercentWomenEx2.append(0);
        averageScoreErr.append(0);
        averagePercentWomenErr.append(0);
    }

    //Calculate the average for each level.
    for(int i = 0; i < runsData.length(); i++)
    {
        for(int j = 0; j < numLevels; j++)
        {
            averageScore[j] += runsData[i].averageScore()[j];
            averageScoreEx2[j] += runsData[i].averageScore()[j] * runsData[i].averageScore()[j];
            averagePercentWomen[j] += runsData[i].percentWomen()[j];
            averagePercentWomenEx2[j] += runsData[i].percentWomen()[j] * runsData[i].percentWomen()[j];
        }
    }

    for(int i = 0; i < numLevels; i++)
    {
        averageScore[i] /= runsData.length();
        averagePercentWomen[i] /= runsData.length();
        averageScoreEx2[i] /= runsData.length();
        averagePercentWomenEx2[i] /= runsData.length();

        averageScoreErr[i] = qSqrt(averageScoreEx2[i] - averageScore[i]*averageScore[i]);
        averagePercentWomenErr[i] = qSqrt(averagePercentWomenEx2[i] - averagePercentWomen[i]*averagePercentWomen[i]);
    }

    for(int i = 0; i < numLevels; i++)
    {
        m_model->addLevel(numLevels - i, averageScore[i], averageScoreErr[i],
                          positionsAtlevel.at(i), averagePercentWomen[i],
                          averagePercentWomenErr[i]);
    }

    //Promotion Cycles
    double averagePromotionCycles = 0.0;
    for(int i = 0; i < runsData.length(); i++)
    {
        averagePromotionCycles += runsData[i].promotionCycles();
    }
    averagePromotionCycles /= runsData.length();
    emit displayAveragePromotionCycles(averagePromotionCycles);

    //Impact factor.
    double averageImpactFactor = 0.0;
    for(int i = 0; i < runsData.length(); i++)
    {
        averageImpactFactor += runsData.at(i).impactFactor();
    }
    averageImpactFactor /= runsData.length();

    emit displayAverageImpactFactor(averageImpactFactor);

    //TB odds Ratio.
    int numInvalid = 0;
    double averagetbOddsRatio = 0.0;
    for(int i = 0; i < runsData.length(); i++)
    {
        if(runsData.at(i).validtbOddsRatio())
            averagetbOddsRatio += runsData.at(i).tboddsRatio();
        else
            numInvalid++;
    }
    averagetbOddsRatio /= (1.0 * (runsData.length() - numInvalid));

    //Confidence interval TB odds ratio.
    int bootstrapCount = 2000;
    std::vector<double> tbBootstraps;
    tbBootstraps.reserve(bootstrapCount);
    for(int i = 0; i < bootstrapCount; i++)
    {
        double sum = 0.0;
        for(int j = 0; j < runsData.length(); j++)
        {
            int select = QRandomGenerator::global()->bounded(runsData.length());
            sum += runsData.at(select).tboddsRatio();
        }
        sum /= runsData.length();
        tbBootstraps.push_back(sum);
    }
    std::sort(tbBootstraps.begin(), tbBootstraps.end());
    int lowCI = std::floor(0.025*bootstrapCount);
    int highCI = std::ceil(0.975*bootstrapCount);
    emit displayAveragetbOddsRatio(averagetbOddsRatio, numInvalid,
                                   tbBootstraps[lowCI], tbBootstraps[highCI]);
    \
        //WM odds ratio.
        numInvalid = 0;
    double averagewmOddsRatio = 0.0;
    for(int i = 0; i < runsData.length(); i++)
    {
        if(runsData.at(i).validwmOddsRatio())
        {
            averagewmOddsRatio += runsData.at(i).wmoddsRatio();
        }
        else
            numInvalid++;
    }
    averagewmOddsRatio /= (1.0 * (runsData.length() - numInvalid));

    //Confidence interval WM odds ratio.
    std::vector<double> wmBootstraps;
    wmBootstraps.reserve(bootstrapCount);
    for(int i = 0; i < bootstrapCount; i++)
    {
        double sum = 0.0;
        for(int j = 0; j < runsData.length(); j++)
        {
            int select = QRandomGenerator::global()->bounded(runsData.length());
            sum += runsData.at(select).wmoddsRatio();
        }
        sum /= runsData.length();
        wmBootstraps.push_back(sum);
    }
    std::sort(wmBootstraps.begin(), wmBootstraps.end());
    emit displayAveragewmOddsRatio(averagewmOddsRatio, numInvalid,
                                   wmBootstraps[lowCI], wmBootstraps[highCI]);

    //Number of runs used to calculate the data
    emit displayNumberRuns(runsData.length());
}
