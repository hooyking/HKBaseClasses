//
//  HKiCloudManager.m
//  renqin
//
//  Created by hooyking on 2019/10/22.
//  Copyright © 2019 hooyking. All rights reserved.
//

#import "HKiCloudManager.h"
#import "HKDocument.h"

@implementation HKiCloudManager

+ (BOOL)iCloudEnable {
    if ([NSFileManager defaultManager].ubiquityIdentityToken) {
        return YES;
    }
    return NO;
}

+ (void)downloadWithDocumentURL:(NSURL *)url successHandler:(void (^)(id _Nonnull))successHandler {
    HKDocument *iCloudDoc = [[HKDocument alloc] initWithFileURL:url];
    [iCloudDoc openWithCompletionHandler:^(BOOL success) {
        if (success) {
            [iCloudDoc closeWithCompletionHandler:^(BOOL success) {
                HKLog(@"关闭成功");
            }];
            successHandler ? successHandler(iCloudDoc.data) : nil;
        }
    }];
}

@end
