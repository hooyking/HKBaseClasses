//
//  AAYAxis.m
//  AAChartKit
//
//  Created by An An on 17/1/5.
//  Copyright ยฉ 2017ๅนด An An. All rights reserved.
//*************** ...... SOURCE CODE ...... ***************
//***...................................................***
//*** https://github.com/AAChartModel/AAChartKit        ***
//*** https://github.com/AAChartModel/AAChartKit-Swift  ***
//***...................................................***
//*************** ...... SOURCE CODE ...... ***************

/*
 
 * -------------------------------------------------------------------------------
 *
 * ๐ ๐ ๐ ๐  โโโ   WARM TIPS!!!   โโโ ๐ ๐ ๐ ๐
 *
 * Please contact me on GitHub,if there are any problems encountered in use.
 * GitHub Issues : https://github.com/AAChartModel/AAChartKit/issues
 * -------------------------------------------------------------------------------
 * And if you want to contribute for this project, please contact me as well
 * GitHub        : https://github.com/AAChartModel
 * StackOverflow : https://stackoverflow.com/users/7842508/codeforu
 * JianShu       : https://www.jianshu.com/u/f1e6753d4254
 * SegmentFault  : https://segmentfault.com/u/huanghunbieguan
 *
 * -------------------------------------------------------------------------------
 
 */

#import "AAYAxis.h"

@implementation AAYAxis

- (instancetype)init {
    self = [super init];
    if (self) {
        _visible = true;
    }
    return self;
}

AAPropSetFuncImplementation(AAYAxis, AAAxisTitle  *, title)
AAPropSetFuncImplementation(AAYAxis, NSArray<AAPlotBandsElement *>*, plotBands)
AAPropSetFuncImplementation(AAYAxis, NSArray<AAPlotLinesElement *>*, plotLines)
AAPropSetFuncImplementation(AAYAxis, NSArray  *, categories)
AAPropSetFuncImplementation(AAYAxis, BOOL,       reversed) 
AAPropSetFuncImplementation(AAYAxis, NSNumber *, gridLineWidth) 
AAPropSetFuncImplementation(AAYAxis, NSString *, gridLineColor)
AAPropSetFuncImplementation(AAYAxis, NSString *, gridLineDashStyle) //็ฝๆ ผ็บฟ็บฟๆกๆ ทๅผ๏ผๆๆๅฏ็จ็็บฟๆกๆ ทๅผๅ่๏ผHighcharts็บฟๆกๆ ทๅผ
AAPropSetFuncImplementation(AAYAxis, NSString *, alternateGridColor) 
AAPropSetFuncImplementation(AAYAxis, AAYAxisGridLineInterpolation, gridLineInterpolation) 
AAPropSetFuncImplementation(AAYAxis, AALabels *, labels) 
AAPropSetFuncImplementation(AAYAxis, NSNumber *, lineWidth) //y่ฝด็บฟๅฎฝๅบฆ
AAPropSetFuncImplementation(AAYAxis, NSString *, lineColor) // y ่ฝด็บฟ้ข่ฒ
AAPropSetFuncImplementation(AAYAxis, NSNumber *, offset) // y ่ฝด็บฟๆฐดๅนณๅ็งป

