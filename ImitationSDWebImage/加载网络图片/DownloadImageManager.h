//
//  DownloadImageManager.h
//  加载网络图片
//
//  Created by Theshy on 15/8/24.
//  Copyright © 2015年 Theshy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownloadImageManager : NSObject

+ (instancetype)sharedManager;

/// 下载方法
- (void)downloadOperationWithURLString: (NSString *)string finished: (void(^)(UIImage *image))finished;

- (void)cancelDownloadWithURLString: (NSString *)URLString;
@end
