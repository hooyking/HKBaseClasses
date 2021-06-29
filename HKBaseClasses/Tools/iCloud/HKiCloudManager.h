//
//  HKiCloudManager.h
//  renqin
//
//  Created by hooyking on 2019/10/22.
//  Copyright © 2019 hooyking. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HKiCloudManager : NSObject

/**
 检查iCloud是否可用（即账号登录没）

 @return YES 可用，NO 不可用
 */
+ (BOOL)iCloudEnable;

/**
 将iCloud文件下载到沙盒
 
 @param url iCloud文件的url
 @param successHandler 下载成功block
 */
+ (void)downloadWithDocumentURL:(NSURL *)url successHandler:(void(^)(id obj))successHandler;

@end

NS_ASSUME_NONNULL_END
