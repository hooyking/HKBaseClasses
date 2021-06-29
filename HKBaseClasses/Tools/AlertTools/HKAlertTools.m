//
//  HKAlertTools.m
//  HKBaseClasses
//
//  Created by hooyking on 2020/5/27.
//  Copyright © 2020 hooyking. All rights reserved.
//

#import "HKAlertTools.h"

@implementation HKAlertTools {
    WMZDialog *myAlertView;
}

+ (instancetype)shareManager {
    static HKAlertTools *alertTools = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        alertTools = [[HKAlertTools alloc] init];
    });
    return alertTools;
}

+ (void)showAlertViewWithTitle:(NSString *)title
                       message:(NSString *)message
               certainBtnTitle:(NSString *)certainBtnTitle
                cancelBtnTitle:(NSString *)cancelBtnTitle
                   finishBlock:(void(^)(NSInteger buttonIndex))finishBlock {
    
    if (certainBtnTitle.length == 0 && cancelBtnTitle.length == 0) {
        @throw [NSException exceptionWithName:@"显示AlertView时Crash" reason:@"不能两个按钮都不设置title" userInfo:nil];
    }
    WMZDialog *alertView = Dialog()
    .wShowAnimationSet(AninatonCurverOn)
    .wHideAnimationSet(AninatonCurverOff)
    .wAnimationDurtionSet(0.2)
    .wShadowCanTapSet(NO)
    .wTitleSet(title)
    .wTitleColorSet([UIColor blackColor])
    .wMessageSet(message)
    .wMessageColorSet(kUIColorFromHexString(0x2a2a2a));
    if ((certainBtnTitle.length == 0 && cancelBtnTitle.length > 0) || (certainBtnTitle.length > 0 && cancelBtnTitle.length == 0)) {
        alertView.wOKTitleSet(certainBtnTitle.length > 0 ? certainBtnTitle : cancelBtnTitle);
        alertView.wOKColorSet(kUIColorFromHexString(0x156cfd));
        alertView.wEventOKFinishSet(^(id anyID, id otherData) {
            if (finishBlock) {
                finishBlock(0);
            }
        });
    }
    if (certainBtnTitle.length > 0 && cancelBtnTitle.length > 0) {
        alertView.wOKTitleSet(certainBtnTitle);
        alertView.wOKColorSet(kUIColorFromHexString(0x2378fb));
        alertView.wEventOKFinishSet(^(id anyID, id otherData) {
            if (finishBlock) {
                finishBlock(1);
            }
        });
        alertView.wCancelTitleSet(cancelBtnTitle);
        alertView.wCancelColorSet(kUIColorFromHexString(0x156cfd));
        alertView.wEventCancelFinishSet(^(id anyID, id otherData) {
            if (finishBlock) {
                finishBlock(0);
            }
        });
    }
    
    alertView.wStart();
}

+ (void)showSheetViewWithTitle:(NSString *)title
                   buttonArray:(NSArray <NSString *> *)buttonArray
                   finishBlock:(void(^)(NSInteger buttonIndex))finishBlock {

    Dialog().wTypeSet(DialogTypeSheet)
    .wTitleSet(title)
    .wDataSet(buttonArray)
    .wEventFinishSet(^(id anyID,NSIndexPath *path, DialogType type) {
        if (finishBlock) {
            finishBlock(path.row+1);
        }
    })
    .wEventCancelFinishSet(^(id anyID, id otherData) {
        if (finishBlock) {
            finishBlock(0);
        }
    })
    .wShowAnimationSet(AninatonShowTop)
    .wHideAnimationSet(AninatonHideTop)
    .wAnimationDurtionSet(0.2)
    .wStart();
}

+ (void)showPopViewWithTitleImageArray:(NSArray *)array
                                sender:(UIView *)sender
                          clickedBlock:(void(^)(NSInteger buttonIndex))clickedBlock {
    
    Dialog().wTypeSet(DialogTypePop)
    .wPercentAngleSet(0.8)
    .wShowAnimationSet(AninatonZoomIn)
    .wTapViewSet(sender)
    .wEventFinishSet(^(id anyID, NSIndexPath *path, DialogType type) {
        if (clickedBlock) {
            clickedBlock(path.row);
        }
    })
    .wDataSet(array)
    .wStart();
}

