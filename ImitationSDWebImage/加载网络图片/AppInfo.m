//
//  AppInfo.m
//  加载网络图片
//
//  Created by Theshy on 15/8/22.
//  Copyright © 2015年 Theshy. All rights reserved.
//

#import "AppInfo.h"

@implementation AppInfo
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        //         字典转模型的代码
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}



+ (instancetype)appInfoWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}


+ (NSArray *)apps
{
    // 获取绝对路径
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"apps" withExtension:@"plist"];
    NSArray *dictArray = [NSArray arrayWithContentsOfURL:url];
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"apps" ofType:@"plist"];
//    //  加载plist
//    NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
    //  把数组中的字典转模型
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:dictArray.count];
    for (NSDictionary *dict  in dictArray) {
        
        AppInfo *app = [[self alloc] initWithDict:dict];
        [arrayM addObject:app];
    }
    
    return arrayM.copy;
}
@end
