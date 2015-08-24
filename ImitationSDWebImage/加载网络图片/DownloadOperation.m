//
//  DownloadOperation.m
//  加载网络图片
//
//  Created by Theshy on 15/8/24.
//  Copyright © 2015年 Theshy. All rights reserved.
//

#import "DownloadOperation.h"
#import "NSString+path.h"

@interface DownloadOperation ()
@property (nonatomic, strong) NSString *URLString;
@property (nonatomic, copy) void(^finishedBlock)(UIImage *image);

@end

@implementation DownloadOperation

- (void)main {
    @autoreleasepool {
        NSAssert(self.finishedBlock != nil, @"没有传递finishedBlock回调");
        NSURL *url = [NSURL URLWithString:self.URLString];
        NSData *data = [NSData dataWithContentsOfURL:url];
        if (data != nil) {
            [data writeToFile:self.URLString.appCacheDir atomically:YES];
        }
        
        /// 取消操作
        if (self.isCancelled) {
            return;
        }
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.finishedBlock([UIImage imageWithData:data]);
        }];
 
    }
    
}

+ (instancetype)downloadOperationWithURLString:(NSString *)string finished:(void (^)(UIImage *))finished {
    DownloadOperation *op = [[DownloadOperation alloc] init];
    op.URLString = string;
    op.finishedBlock = finished;
    return op;
}

@end
