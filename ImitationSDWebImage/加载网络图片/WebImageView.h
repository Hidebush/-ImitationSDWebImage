//
//  WebImageView.h
//  加载网络图片
//
//  Created by Theshy on 15/8/24.
//  Copyright © 2015年 Theshy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebImageView : UIImageView
@property (nonatomic, copy) NSString *urlString;

- (void)setImageWithUrlString: (NSString *)urlString;
@end
