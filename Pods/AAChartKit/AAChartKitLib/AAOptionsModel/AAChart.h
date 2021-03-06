//
//  AAChart.h
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



#import <Foundation/Foundation.h>
#import "AAGlobalMacro.h"
@class AAAnimation, AAScrollablePlotArea;

@interface AAChart : NSObject

AAPropStatementAndPropSetFuncStatement(copy,   AAChart, NSString    *, type) 
AAPropStatementAndPropSetFuncStatement(copy,   AAChart, NSString    *, backgroundColor) 
AAPropStatementAndPropSetFuncStatement(copy,   AAChart, NSString    *, plotBackgroundImage) //æå®ç»å¾åºèæ¯å¾ççå°åãå¦æéè¦è®¾ç½®æ´ä¸ªå¾è¡¨çèæ¯ï¼è¯·éè¿ CSS æ¥ç»å®¹å¨åç´ ï¼divï¼è®¾ç½®èæ¯å¾ãå¦å¤å¦æéè¦å¨å¯¼åºå¾çä¸­åå«è¿ä¸ªèæ¯å¾ï¼è¦æ±è¿ä¸ªå°åæ¯å¬ç½å¯ä»¥è®¿é®çå°åï¼åå«å¯ä»¥è®¿é®ä¸æ¯ç»å¯¹è·¯å¾ï¼ã
AAPropStatementAndPropSetFuncStatement(copy,   AAChart, NSString    *, pinchType) 
AAPropStatementAndPropSetFuncStatement(assign, AAChart, BOOL,          panning) 
//AAPropStatementAndPropSetFuncStatement(copy,   AAChart, NSString    *, panKey) 
AAPropStatementAndPropSetFuncStatement(assign, AAChart, BOOL,          polar) 
AAPropStatementAndPropSetFuncStatement(strong, AAChart, AAAnimation *, animation) //è®¾ç½®å¯ç¨å¨ç»çæ¶é´åç±»å
AAPropStatementAndPropSetFuncStatement(assign, AAChart, BOOL,          inverted)
AAPropStatementAndPropSetFuncStatement(strong, AAChart, NSArray     *, margin)//  å¾è¡¨å¤è¾¹ç¼åç»å¾åºåä¹é´çè¾¹è·ã æ°ç»ä¸­çæ°å­åå«è¡¨ç¤ºé¡¶é¨ï¼å³ä¾§ï¼åºé¨åå·¦ä¾§ ([ð,ð,ð,ð])ã ä¹å¯ä»¥ä½¿ç¨ marginTopï¼marginRightï¼marginBottom å marginLeft æ¥è®¾ç½®æä¸ä¸ªæ¹åçè¾¹è·ã
AAPropStatementAndPropSetFuncStatement(strong, AAChart, NSNumber    *, marginTop) //ð
AAPropStatementAndPropSetFuncStatement(strong, AAChart, NSNumber    *, marginRight) //ð
AAPropStatementAndPropSetFuncStatement(strong, AAChart, NSNumber    *, marginBottom) //ð
AAPropStatementAndPropSetFuncStatement(strong, AAChart, NSNumber    *, marginLeft) //ð
AAPropStatementAndPropSetFuncStatement(strong, AAChart, AAScrollablePlotArea *, scrollablePlotArea)

@end



@interface AAScrollablePlotArea : NSObject

AAPropStatementAndPropSetFuncStatement(strong, AAScrollablePlotArea, NSNumber *, minHeight)
AAPropStatementAndPropSetFuncStatement(strong, AAScrollablePlotArea, NSNumber *, minWidth)
AAPropStatementAndPropSetFuncStatement(strong, AAScrollablePlotArea, NSNumber *, opacity)
AAPropStatementAndPropSetFuncStatement(strong, AAScrollablePlotArea, NSNumber *, scrollPositionX)
AAPropStatementAndPropSetFuncStatement(strong, AAScrollablePlotArea, NSNumber *, scrollPositionY)

@end

