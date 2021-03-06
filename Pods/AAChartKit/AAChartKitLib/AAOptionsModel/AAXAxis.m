//
//  AAXAxis.m
//  AAChartKit
//
//  Created by An An on 17/1/5.
//  Copyright Â© 2017å¹´ An An. All rights reserved.
//*************** ...... SOURCE CODE ...... ***************
//***...................................................***
//*** https://github.com/AAChartModel/AAChartKit        ***
//*** https://github.com/AAChartModel/AAChartKit-Swift  ***
//***...................................................***
//*************** ...... SOURCE CODE ...... ***************

/*
 
 * -------------------------------------------------------------------------------
 *
 * ð ð ð ð  âââ   WARM TIPS!!!   âââ ð ð ð ð
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
#import "AAXAxis.h"

@implementation AAXAxis

- (instancetype)init {
    self = [super init];
    if (self) {
        _visible = true;
        _tickmarkPlacement = @"on";//æ¬åæ°åªå¯¹åç±»è½´ææã å½å¼ä¸º on æ¶å»åº¦çº¿å°å¨åç±»ä¸æ¹æ¾ç¤ºï¼å½å¼ä¸º between æ¶ï¼å»åº¦çº¿å°å¨ä¸¤ä¸ªåç±»ä¸­é´æ¾ç¤ºãå½ tickInterval ä¸º 1 æ¶ï¼highchartså®æ¹é»è®¤æ¯ between,æè¿éæå¨å°å¶æ¹ä¸º on
    }
    return self;
}

AAPropSetFuncImplementation(AAXAxis, NSArray<AAPlotBandsElement *>*, plotBands)
AAPropSetFuncImplementation(AAXAxis, NSArray<AAPlotLinesElement *>*, plotLines)
AAPropSetFuncImplementation(AAXAxis, NSArray  *, categories) 
AAPropSetFuncImplementation(AAXAxis, BOOL ,      reversed) 
AAPropSetFuncImplementation(AAXAxis, NSNumber *, lineWidth) //xè½´è½´çº¿å®½åº¦
AAPropSetFuncImplementation(AAXAxis, NSString *, lineColor) //xè½´è½´çº¿çº¿é¢è²
AAPropSetFuncImplementation(AAXAxis, NSNumber *,  linkedTo)
AAPropSetFuncImplementation(AAXAxis, NSNumber *, max)  //xè½´æå¤§å¼
AAPropSetFuncImplementation(AAXAxis, NSNumber *, min)  //xè½´æå°å¼ï¼è®¾ç½®ä¸º0å°±ä¸ä¼æè´æ°ï¼
AAPropSetFuncImplementation(AAXAxis, NSNumber *, gridLineWidth) //xè½´ç½æ ¼çº¿å®½åº¦
AAPropSetFuncImplementation(AAXAxis, NSString *, gridLineColor) //xè½´ç½æ ¼çº¿é¢è²
AAPropSetFuncImplementation(AAXAxis, NSString *, gridLineDashStyle) //xè½´ç½æ ¼çº¿æ ·å¼
AAPropSetFuncImplementation(AAXAxis, NSNumber *, offset) //xè½´åç´åç§»
AAPropSetFuncImplementation(AAXAxis, AALabels *, labels) 
AAPropSetFuncImplementation(AAXAxis, BOOL ,      visible)
AAPropSetFuncImplementation(AAXAxis, BOOL,       opposite) //æ¯å¦å°åæ è½´æ¾ç¤ºå¨å¯¹ç«é¢ï¼é»è®¤æåµä¸ x è½´æ¯å¨å¾è¡¨çä¸æ¹æ¾ç¤ºï¼y è½´æ¯å¨å·¦æ¹ï¼åæ è½´æ¾ç¤ºå¨å¯¹ç«é¢åï¼x è½´æ¯å¨ä¸æ¹æ¾ç¤ºï¼y è½´æ¯å¨å³æ¹æ¾ç¤ºï¼å³åæ è½´ä¼æ¾ç¤ºå¨å¯¹ç«é¢ï¼ãè¯¥éç½®ä¸è¬æ¯ç¨äºå¤åæ è½´åºåå±ç¤ºï¼å¦å¤å¨ Highstock ä¸­ï¼y è½´é»è®¤æ¯å¨å¯¹ç«é¢æ¾ç¤ºçã é»è®¤æ¯ï¼false.
AAPropSetFuncImplementation(AAXAxis, BOOL ,      startOnTick) //Whether to force the axis to start on a tick. Use this option with the minPadding option to control the axis start. é»è®¤æ¯ï¼false.
AAPropSetFuncImplementation(AAXAxis, BOOL ,      endOnTick) //æ¯å¦å¼ºå¶å°åæ è½´ç»æäºå»åº¦çº¿ï¼å¯ä»¥éè¿æ¬å±æ§å maxPadding æ¥æ§å¶åæ è½´çç»æä½ç½®ã é»è®¤æ¯ï¼false.
AAPropSetFuncImplementation(AAXAxis, AACrosshair*, crosshair)  //åæçº¿æ ·å¼è®¾ç½®
AAPropSetFuncImplementation(AAXAxis, NSString *, tickColor) //xè½´è½´çº¿ä¸æ¹å»åº¦çº¿é¢è²
AAPropSetFuncImplementation(AAXAxis, NSNumber *, tickInterval) //xè½´å»åº¦ç¹é´éæ°(è®¾ç½®æ¯éå ä¸ªç¹æ¾ç¤ºä¸ä¸ª Xè½´çåå®¹)
AAPropSetFuncImplementation(AAXAxis, NSString *, tickmarkPlacement) //æ¬åæ°åªå¯¹åç±»è½´ææã å½å¼ä¸º on æ¶å»åº¦çº¿å°å¨åç±»ä¸æ¹æ¾ç¤ºï¼å½å¼ä¸º between æ¶ï¼å»åº¦çº¿å°å¨ä¸¤ä¸ªåç±»ä¸­é´æ¾ç¤ºãå½ tickInterval ä¸º 1 æ¶ï¼é»è®¤æ¯ betweenï¼å¶ä»æåµé»è®¤æ¯ onã é»è®¤æ¯ï¼null.
AAPropSetFuncImplementation(AAXAxis, NSNumber *, tickWidth) //åæ è½´å»åº¦çº¿çå®½åº¦ï¼è®¾ç½®ä¸º 0 æ¶åä¸æ¾ç¤ºå»åº¦çº¿
AAPropSetFuncImplementation(AAXAxis, NSNumber *, tickLength)//åæ è½´å»åº¦çº¿çé¿åº¦ã é»è®¤æ¯ï¼10.
AAPropSetFuncImplementation(AAXAxis, NSString *, tickPosition) //å»åº¦çº¿ç¸å¯¹äºè½´çº¿çä½ç½®ï¼å¯ç¨çå¼æ inside å outsideï¼åå«è¡¨ç¤ºå¨è½´çº¿çåé¨åå¤é¨ã é»è®¤æ¯ï¼outside.
AAPropSetFuncImplementation(AAXAxis, NSNumber * , minRange)


@end
