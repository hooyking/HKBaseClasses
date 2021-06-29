//
//  HKAlertTools.h
//  HKBaseClasses
//
//  Created by hooyking on 2020/5/27.
//  Copyright © 2020 hooyking. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,HKDateFormatType) {
    HKDateFormatTypeYear = 0,
    HKDateFormatTypeYM = 1,
    HKDateFormatTypeYMD = 2,
    HKDateFormatTypeYMDH = 3,
    HKDateFormatTypeYMDHM = 4,
    HKDateFormatTypeYMDHMS = 5
};

typedef NS_ENUM(NSInteger,HKDateChatJoinType) {
    HKDateCharJoinTypeBar = 0,//横杠
    HKDateCharJoinTypePoint = 1,//点
    HKDateCharJoinTypeSlash = 2//斜杠
};

@interface HKAlertTools : NSObject

/**
 单例
 
 @return HKAlertTools对象
 */
+ (instancetype)shareManager;

/**
 仿系统UIAlertController的Alert模式
 
 @param title 视图title
 @param message 视图注释
 @param certainBtnTitle 确定按钮title
 @param cancelBtnTitle 取消按钮title
 @param finishBlock 点击按钮的block（buttonIndex指示点击了哪个按钮）
 */
+ (void)showAlertViewWithTitle:(NSString * _Nullable)title
                       message:(NSString * _Nullable)message
               certainBtnTitle:(NSString * _Nullable)certainBtnTitle
                cancelBtnTitle:(NSString * _Nullable)cancelBtnTitle
                   finishBlock:(nullable void(^)(NSInteger buttonIndex))finishBlock;

/**
 仿系统UIAlertController的Sheet模式
 
 @param title 视图title
 @param buttonArray 按钮文字数组
 @param finishBlock 点击按钮的block（buttonIndex指示点击了哪个按钮）
 */
+ (void)showSheetViewWithTitle:(NSString * _Nullable)title
                   buttonArray:(NSArray <NSString *> *)buttonArray
                   finishBlock:(void(^)(NSInteger buttonIndex))finishBlock;

/**
 popView，像微信首页➕点击弹出选项
 
 @param array 格式如 @[@{@"name":@"微信",@"image":@"wallet"},
                      @{@"name":@"支付宝",@"image":@"aaa"}]
 @param sender 点击的view
 @param clickedBlock 一个带有点击了第几项的block
 */
+ (void)showPopViewWithTitleImageArray:(NSArray *)array
                                sender:(UIView *)sender
                          clickedBlock:(void(^)(NSInteger buttonIndex))clickedBlock;

/**
 窗口弹出广告
 
 @param imageName 图片名
 @param clickedBlock 图片点击block
 */
+ (void)showAdvertisementViewWithImageName:(NSString *)imageName clickedBlock:(void(^)(void))clickedBlock;

/**
 底部弹出分享窗口
 
 @param array 格式如 @[@{@"name":@"微信",@"image":@"wallet"},
                      @{@"name":@"支付宝",@"image":@"aaa"}]
 @param clickedBlock 一个带有点击了第几行第几列的block
*/
+ (void)showShareViewWithTitleImageArray:(NSArray *)array
                            clickedBlock:(void(^)(NSInteger section, NSInteger row))clickedBlock;

/**
 下载上传窗口
 
 @param title 窗口上的title
 @param imageName 窗口上的图片
 @param progress 当前进度（值0 ～ 1）
 @param cancelBlock 取消block
 */
+ (void)showDownloadUploadViewWithTitle:(NSString *)title
                              imageName:(NSString *)imageName
                               progress:(CGFloat)progress
                            cancelBlock:(void(^)(void))cancelBlock;

/**
 弹出编辑窗口
 
 @param title 窗口上的title
 @param message 窗口上注释文字
 @param placeholder 占位文字
 @param maxLine 最大行数
 @param maxWords 最大字数 （-1 ～ +∞）
 @param keyboardType 键盘类型
 @param finishBlock 确定block
 */
