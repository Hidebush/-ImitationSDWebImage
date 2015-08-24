//
//  NSString+path.h
//  加载网络图片
//
//  Created by Theshy on 15/8/23.
//  Copyright © 2015年 Theshy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (path)

- (NSString *)appDocumentDir;
- (NSString *)appCacheDir;
- (NSString *)appTmpDir;


@end
