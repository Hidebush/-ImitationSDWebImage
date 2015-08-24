//
//  DownloadImageManager.m
//  加载网络图片
//
//  Created by Theshy on 15/8/24.
//  Copyright © 2015年 Theshy. All rights reserved.
//

#import "DownloadImageManager.h"
#import "DownloadOperation.h"
#import "NSString+path.h"

@interface DownloadImageManager ()
@property (nonatomic, strong) NSOperationQueue *queue;
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

/// 下载图片
- (void)downloadOperationWithURLString:(NSString *)string finished:(void (^)(UIImage *))finished {
    NSAssert(finished != nil, @"必须传入finished回调");
    if (self.operationcache[string] != nil) {
        NSLog(@"正在下载中...");
        return;
    }
    
    if ([self checkImageCacheWithString:string]) {
        finished(self.imagecache[string]);
        return;
    }
    DownloadOperation *op = [DownloadOperation downloadOperationWithURLString:string finished:^(UIImage *image) {
        /// 完成回调
        finished(image);
        /// 删除完成后的操作
        [self.operationcache removeObjectForKey:string];
    }];
    
    [self.operationcache setObject:op forKey:string];
    [self.queue addOperation:op];
    
}

/// 检查图片缓存
- (BOOL)checkImageCacheWithString: (NSString *)urlString {
    if (self.imagecache[urlString] != nil) {
        NSLog(@"内存缓存...");
        return YES;
    }
    
    UIImage *image = [UIImage imageWithContentsOfFile:urlString.appCacheDir];
    if (image != nil) {
        NSLog(@"沙盒缓存...");
//        NSLog(@"%@",NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject);
        [self.imagecache setValue:image forKey:urlString];
        return YES;
    }
    
    return NO;
}


/// 取消下载
- (void)cancelDownloadWithURLString:(NSString *)URLString {
    DownloadOperation *op = self.operationcache[URLString];
    if (op == nil) {
        return;
    }
    [op cancel];
    [self.imagecache removeObjectForKey:URLString];
}

#pragma mark 懒加载

- (NSOperationQueue *)queue {
    if (_queue == nil) {
        _queue = [[NSOperationQueue alloc] init];
        
    }
    return _queue;
}

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
