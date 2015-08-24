
//
//  WebImageView.m
//  加载网络图片
//
//  Created by Theshy on 15/8/24.
//  Copyright © 2015年 Theshy. All rights reserved.
//

#import "WebImageView.h"
#import "DownloadImageManager.h"

@interface WebImageView ()
@property (nonatomic, copy) NSString *currentURLString;
@end

@implementation WebImageView

- (void)setImageWithUrlString:(NSString *)urlString {
    /// 判断当前下载图像与上一次是否一致  不一样则取消操作 图像赋为nil 防止复用显示上一次图片
    if (![self.currentURLString isEqualToString:urlString]) {
        [[DownloadImageManager sharedManager] cancelDownloadWithURLString:urlString];
        self.image = nil;
    }
    self.currentURLString = urlString;
    
    
    __weak typeof(self) weaksSelf = self;
    /// 下载图片
    
    [[DownloadImageManager sharedManager] downloadOperationWithURLString:urlString finished:^(UIImage *image) {
        weaksSelf.image = image;
    }];
    
}


@end