+ (void)showAdvertisementViewWithImageName:(NSString *)imageName clickedBlock:(void(^)(void))clickedBlock {
    Dialog()
    .wTypeSet(DialogTypeAdvertisement)
    .wEventFinishSet(^(id anyID, NSIndexPath *path, DialogType type) {
        if (clickedBlock) {
            clickedBlock();
        }
    })
    .wShowAnimationSet(AninatonZoomIn)
    .wImageSizeSet(CGSizeMake(kAutoW(250), kAutoH(300)))
    .wImageNameSet(imageName)
    .wStart();
}

+ (void)showShareViewWithTitleImageArray:(NSArray *)array clickedBlock:(void(^)(NSInteger section, NSInteger row))clickedBlock {
    Dialog()
    .wTypeSet(DialogTypeShare)
    .wTitleSet(@"分享")
    .wEventMenuClickSet(^(id anyID, NSInteger section, NSInteger row) {
        if (clickedBlock) {
            clickedBlock(section,row);
        }
    })
    .wDataSet(array)
    .wRowCountSet(2)
//    .wHeightSet(50)//可根据实际情况设置弹出视图的高
    .wColumnCountSet(4)
    .wStart();
}

+ (void)showDownloadUploadViewWithTitle:(NSString *)title
                              imageName:(NSString *)imageName
                               progress:(CGFloat)progress
                            cancelBlock:(void(^)(void))cancelBlock {
    
    WMZDialog *alert = Dialog()
    .wTypeSet(DialogTypeDown)
    .wShowAnimationSet(AninatonCurverOn)
    .wHideAnimationSet(AninatonCurverOff)
    .wImageNameSet(imageName)
    .wTitleSet(title)
    .wShadowCanTapSet(NO)
    .wEventCloseSet(^(id anyID, id otherData) {
        if (cancelBlock) {
            cancelBlock();
        }
    })
    .wDataSet(@(0.0))
    .wStart();
    if (progress == 1) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [alert closeView];
        });
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [alert updateAlertTypeDownProgress:progress];
        });
    }
}

+ (void)showEditViewWithTitle:(NSString *)title
                      message:(NSString *)message
                  placeholder:(NSString *)placeholder
                      maxLine:(NSInteger)maxLine
                     maxWords:(NSInteger)maxWords
                 keyboardType:(UIKeyboardType)keyboardType
                  finishBlock:(void (^)(NSString *words))finishBlock {
    
    Dialog().wTypeSet(DialogTypeWrite)
    .wEventOKFinishSet(^(id anyID, id otherData) {
        if (finishBlock) {
            finishBlock(anyID);
        }
    })
    .wTitleSet(title)
    .wMessageSet(message)
    .wWirteTextMaxNumSet(maxWords <= -1 ? -1 : maxWords)
    //提示文本
    .wPlaceholderSet(placeholder)
    //编辑框最大行数 大于行数则滚动
    .wWirteTextMaxLineSet(maxLine <= 1 ? 1 : maxLine)
    //键盘类型
    .wWirteKeyBoardTypeSet(keyboardType)
    .wStart();
}

+ (void)showAreaViewWithTitle:(NSString *)title
                 locationType:(NSInteger)locationType
                  finishBlock:(void (^)(NSArray *resultArray, NSString *resultString))finishBlock {
    
    Dialog()
    .wEventOKFinishSet(^(id anyID, id otherData) {
        NSMutableArray *resultArray = [NSMutableArray array];
        for (WMZTree *tree in anyID) {
            [resultArray addObject:tree.name];
        }
        if (finishBlock) {
            finishBlock([resultArray copy],otherData);
        }
    })
    .wTitleSet(title)
    //分隔符
    .wSeparatorSet(@",")
    .wChainTypeSet(ChainPickView)
    .wLocationTypeSet(locationType)
    .wTypeSet(DialogTypeLocation)
    .wStart();
}

