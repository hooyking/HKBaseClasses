//
//  HKProgressHUD.m
//  HKBaseClasses
//
//  Created by hooyking on 2020/6/3.
//  Copyright © 2020 hooyking. All rights reserved.
//

#import "HKProgressHUD.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface HKProgressHUD ()

@property (nonatomic, strong) MBProgressHUD *progressHUD;

@end

@implementation HKProgressHUD

#pragma mark - class method

+ (instancetype)sharedHUD {
    static HKProgressHUD *hud = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!hud) {
            hud = [HKProgressHUD new];
        }
    });
    return hud;
}

+ (void)showProgressHUDWithMode:(ProgressHUDMode)mode
                       withText:(NSString *)text
                     afterDelay:(NSTimeInterval)delay
                     customView:(UIView *)customView
                   canTouchMask:(BOOL)canTouchMask
                         inView:(UIView *)view {
    
    [[HKProgressHUD sharedHUD] showProgressHUDWithMode:mode
                                              withText:text
                                       hiddenCancelBtn:YES
                                            afterDelay:delay
                                            customView:customView
                                          canTouchMask:canTouchMask
                                                inView:view];
}

+ (void)showProgressHUDWithMode:(ProgressHUDMode)mode
                       withText:(NSString *)text
                hiddenCancelBtn:(BOOL)hiddenCancelBtn
                     customView:(UIView *)customView
                      canTouchMask:(BOOL)canTouchMask
                         inView:(UIView *)view
                    cancelBlock:(void(^)(void))cancelBlock {
    
    [[HKProgressHUD sharedHUD] showProgressHUDWithMode:mode
                                              withText:text
                                       hiddenCancelBtn:hiddenCancelBtn
                                            customView:customView
                                             canTouchMask:canTouchMask
                                                inView:view
                                           cancelBlock:cancelBlock];
}

+ (void)hideProgressHUDAfterDelay:(NSTimeInterval)delay {
    [[HKProgressHUD sharedHUD] hideProgressHUDAfterDelay:delay];
}

+ (void)setProgress:(CGFloat)progress {
    [[HKProgressHUD sharedHUD] setProgress:progress];
}

+ (void)setContentColor:(UIColor *)contentColor {
    [[HKProgressHUD sharedHUD] setContentColor:contentColor];
}

#pragma mark - instance && private method

- (void)showProgressHUDWithMode:(ProgressHUDMode)mode
                       withText:(NSString *)text
                hiddenCancelBtn:(BOOL)hiddenCancelBtn
                     afterDelay:(NSTimeInterval)delay
                     customView:(UIView *)customView
                   canTouchMask:(BOOL)canTouchMask
                         inView:(UIView *)view {
    
    [self showProgressHUDWithMode:mode
                         withText:text
                  hiddenCancelBtn:hiddenCancelBtn
                       customView:customView
                     canTouchMask:canTouchMask
                           inView:view
                      cancelBlock:nil];
    
    [self.progressHUD hideAnimated:YES afterDelay:delay];
}

- (void)showProgressHUDWithMode:(ProgressHUDMode)mode
                       withText:(NSString *)text
                hiddenCancelBtn:(BOOL)hiddenCancelBtn
                     customView:(UIView *)customView
                   canTouchMask:(BOOL)canTouchMask
                         inView:(UIView *)view
                    cancelBlock:(nullable void(^)(void))cancelBlock {
    
    if (view == nil) {
        view = kAppWindow;
    }
    if (self.progressHUD) {
        [self hideProgressHUDAfterDelay:0];
    }
    self.progressHUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    self.progressHUD.userInteractionEnabled = !canTouchMask;
    self.progressHUD.detailsLabel.text = text;
    self.progressHUD.backgroundView.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.6];
    if (!hiddenCancelBtn) {
        kWeakSelf(self);
        [self.progressHUD.bezelView addProgressHUDCancelBtnWithClickedBlock:^{
            if (cancelBlock) {
                cancelBlock();
            }
            kStrongSelf(self);
            [self hideProgressHUDAfterDelay:0];
        }];
    }
    if (mode != ProgressHUDModeOnlyText && mode != ProgressHUDModeCustomView) {
        self.progressHUD.square = YES;
    }
    self.progressHUD.removeFromSuperViewOnHide = YES;
    
    switch (mode) {
        case ProgressHUDModeActivityIndicator:
            self.progressHUD.mode = MBProgressHUDModeIndeterminate;
            break;
            
        case ProgressHUDModeOnlyText:
            self.progressHUD.mode = MBProgressHUDModeText;
            break;
            
        case ProgressHUDModeProgress:
            self.progressHUD.mode = MBProgressHUDModeAnnularDeterminate;
            break;
            
        case ProgressHUDModeCustomView: {
            self.progressHUD.mode = MBProgressHUDModeCustomView;
            if (customView) {
                self.progressHUD.customView = customView;
            } else {
                @throw [NSException exceptionWithName:@"progressHUD提示框出错"
                                               reason:@"当HUD的mode为CustomView时，自定义view不能为空"
                                             userInfo:nil];
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)hideProgressHUDAfterDelay:(NSTimeInterval)delay {
    [self.progressHUD hideAnimated:YES afterDelay:delay];
    self.progressHUD = nil;
}

- (void)setProgress:(CGFloat)progress {
    self.progressHUD.progress = progress;
    if (progress >= 1 || progress < 0) {
        [self.progressHUD hideAnimated:YES];
    }
}

- (void)setContentColor:(UIColor *)contentColor {
    self.progressHUD.contentColor = contentColor;
}

@end