+ (void)showEditViewWithTitle:(NSString * _Nullable)title
                      message:(NSString * _Nullable)message
                  placeholder:(NSString * _Nullable)placeholder
                      maxLine:(NSInteger)maxLine
                     maxWords:(NSInteger)maxWords
                 keyboardType:(UIKeyboardType)keyboardType
                  finishBlock:(void(^)(NSString * _Nullable words))finishBlock;

/**
 选择地区（仿pickerView），无复选
 
 @param title 视图title
 @param locationType (1/2/3 分别代表 省/省市/省市县)
 @param finishBlock 确定block(含选择之后的对应的数组与字符串结果)
 */
+ (void)showAreaViewWithTitle:(NSString * _Nullable)title
                 locationType:(NSInteger)locationType
                  finishBlock:(void (^)(NSArray *resultArray, NSString *resultString))finishBlock;

/**
 时间pickerView
 
 @param title 视图title
 @param defaultDate 默认选中date
 @param dateFormatType 时间格式
 @param dateJoinCharType 时间之间的连接字符
 @param maxDate 最大时间
 @param minDate 最小时间
 @param finishBlock 点击确定的block(resultArray 时间拆开之后的数组，resultString 时间组装好后的字符串)
 */
+ (void)showDatePickerViewWithTitle:(NSString * _Nullable)title
                        defaultDate:(NSDate * _Nullable)defaultDate
                     dateFormatType:(HKDateFormatType)dateFormatType
                   dateJoinCharType:(HKDateChatJoinType)dateJoinCharType
                            maxDate:(NSDate * _Nullable)maxDate
                            minDate:(NSDate * _Nullable)minDate
                        finishBlock:(void(^)(NSArray *resultArray,NSString *resultString))finishBlock;

/**
 单多选view（window中间显示）
 
 @param title 视图title
 @param message 视图注释文字
 @param buttonArray 按钮文字数组
 @param isMultiSelect 是否多选
 @param finishBlock 点击确定的block(indexArray 按钮位置数组)
 */
+ (void)showSelectViewWithTitle:(NSString * _Nullable)title
                        message:(NSString * _Nullable)message
                    buttonArray:(NSArray <NSString *> *)buttonArray
                  isMultiSelect:(BOOL)isMultiSelect
                    finishBlock:(void(^)(NSArray *indexArray))finishBlock;

/**
 日历view
 
 @param title 视图title
 @param isShowLunar YES 显示农历，NO 不显示
 @param isDirectionVertical YES 垂直滚动，NO 水平滚动
 @param isMultipleSelect YES 多选，NO 单选
 @param circlePointArray 决定点在哪儿的时间数组
 @param finishBlock 点击确定之后的block（装有选中的日期）
 */
+ (void)showCalanderWithTitle:(NSString * _Nullable)title
                  isShowLunar:(BOOL)isShowLunar
          isDirectionVertical:(BOOL)isDirectionVertical
             isMultipleSelect:(BOOL)isMultipleSelect
             circlePointArray:(NSArray <NSDate *>* _Nullable)circlePointArray
                  finishBlock:(void(^)(NSArray <CalanderModel *>* calanderArray))finishBlock;

#pragma mark - 自定义的WMZDialog
/**
 更新View
 
 @param title 视图title
 @param message 视图文字详情
 @param imageName 视图抬头图片
 @param btnTitle 按钮title
 @param finishBlock 按钮block
 */
- (void)showUpdateVersionViewWithTitle:(NSString * _Nullable)title
                               message:(NSString *)message
                             imageName:(NSString *)imageName
                              btnTitle:(NSString *)btnTitle
                           finishBlock:(void(^)(void))finishBlock;

/**
 用户协议弹窗
 
 @param title 弹窗title
 @param agreementTitle 协议名称
 @param agreeBlock 点击同意与不同意的block
 @param agreementTapBlock 有色协议本身点击的block
 */
- (void)showAgreementViewWithTitle:(NSString *)title
                    agreementTitle:(NSString *)agreementTitle
                        agreeBlock:(void (^)(BOOL agree))agreeBlock
                 agreementTapBlock:(void (^)(void))agreementTapBlock;

@end

NS_ASSUME_NONNULL_END
