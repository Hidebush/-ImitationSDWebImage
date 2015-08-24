//
//  NSString+path.m
//  加载网络图片
//
//  Created by Theshy on 15/8/23.
//  Copyright © 2015年 Theshy. All rights reserved.
//

#import "NSString+path.h"

@implementation NSString (path)

- (NSString *)appDocumentDir {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    
    return [path stringByAppendingPathComponent:self.lastPathComponent];
}

- (NSString *)appCacheDir {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    return [path stringByAppendingPathComponent:self.lastPathComponent];
}

- (NSString *)appTmpDir {

    return [NSTemporaryDirectory() stringByAppendingPathComponent:self.lastPathComponent];
}

@end
