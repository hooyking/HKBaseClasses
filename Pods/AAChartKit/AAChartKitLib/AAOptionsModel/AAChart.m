//
//  AAChart.m
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

#import "AAChart.h"

@implementation AAChart

AAPropSetFuncImplementation(AAChart, NSString    *, type) 
AAPropSetFuncImplementation(AAChart, NSString    *, backgroundColor) 
AAPropSetFuncImplementation(AAChart, NSString    *, plotBackgroundImage) //æå®ç»å¾åºèæ¯å¾ççå°åãå¦æéè¦è®¾ç½®æ´ä¸ªå¾è¡¨çèæ¯ï¼è¯·éè¿ CSS æ¥ç»å®¹å¨åç´ ï¼divï¼è®¾ç½®èæ¯å¾ãå¦å¤å¦æéè¦å¨å¯¼åºå¾çä¸­åå«è¿ä¸ªèæ¯å¾ï¼è¦æ±è¿ä¸ªå°åæ¯å¬ç½å¯ä»¥è®¿é®çå°åï¼åå«å¯ä»¥è®¿é®ä¸æ¯ç»å¯¹è·¯å¾ï¼ã
AAPropSetFuncImplementation(AAChart, NSString    *, pinchType) 
AAPropSetFuncImplementation(AAChart, BOOL ,         panning) 
//AAPropSetFuncImplementation(AAChart, NSString    *, panKey) 
AAPropSetFuncImplementation(AAChart, BOOL ,         polar) 
AAPropSetFuncImplementation(AAChart, AAAnimation *, animation) 
AAPropSetFuncImplementation(AAChart, BOOL ,         inverted)
AAPropSetFuncImplementation(AAChart, NSArray     *, margin)//  å¾è¡¨å¤è¾¹ç¼åç»å¾åºåä¹é´çè¾¹è·ã æ°ç»ä¸­çæ°å­åå«è¡¨ç¤ºé¡¶é¨ï¼å³ä¾§ï¼åºé¨åå·¦ä¾§ã ä¹å¯ä»¥ä½¿ç¨ marginTopï¼marginRightï¼marginBottom å marginLeft æ¥è®¾ç½®æä¸ä¸ªæ¹åçè¾¹è·ã
AAPropSetFuncImplementation(AAChart, NSNumber    *, marginTop)
AAPropSetFuncImplementation(AAChart, NSNumber    *, marginRight)
AAPropSetFuncImplementation(AAChart, NSNumber    *, marginBottom)
AAPropSetFuncImplementation(AAChart, NSNumber    *, marginLeft) 
AAPropSetFuncImplementation(AAChart, AAScrollablePlotArea *, scrollablePlotArea)


@end



@implementation AAScrollablePlotArea

AAPropSetFuncImplementation(AAScrollablePlotArea, NSNumber *, minHeight)
AAPropSetFuncImplementation(AAScrollablePlotArea, NSNumber *, minWidth)
AAPropSetFuncImplementation(AAScrollablePlotArea, NSNumber *, opacity)
AAPropSetFuncImplementation(AAScrollablePlotArea, NSNumber *, scrollPositionX)
AAPropSetFuncImplementation(AAScrollablePlotArea, NSNumber *, scrollPositionY)

@end