+ (void)showDatePickerViewWithTitle:(NSString *)title
                        defaultDate:(NSDate *)defaultDate
                     dateFormatType:(HKDateFormatType)dateFormatType
                   dateJoinCharType:(HKDateChatJoinType)dateJoinCharType
                            maxDate:(NSDate *)maxDate
                            minDate:(NSDate *)minDate
                        finishBlock:(void(^)(NSArray *resultArray,NSString *resultString))finishBlock {
    
    NSDictionary *mdic = @{@(0):@"yyyy年",
                           @(1):@"yyyy年MM月",
                           @(2):@"yyyy年MM月dd日",
                           @(3):@"yyyy年MM月dd日 HH时",
                           @(4):@"yyyy年MM月dd日 HH时mm分",
                           @(5):@"yyyy年MM月dd日 HH时mm分ss秒"};
    NSString *dateFormat = nil;
    dateFormat = [mdic objectForKey:@(dateFormatType)];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:+20];
    NSDate *defaultMaxDate = [gregorian dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];
    NSDateComponents *dateComponents1 = [[NSDateComponents alloc] init];
    [dateComponents1 setYear:-20];
    NSDate *defaultMinDate = [gregorian dateByAddingComponents:dateComponents1 toDate:[NSDate date] options:0];
    Dialog()
    .wEventOKFinishSet(^(id anyID, id otherData) {
        NSString *joinCharString = @"";
        switch (dateJoinCharType) {
            case HKDateCharJoinTypeBar:
                joinCharString = @"-";
                break;
                
            case HKDateCharJoinTypePoint:
                joinCharString = @".";
            break;
                
            case HKDateCharJoinTypeSlash:
                joinCharString = @"/";
            break;
                
            default:
                break;
        }
        NSString *resultJoinCharString = @"";
        for (NSString *temString in anyID) {
            resultJoinCharString = [resultJoinCharString stringByAppendingFormat:@"%@%@",temString,joinCharString];
        }
        resultJoinCharString = [resultJoinCharString substringToIndex:resultJoinCharString.length-1];
        if (finishBlock) {
            finishBlock(anyID,resultJoinCharString);
        }
    })
    .wShowAnimationSet(AninatonShowTop)
    .wHideAnimationSet(AninatonHideTop)
    .wAnimationDurtionSet(0.2)
    .wTitleSet(title)
    .wDefaultDateSet(defaultDate ? defaultDate : [NSDate date])
    .wDateTimeTypeSet(dateFormat)
    .wMinDateSet(minDate ? minDate : defaultMinDate)
    .wMaxDateSet(maxDate ? maxDate : defaultMaxDate)
    .wPickRepeatSet(NO)
    .wTypeSet(DialogTypeDatePicker)
    .wMessageColorSet([UIColor blackColor])
    .wMessageFontSet(16)
    .wStart();
}

+ (void)showSelectViewWithTitle:(NSString *)title
                        message:(NSString *)message
                    buttonArray:(NSArray <NSString *> *)buttonArray
                  isMultiSelect:(BOOL)isMultiSelect
                    finishBlock:(void(^)(NSArray *indexArray))finishBlock {
    
    BOOL showChecked = NO;
    if (isMultiSelect) {
        showChecked = YES;
    }
    Dialog().wTypeSet(DialogTypeSelect)
    .wEventFinishSet(^(id anyID, NSIndexPath *path, DialogType type) {
        if (finishBlock) {
            finishBlock(@[@(path.row)]);
        }
    })
    .wEventOKFinishSet(^(id anyID, id otherData) {
        NSMutableArray *resultMArray = [NSMutableArray array];
        for (NSIndexPath *indexPath in otherData) {
            [resultMArray addObject:@(indexPath.row)];
        }
        if (finishBlock) {
            finishBlock([resultMArray copy]);
        }
    })
    .wShowAnimationSet(AninatonZoomIn)
    .wHideAnimationSet(AninatonZoomOut)
    .wTitleSet(title)
    .wMessageSet(message)
    .wMultipleSelectionSet(isMultiSelect)
    .wSelectShowCheckedSet(showChecked)
    .wDataSet(buttonArray)
    .wStart();
}

