#ifndef SURFACEANDSTYLESETUP_H
#define SURFACEANDSTYLESETUP_H

#include <QSurfaceFormat>
#include <QQuickStyle>

void setupSurfaceAndStyle()
{
    QSurfaceFormat format;
    format.setSamples(16);
    QSurfaceFormat::setDefaultFormat(format);
    QQuickStyle::setStyle("Material");
}

#endif // SURFACEANDSTYLESETUP_H
