//
//  HKDocument.m
//  renqin
//
//  Created by hooyking on 2019/10/22.
//  Copyright © 2019 hooyking. All rights reserved.
//

#import "HKDocument.h"

@implementation HKDocument

- (BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError *__autoreleasing  _Nullable *)outError {
    self.data = contents;
    return YES;
}

@end