+ (void)showCalanderWithTitle:(NSString *)title
                  isShowLunar:(BOOL)isShowLunar
          isDirectionVertical:(BOOL)isDirectionVertical
             isMultipleSelect:(BOOL)isMultipleSelect
             circlePointArray:(NSArray <NSDate *>*)circlePointArray
                  finishBlock:(void(^)(NSArray <CalanderModel *>* calanderArray))finishBlock {
    
    Dialog()
    .wTypeSet(DialogTypeCalander)
    .wTitleSet(title)
    //隐藏日历上的按钮
    .wHideCalanderBtnSet(NO)
    //打开农历
    .wOpenChineseDateSet(isShowLunar)
    //滚动方向
    .wDirectionVerticalSet(isDirectionVertical)
    //多选
    .wMultipleSelectionSet(isMultipleSelect)
    //显示在底部
    .wMainToBottomSet(YES)
    .wShowAnimationSet(AninatonShowTop)
    .wHideAnimationSet(AninatonHideTop)
    .wAnimationDurtionSet(0.2)
    
    //默认带圆点
    .wDateShowCircleSet(circlePointArray)
//    //显示自定义颜色圆点
//    .wDateShowCircleSet(@[
//    @{@"date":[NSDate dateWithTimeIntervalSinceNow:-3*24*60*60],@"color":[UIColor redColor]},
//    @{@"date":[NSDate date]},
//    @{@"date":[NSDate dateWithTimeIntervalSinceNow:24*60*60],@"color":[UIColor greenColor]},
//    @{@"date":[NSDate dateWithTimeIntervalSinceNow:3*24*60*60],@"color":[UIColor cyanColor]},
//    ])
    //自定义点击方法
//    .wCalanderCellClickSet(^(NSIndexPath *indexPath, UICollectionView *collection, id model) {
//        HKLog(@"%@",model);
//        CalanderModel *calanderModel = model;
//        if (!calanderModel.wSelected) {
//
//        } else {
//
//        }
//    })
    //确定的点击方法
    .wEventOKFinishSet(^(id anyID, id otherData) {
        if (!otherData) {
            return ;
        }
        NSMutableArray *resultMArray = [NSMutableArray array];
        if (isMultipleSelect) {
            resultMArray = [(NSMutableArray *)otherData mutableCopy];
        } else {
            [resultMArray addObject:otherData];
        }
        if (finishBlock) {
            finishBlock([resultMArray copy]);
        }
    })
    //标题颜色
    .wMessageColorSet(kUIColorFromHexString(0x0096ff))
    //改变主题色
    .wOKColorSet(kUIColorFromHexString(0x0096ff))
    .wStart();
}

#pragma mark - 自定义的WMZDialog

- (void)showUpdateVersionViewWithTitle:(NSString *)title
                               message:(NSString *)message
                             imageName:(NSString *)imageName
                              btnTitle:(NSString *)btnTitle
                           finishBlock:(void(^)(void))finishBlock {
    
    myAlertView = Dialog()
    .wTypeSet(DialogTypeMyView)
    .wWidthSet(kAutoW(kScreenW*0.8))
    .wShowAnimationSet(AninatonZoomIn)
    .wHideAnimationSet(AninatonZoomOut)
    //关闭事件 此时要置为不然会内存泄漏
    .wEventCloseSet(^(id anyID, id otherData) {
        myAlertView = nil;
    })
    .wMyDiaLogViewSet(^UIView *(UIView *mainView) {
        UIImageView *image = [UIImageView new];
        image.image = [UIImage imageNamed:imageName];
        image.frame = CGRectMake((mainView.frame.size.width-70)/2, 15, 70, 70);
        [mainView addSubview:image];
        
        UILabel *la = [UILabel new];
        la.font = kFontRegular(17);
        la.text = title;
        la.textAlignment = NSTextAlignmentCenter;
        la.frame = CGRectMake(20, CGRectGetMaxY(image.frame)+15, mainView.frame.size.width-40, 40);
        [mainView addSubview:la];
        
        UITextView *text = [UITextView new];
        text.editable = NO;
        text.textColor = kUIColorFromHexString(0x333333);
        text.font = kFontRegular(14);
        text.text = message;
        text.textAlignment = NSTextAlignmentCenter;
        text.frame = CGRectMake(20, CGRectGetMaxY(la.frame)+15, mainView.frame.size.width-40, 100);
        [mainView addSubview:text];
        
        UIButton *know = [UIButton buttonWithType:UIButtonTypeCustom];
        [mainView addSubview:know];
        know.titleLabel.font = kFontRegular(16);
        know.frame = CGRectMake(20, CGRectGetMaxY(text.frame)+15, mainView.frame.size.width-40, 44);
        [know setTitle:btnTitle forState:UIControlStateNormal];
        know.backgroundColor = kUIColorFromHexString(0x108ee9);
        [know addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            [myAlertView closeView];
            if (finishBlock) {
                finishBlock();
            }
        }];
        
        mainView.layer.masksToBounds = YES;
        mainView.layer.cornerRadius = 10;
        return know;
    })
    .wStart();
}

