//
//  DownloadImageManager.m
//  加载网络图片
//
//  Created by Theshy on 15/8/24.
//  Copyright © 2015年 Theshy. All rights reserved.
//

#import "DownloadImageManager.h"

@interface DownloadImageManager ()
/// 操作缓冲池
@property (nonatomic, strong) NSMutableDictionary *operationcache;
/// 图片缓冲池
@property (nonatomic, strong) NSMutableDictionary *imagecache;
@end

@implementation DownloadImageManager
+ (instancetype)sharedManager {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[self alloc] init];
        }
    });
    return instance;
}


#pragma mark 懒加载

- (NSMutableDictionary *)imagecache {
    if (_imagecache == nil) {
        _imagecache = [NSMutableDictionary dictionary];
    }
    return _imagecache;
}

- (NSMutableDictionary *)operationcache {
    if (_operationcache == nil) {
        _operationcache = [NSMutableDictionary dictionary];
    }
    return _operationcache;
}

@end