AAPropSetFuncImplementation(AAYAxis, BOOL,       allowDecimals)  //y่ฝดๆฏๅฆๅ่ฎธๆพ็คบๅฐๆฐ
AAPropSetFuncImplementation(AAYAxis, NSNumber *, max)  //y่ฝดๆๅคงๅผ
AAPropSetFuncImplementation(AAYAxis, NSNumber *, min)  //y่ฝดๆๅฐๅผ๏ผ่ฎพ็ฝฎไธบ0ๅฐฑไธไผๆ่ดๆฐ๏ผ
//AAPropSetFuncImplementation(AAYAxis, NSNumber *, minPadding)  //Padding of the min value relative to the length of the axis. A padding of 0.05 will make a 100px axis 5px longer. This is useful when you don't want the lowest data value to appear on the edge of the plot area. ้ป่ฎคๆฏ๏ผ0.05.
AAPropSetFuncImplementation(AAYAxis, NSNumber *, minRange)
AAPropSetFuncImplementation(AAYAxis, BOOL,       visible)  //y่ฝดๆฏๅฆๅ่ฎธๆพ็คบ
AAPropSetFuncImplementation(AAYAxis, BOOL,       opposite) //ๆฏๅฆๅฐๅๆ ่ฝดๆพ็คบๅจๅฏน็ซ้ข๏ผ้ป่ฎคๆๅตไธ x ่ฝดๆฏๅจๅพ่กจ็ไธๆนๆพ็คบ๏ผy ่ฝดๆฏๅจๅทฆๆน๏ผๅๆ ่ฝดๆพ็คบๅจๅฏน็ซ้ขๅ๏ผx ่ฝดๆฏๅจไธๆนๆพ็คบ๏ผy ่ฝดๆฏๅจๅณๆนๆพ็คบ๏ผๅณๅๆ ่ฝดไผๆพ็คบๅจๅฏน็ซ้ข๏ผใ่ฏฅ้็ฝฎไธ่ฌๆฏ็จไบๅคๅๆ ่ฝดๅบๅๅฑ็คบ๏ผๅฆๅคๅจ Highstock ไธญ๏ผy ่ฝด้ป่ฎคๆฏๅจๅฏน็ซ้ขๆพ็คบ็ใ ้ป่ฎคๆฏ๏ผfalse.
AAPropSetFuncImplementation(AAYAxis, BOOL ,      startOnTick) //Whether to force the axis to start on a tick. Use this option with the minPadding option to control the axis start. ้ป่ฎคๆฏ๏ผfalse.
AAPropSetFuncImplementation(AAYAxis, BOOL ,      endOnTick) //ๆฏๅฆๅผบๅถๅฐๅๆ ่ฝด็ปๆไบๅปๅบฆ็บฟ๏ผๅฏไปฅ้่ฟๆฌๅฑๆงๅ maxPadding ๆฅๆงๅถๅๆ ่ฝด็็ปๆไฝ็ฝฎใ ้ป่ฎคๆฏ๏ผfalse.
AAPropSetFuncImplementation(AAYAxis, AACrosshair*, crosshair)  //ๅๆ็บฟๆ ทๅผ่ฎพ็ฝฎ
AAPropSetFuncImplementation(AAYAxis, AALabels *, stackLabels)
AAPropSetFuncImplementation(AAYAxis, NSNumber *, tickAmount)//ๅปๅบฆๆปๆฐ
AAPropSetFuncImplementation(AAYAxis, NSString *, tickColor) // ๅปๅบฆ็บฟ้ข่ฒ
AAPropSetFuncImplementation(AAYAxis, NSNumber *, tickInterval)
AAPropSetFuncImplementation(AAYAxis, NSNumber *, tickWidth) //ๅๆ ่ฝดๅปๅบฆ็บฟ็ๅฎฝๅบฆ๏ผ่ฎพ็ฝฎไธบ 0 ๆถๅไธๆพ็คบๅปๅบฆ็บฟ
AAPropSetFuncImplementation(AAYAxis, NSNumber *, tickLength)//ๅๆ ่ฝดๅปๅบฆ็บฟ็้ฟๅบฆใ ้ป่ฎคๆฏ๏ผ10.
AAPropSetFuncImplementation(AAYAxis, NSString *, tickPosition) //ๅปๅบฆ็บฟ็ธๅฏนไบ่ฝด็บฟ็ไฝ็ฝฎ๏ผๅฏ็จ็ๅผๆ inside ๅ outside๏ผๅๅซ่กจ็คบๅจ่ฝด็บฟ็ๅ้จๅๅค้จใ ้ป่ฎคๆฏ๏ผoutside.
AAPropSetFuncImplementation(AAYAxis, NSArray  *, tickPositions) //่ชๅฎไนY่ฝดๅๆ ๏ผๅฆ๏ผ[@(0), @(25), @(50), @(75) , (100)]๏ผ

@end

@implementation AAAxisTitle

AAPropSetFuncImplementation(AAAxisTitle, NSString *, align)
AAPropSetFuncImplementation(AAAxisTitle, NSString *, margin)
AAPropSetFuncImplementation(AAAxisTitle, NSNumber *, offset)
AAPropSetFuncImplementation(AAAxisTitle, NSNumber *, rotation)
AAPropSetFuncImplementation(AAAxisTitle, AAStyle  *, style)
AAPropSetFuncImplementation(AAAxisTitle, NSString *, text)
AAPropSetFuncImplementation(AAAxisTitle, NSNumber *, x) //ๆ ้ข็ธๅฏนไบๆฐดๅนณๅฏน้ฝ็ๅ็งป้๏ผๅๅผ่ๅดไธบ๏ผๅพ่กจๅทฆ่พน่ทๅฐๅพ่กจๅณ่พน่ท๏ผๅฏไปฅๆฏ่ดๅผ๏ผๅไฝpxใ ้ป่ฎคๆฏ๏ผ0.
AAPropSetFuncImplementation(AAAxisTitle, NSNumber *, y) //ๆ ้ข็ธๅฏนไบๅ็ดๅฏน้ฝ็ๅ็งป้๏ผๅๅผ่ๅด๏ผๅพ่กจ็ไธ่พน่ท๏ผchart.spacingTop ๏ผๅฐๅพ่กจ็ไธ่พน่ท๏ผchart.spacingBottom๏ผ๏ผๅฏไปฅๆฏ่ดๅผ๏ผๅไฝๆฏpxใ้ป่ฎคๅผๅๅญไฝๅคงๅฐๆๅณใ

@end
