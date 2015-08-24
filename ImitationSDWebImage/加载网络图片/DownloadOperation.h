//
//  DownloadOperation.h
//  加载网络图片
//
//  Created by Theshy on 15/8/24.
//  Copyright © 2015年 Theshy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DownloadOperation : NSOperation

+ (instancetype)downloadOperationWithURLString: (NSString *)string finished: (void(^)(UIImage *))finished;

@end
