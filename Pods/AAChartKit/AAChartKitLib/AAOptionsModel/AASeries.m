//
//  AASeries.m
//  AAChartKit
//
//  Created by An An on 17/1/19.
//  Copyright ยฉ 2017ๅนด An An. All rights reserved.
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

#import "AASeries.h"

@implementation AASeries

AAPropSetFuncImplementation(AASeries, NSNumber     *, borderRadius) 
AAPropSetFuncImplementation(AASeries, AAMarker     *, marker) 
AAPropSetFuncImplementation(AASeries, NSString     *, stacking) 
AAPropSetFuncImplementation(AASeries, AAAnimation  *, animation) 
AAPropSetFuncImplementation(AASeries, NSArray      *, keys) 
//AAPropSetFuncImplementation(AASeries, BOOL , colorByPoint) //่ฎพ็ฝฎไธบ true ๅๆฏ็ปๆฏไธช็นๅ้้ข่ฒใ
AAPropSetFuncImplementation(AASeries, BOOL ,          connectNulls) 
AAPropSetFuncImplementation(AASeries, NSDictionary *, events)
AAPropSetFuncImplementation(AASeries, AAShadow *, shadow)
AAPropSetFuncImplementation(AASeries, AADataLabels *, dataLabels)

@end
