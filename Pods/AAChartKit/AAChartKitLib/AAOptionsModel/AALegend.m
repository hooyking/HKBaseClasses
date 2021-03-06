//
//  AALegend.m
//  AAChartKit
//
//  Created by An An on 17/1/6.
//  Copyright Β© 2017εΉ΄ An An. All rights reserved.
//
//*************** ...... SOURCE CODE ...... ***************
//***...................................................***
//***    https://github.com/AAChartModel/AAChartKit     ***
//***...................................................***
//*************** ...... SOURCE CODE ...... ***************
//

/*
 
 * -------------------------------------------------------------------------------
 *
 * π π π π  βββ   WARM TIPS!!!   βββ π π π π
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

#import "AALegend.h"

@implementation AALegend

AAPropSetFuncImplementation(AALegend, AAChartLayoutType,        layout)
AAPropSetFuncImplementation(AALegend, AAChartAlignType,         align)
AAPropSetFuncImplementation(AALegend, AAChartVerticalAlignType, verticalAlign)
AAPropSetFuncImplementation(AALegend, BOOL,          enabled) 
AAPropSetFuncImplementation(AALegend, NSString    *, borderColor) 
AAPropSetFuncImplementation(AALegend, NSNumber    *, borderWidth) 
AAPropSetFuncImplementation(AALegend, NSNumber    *, itemMarginTop)
AAPropSetFuncImplementation(AALegend, NSNumber    *, itemMarginBottom)
AAPropSetFuncImplementation(AALegend, AAItemStyle *, itemStyle)
AAPropSetFuncImplementation(AALegend, NSNumber    *, symbolHeight)//ζ εΏι«εΊ¦
AAPropSetFuncImplementation(AALegend, NSNumber    *, symbolPadding)//ζ εΏεθ·
AAPropSetFuncImplementation(AALegend, NSNumber    *, symbolRadius)//εΎζ εθ§
AAPropSetFuncImplementation(AALegend, NSNumber    *, symbolWidth)//εΎζ ε?½εΊ¦
AAPropSetFuncImplementation(AALegend, NSNumber    *, x) 
AAPropSetFuncImplementation(AALegend, NSNumber    *, y)
AAPropSetFuncImplementation(AALegend, BOOL,          floating)

@end



@implementation AAItemStyle

AAPropSetFuncImplementation(AAItemStyle, NSString *, color)
AAPropSetFuncImplementation(AAItemStyle, NSString *, cursor)
AAPropSetFuncImplementation(AAItemStyle, NSString *, pointer)
AAPropSetFuncImplementation(AAItemStyle, NSString *, fontSize)
AAPropSetFuncImplementation(AAItemStyle, NSString *, fontWeight)

@end
