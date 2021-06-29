//
//  Macro.h
//  HKBaseClasses
//
//  Created by hooyking on 2020/4/26.
//  Copyright © 2020 hooyking. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

#define kScreenW                        [[UIScreen mainScreen] bounds].size.width
#define kScreenH                        [[UIScreen mainScreen] bounds].size.height
#define kAutoW(a)                       kScreenW/((UIInterfaceOrientationIsPortrait(kAppInterfaceOrientation)) ? 375.0 : 667.0)*a
#define kAutoH(b)                       kScreenH/((UIInterfaceOrientationIsPortrait(kAppInterfaceOrientation)) ? 667.0 : 375.0)*b
#define kTabBarH                        self.tabBarController.tabBar.frame.size.height
#define kNavConH                        self.navigationController.navigationBar.frame.size.height

#define kStatusBarH \
\
^(){ \
    CGFloat statusBarH = 0; \
    if (@available(iOS 13.0, *)) { \
        UIWindowScene *windowScene = (UIWindowScene *)[UIApplication sharedApplication].connectedScenes.allObjects.firstObject; \
        statusBarH = windowScene.statusBarManager.statusBarFrame.size.height; \
    } else { \
       statusBarH = [[UIApplication sharedApplication] statusBarFrame].size.height; \
    } \
    return statusBarH; \
}()

#define kAppWindow \
\
^(){ \
    UIWindow *window = [UIApplication sharedApplication].delegate.window; \
    if (!window) { \
        if (@available(iOS 13.0, *)) { \
            NSArray *array =[[[UIApplication sharedApplication] connectedScenes] allObjects]; \
            UIWindowScene *windowScene = (UIWindowScene*)array[0]; \
            UIWindow *mainWindow = [windowScene valueForKeyPath:@"delegate.window"]; \
            if(mainWindow) { \
                window = mainWindow; \
            } else { \
                window = [UIApplication sharedApplication].windows.lastObject; \
            } \
        } else { \
            window = [UIApplication sharedApplication].keyWindow; \
        } \
    } \
    return window; \
}()

//屏幕方向
#define kAppInterfaceOrientation \
\
^(){ \
    UIInterfaceOrientation interfaceOrientation; \
    if (@available(iOS 13.0, *)) { \
        UIWindowScene *windowScene = (UIWindowScene *)[UIApplication sharedApplication].connectedScenes.allObjects.firstObject; \
        interfaceOrientation = windowScene.interfaceOrientation; \
    } else { \
        interfaceOrientation = [UIApplication sharedApplication].statusBarOrientation; \
    } \
    return interfaceOrientation; \
}()

#define kSecurityH                      (kSafeAreaSeries ? (UIInterfaceOrientationIsPortrait(kAppInterfaceOrientation) ? 34.0 : 21.0) : 0)//底部安全高度

#define kSafeAreaSeries \
\
^(){ \
    if (@available(iOS 11.0, *)) { \
        CGFloat bottomSafeInset = kAppWindow.safeAreaInsets.bottom; \
        if (bottomSafeInset == 34.0 || bottomSafeInset == 21.0) { \
            return YES; \
        } \
    } \
    return NO; \
}()

#define kBelowIPhone5Series             ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(640,1136), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(640,960), [[UIScreen mainScreen] currentMode].size)) : NO)
#define kIPhone4Series                  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(640,960), [[UIScreen mainScreen] currentMode].size)) : NO)
#define kIPhone5Series                  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(640,1136), [[UIScreen mainScreen] currentMode].size)) : NO)
#define kIPhone6Series                  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750,1334), [[UIScreen mainScreen] currentMode].size)) : NO)

#define kRGBColorAlpha(a,b,c,d)         [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:d]
#define kRGBColor(a,b,c)                kRGBColorAlpha(a,b,c,1.0)
//16位颜色值，使用方式：UIColorFromHexString(0xffffff)
#define kUIColorFromHexString(hexValue)       [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue &0xFF00) >>8))/255.0 blue:((float)(hexValue &0xFF))/255.0 alpha:1.0]
#define kRandomColor                    kRGBColor(arc4random() % 256, arc4random() % 256, arc4random() % 256)  //随机色
//UIColor转UIImage
#define kCreateImageForColor(color) \
\
^(){ \
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f); \
    UIGraphicsBeginImageContext(rect.size); \
    CGContextRef context = UIGraphicsGetCurrentContext(); \
    CGContextSetFillColorWithColor(context, [color CGColor]); \
    CGContextFillRect(context, rect); \
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext(); \
    UIGraphicsEndImageContext(); \
    return theImage; \
}()

