//
//  AATooltip.m
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

#import "AATooltip.h"
#import "AAJSStringPurer.h"
@implementation AATooltip

- (instancetype)init {
    self = [super init];
    if (self) {
        _enabled = true;
        _animation = true;
        _shared = true;
        _crosshairs = true;
        _followTouchMove = true;
    }
    return self;
}

AAPropSetFuncImplementation(AATooltip, BOOL,       animation) //ๆฏๅฆๅฏ็จๅจ็ปๆฏๅฆๅฏ็จๅจ็ป(่ฎพ็ฝฎ animation == false,็ฆ็จ tooltip ๅจ็ป่ฝๅคๅจไธๅฎ็จๅบฆไธ่็็จๅบ็่ฎก็ฎ่ตๆบ,ๆ้ซ่ฟ่กๆ็)
AAPropSetFuncImplementation(AATooltip, NSString *, backgroundColor) //่ๆฏ่ฒ
AAPropSetFuncImplementation(AATooltip, NSString *, borderColor) //่พนๆก้ข่ฒ
AAPropSetFuncImplementation(AATooltip, NSNumber *, borderRadius) //่พนๆก็ๅ่งๅๅพ
AAPropSetFuncImplementation(AATooltip, NSNumber *, borderWidth) //่พนๆกๅฎฝๅบฆ
AAPropSetFuncImplementation(AATooltip, AAStyle *, style) //ไธบๆ็คบๆกๆทปๅ?CSSๆ?ทๅผใๆ็คบๆกๅๆ?ท่ฝๅค้่ฟ CSS ็ฑป .highcharts-tooltip ๆฅ่ฎพๅฎๆ?ทๅผใ ้ป่ฎคๆฏ๏ผ@{@"color":@"#ffffff",@"cursor":@"default",@"fontSize":@"12px",@"pointerEvents":@"none",@"whiteSpace":@"nowrap" }

AAPropSetFuncImplementation(AATooltip, BOOL,       enabled) 
AAPropSetFuncImplementation(AATooltip, BOOL,       useHTML) 
//AAPropSetFuncImplementation(AATooltip, NSString *, formatter)
AAPropSetFuncImplementation(AATooltip, NSString *, headerFormat)
AAPropSetFuncImplementation(AATooltip, NSString *, pointFormat) 
AAPropSetFuncImplementation(AATooltip, NSString *, footerFormat) 
AAPropSetFuncImplementation(AATooltip, NSNumber *, valueDecimals) //่ฎพ็ฝฎๅๅผ็ฒพ็กฎๅฐๅฐๆฐ็นๅๅ?ไฝ
AAPropSetFuncImplementation(AATooltip, BOOL,       shared) 
AAPropSetFuncImplementation(AATooltip, BOOL,       crosshairs) 
AAPropSetFuncImplementation(AATooltip, NSString *, valueSuffix) 
AAPropSetFuncImplementation(AATooltip, BOOL,       followTouchMove)

- (void)setFormatter:(NSString *)formatter {
    _formatter = [AAJSStringPurer pureJavaScriptFunctionStringWithString:formatter];
}

- (AATooltip * (^) (NSString * formatter))formatterSet {
    return ^(NSString * formatter) {
        _formatter = [AAJSStringPurer pureJavaScriptFunctionStringWithString:formatter];
        return self;
    };
}

@end
