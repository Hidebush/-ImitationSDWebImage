//
//  UIImageView+webView.m
//  加载网络图片
//
//  Created by Theshy on 15/8/25.
//  Copyright © 2015年 Theshy. All rights reserved.
//

#import "UIImageView+webView.h"
#import "DownloadImageManager.h"
#import <objc/runtime.h>

@implementation UIImageView (webView)
- (void)setImageWithUrlString:(NSString *)urlString {
    /// 判断当前下载图像与上一次是否一致  不一样则取消操作 图像赋为nil 防止复用显示上一次图片
    if (![self.urlString isEqualToString:urlString]) {
        [[DownloadImageManager sharedManager] cancelDownloadWithURLString:urlString];
        self.image = nil;
    }
        self.urlString = urlString;
    __weak typeof(self) weaksSelf = self;
    /// 下载图片
    
    [[DownloadImageManager sharedManager] downloadOperationWithURLString:urlString finished:^(UIImage *image) {
        weaksSelf.image = image;
    }];
    
}

const void *URLStringKey = @"URLStringKey";

- (void)setUrlString:(NSString *)urlString {
    objc_setAssociatedObject(self, URLStringKey, urlString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)urlString {
    return objc_getAssociatedObject(self, URLStringKey);
}

@end
