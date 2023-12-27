#include "Martell1996Plugin.h"

#include "../DataTypes/DistributionDataType.h"
#include "../DataTypes/NumberDataType.h"

#include "ModifiedMartellIdea.h"
#include "ModifiedMartellGroupIdea.h"

#include "NumberInputIdea.h"
#include "GaussianDistributionIdea.h"

#include "ModifiedMartellGroupDataType.h"
#include "ModifiedMartellDataType.h"
#include "ModifiedMartellDataDisplayIdea.h"

#include <QQmlEngine>

QString Martell1996Plugin::PluginName()
{
    return "Martell 1996";
}

QStringList Martell1996Plugin::authors()
{
    return QStringList("dBob");
}

QString Martell1996Plugin::PluginDescription()
{
    return "This plugin holds the ideas necessary to replicate the Martell et al 1996 Gender Bias"
           " simulation. Male-Female Differences, a Computer Simulation.";
}

void Martell1996Plugin::registerIdeas(std::shared_ptr<IdeaRegistry> ideaRegistry)
{
    ideaRegistry->registerIdea<NumberInputIdea>();
    ideaRegistry->registerIdea<GaussianDistributionIdea>();

    ideaRegistry->registerIdea<ModifiedMartellIdea>();
    ideaRegistry->registerIdea<ModifiedMartellGroupIdea>();
    ideaRegistry->registerIdea<ModifiedMartellDataDisplayIdea>();
}

void Martell1996Plugin::registerDataTypeAttributes(std::shared_ptr<DataTypeRegistry> dataTypeRegistry)
{
    dataTypeRegistry->registerDataTypeAttributes<NumberDataTypeAttributes>();
    dataTypeRegistry->registerDataTypeAttributes<DistributionDataTypeAttributes>();


    dataTypeRegistry->registerDataTypeAttributes<ModifiedMartellDataTypeAttributes>();
    dataTypeRegistry->registerDataTypeAttributes<ModifiedMartellGroupDataTypeAttributes>();
}

void Martell1996Plugin::registerToolbars(std::shared_ptr<ToolbarRegistry> toolbarRegistry)
{
    QStringList orderList;

    orderList << Magic<NumberInputAttributes>::cast().listName();
    orderList << Magic<GaussianDistributionAttributes>::cast().listName();

    orderList << Magic<ModifiedMartellAttributes>::cast().listName();
    orderList << Magic<ModifiedMartellGroupAttributes>::cast().listName();
    orderList << Magic<ModifiedMartellDataDisplayAttributes>::cast().listName();

    toolbarRegistry->registerToolbar(PluginName(), orderList);
}