#define showAllAIHUD(text,view) [HKProgressHUD showProgressHUDWithMode:ProgressHUDModeActivityIndicator withText:text hiddenCancelBtn:YES customView:nil canTouchMask:NO inView:view cancelBlock:nil]
#define showHUDAutoHidden(text,view) [HKProgressHUD showProgressHUDWithMode:ProgressHUDModeOnlyText withText:text afterDelay:1.2 customView:nil canTouchMask:NO inView:view]
#define hiddenHUD(time) [HKProgressHUD hideProgressHUDAfterDelay:time]

//字号
#define kFontWeight(size,fontWeight) \
\
^(){ \
    CGFloat fontSize = size; \
    if (kBelowIPhone5Series) { \
        fontSize --; \
    } else { \
        fontSize = size; \
    } \
    return [UIFont systemFontOfSize:fontSize weight:fontWeight]; \
}()

#define kFontSize(size) \
\
^(){ \
    CGFloat fontSize = size; \
    if (kBelowIPhone5Series) { \
        fontSize --; \
    } else { \
        fontSize = size; \
    } \
    return fontSize; \
}()

#define kFontHeavy(size)                kFontWeight(size,UIFontWeightHeavy)
#define kFontBold(size)                 kFontWeight(size,UIFontWeightBold)
#define kFontRegular(size)              kFontWeight(size,UIFontWeightRegular)
#define kFontMedium(size)               kFontWeight(size,UIFontWeightMedium)
#define kFontThin(size)                 kFontWeight(size,UIFontWeightThin)

//拼接字符串
#define kNSStringFormat(format,...)     [NSString stringWithFormat:format,##__VA_ARGS__]
//检测是否含有目标子串
#define kHasString(string,subString)    ([string rangeOfString:subString].location != NSNotFound)

#ifdef DEBUG
#define HKLog(...)                      printf("[%s] %s [第%d行]: %s\n", __TIME__ ,__PRETTY_FUNCTION__ ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String])
#else
#define HKLog(...)
#endif

//强弱引用
#define kWeakSelf(type)                 __weak typeof(type) weak##type = type;
#define kStrongSelf(type)               __strong typeof(type) type = weak##type;

//当前系统版本
#define kCurrentSystemVersion           [[UIDevice currentDevice].systemVersion doubleValue]
//当前语言
#define kCurrentSystemLanguage          [[NSLocale preferredLanguages] objectAtIndex:0]
//app版本
#define kCurrentAppVersion              [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//app名称
#define kCurrentAppName                 [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"]

//沙盒目录路径
#define kHomePath                       NSHomeDirectory()
#define kTemPath                        NSTemporaryDirectory()
#define kCachePath                      NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject
#define kLibraryPath                    NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject
#define kDocumentPath                   NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject

//判断是否为iPhone
#define IS_IPHONE                       ([[[UIDevice currentDevice] model] isEqualToString:@"iPhone"])
//判断是否为iPad
#define IS_IPAD                         ([[[UIDevice currentDevice] model] isEqualToString:@"iPad"])
//判断是否为iPod
#define IS_IPOD                         ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])

//打印方法运行时间
#define METHOD_TIME_BEGIN               NSDate * startTime = [NSDate date];
#define METHOD_TIME_END                 HKLog(@"time interval: %f", -[startTime timeIntervalSinceNow]);

//监听通知
#define kNotifyAdd(noParamsFunc, notifyName)  [[NSNotificationCenter defaultCenter] \
addObserver:self \
selector:@selector(noParamsFunc) \
name:notifyName \
object:nil];
//发送通知
#define kNotifyPost(notifyName,obj)     [[NSNotificationCenter defaultCenter] postNotificationName:notifyName object:obj];
//移除通知
#define kNotifyRemove(notifyName)       [[NSNotificationCenter defaultCenter] removeObserver:self name:notifyName object:nil];

#endif /* Macro_h */
