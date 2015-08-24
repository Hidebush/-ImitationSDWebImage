//
//  AppInfo.h
//  加载网络图片
//
//  Created by Theshy on 15/8/22.
//  Copyright © 2015年 Theshy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AppInfo : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *download;
//@property (nonatomic, strong) UIImage *image;

/**
 *  字典转模型
 */
- (instancetype) initWithDict:(NSDictionary *) dict;

+ (instancetype) appInfoWithDict:(NSDictionary *) dict;

/**
 *  封装plist的加载
 */
+ (NSArray *) apps;

@end