- (void)showAgreementViewWithTitle:(NSString *)title
                    agreementTitle:(NSString *)agreementTitle
                        agreeBlock:(void (^)(BOOL agree))agreeBlock
                 agreementTapBlock:(void (^)(void))agreementTapBlock {
    
    myAlertView = Dialog()
    .wTypeSet(DialogTypeMyView)
    //关闭事件 此时要置为不然会内存泄漏
    .wEventCloseSet(^(id anyID, id otherData) {
        myAlertView = nil;
    })
    .wShowAnimationSet(AninatonZoomIn)
    .wHideAnimationSet(AninatonZoomOut)
    .wWidthSet(kAutoW(kScreenW*0.8))
    .wMyDiaLogViewSet(^UIView *(UIView *mainView) {

        UILabel *la = [UILabel new];
        la.font = kFontRegular(17);
        la.textAlignment = NSTextAlignmentCenter;
        la.text = title;
        la.numberOfLines = 0;
        la.frame = CGRectMake(0, 15, mainView.frame.size.width, 35);
        [mainView addSubview:la];
        
        UITextView *textView = [UITextView new];
        textView.editable = NO;
        textView.frame = CGRectMake(0, CGRectGetMaxY(la.frame)+15, mainView.frame.size.width, 100);
        textView.textColor = kUIColorFromHexString(0x666666);
        textView.font = kFontRegular(14);
        textView.text = kNSStringFormat(@"  本协议是用户（下称“用户”或“您”）与%@的协议，%@将按照本协议约定之内容为您提供服务。“%@”是指%@和/或其相关服务可能存在的运营关联单位。若您不同意本协议中所述任何条款或其后对协议条款的修改，请您不要使用%@提供的相关服务。您的使用行为将视作对本协议全部条款的完全接受。请您仔细阅读本协议的全部条款与条件，尤其是协议中黑色加粗的条款。\n  如您为未成年人的，请在法定监护人的陪同下阅读和判断是否同意本协议，特别注意未成年人条款。未成年人行使和履行本协议项下的权利和义务视为已获得监护人的认可",kCurrentAppName,kCurrentAppName,kCurrentAppName,kCurrentAppName,kCurrentAppName);
        [mainView addSubview:textView];
        
        YYLabel *text = [YYLabel new];
        text.font = kFontRegular(15);
        text.textAlignment = NSTextAlignmentCenter;
        NSString *str = kNSStringFormat(@"您可通过阅读完整版%@了解详尽的条款内容",agreementTitle);
        NSMutableAttributedString *mStr = [[NSMutableAttributedString alloc] initWithString:str];
        mStr.yy_font = kFontRegular(15);
        mStr.yy_color = kUIColorFromHexString(0x999999);
        [mStr yy_setTextHighlightRange:[str rangeOfString:agreementTitle] color:kUIColorFromHexString(0x5297E1) backgroundColor:[UIColor blueColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            if (agreementTapBlock) {
                agreementTapBlock();
            }
        }];
        text.attributedText = mStr;
        text.numberOfLines = 2;
        text.frame = CGRectMake(0, CGRectGetMaxY(textView.frame)+10, mainView.frame.size.width, 60);
        [mainView addSubview:text];
        
        mainView.layer.masksToBounds = YES;
        mainView.layer.cornerRadius = 10;
        return text;
    })
    //添加底部
    .wAddBottomViewSet(YES)
    .wEventOKFinishSet(^(id anyID, id otherData) {
        if (agreeBlock) {
            agreeBlock(YES);
        }
    })
    .wEventCancelFinishSet(^(id anyID, id otherData) {
        if (agreeBlock) {
            agreeBlock(NO);
        }
    })
    .wOKTitleSet(@"同意")
    .wCancelTitleSet(@"不同意")
    .wOKColorSet(kUIColorFromHexString(0xff709a))
    .wCancelColorSet(kUIColorFromHexString(0x666666))
    .wStart();
}



@end
