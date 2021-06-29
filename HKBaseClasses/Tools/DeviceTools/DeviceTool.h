//
//  DeviceTool.h
//  OrePool
//
//  Created by hooyking on 2021/4/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeviceTool : NSObject

/**
 获取设备型号
 */
+ (NSString *)getDeviceName;
/**
 获取Mac地址
 */
+ (NSString *)getMacAddress;
/**
 获取IP地址
 */
+ (NSString *)getDeviceIPAddresses;

@end

NS_ASSUME_NONNULL_END
