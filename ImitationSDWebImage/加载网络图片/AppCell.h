//
//  AppCell.h
//  加载网络图片
//
//  Created by Theshy on 15/8/22.
//  Copyright © 2015年 Theshy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppInfo.h"

@interface AppCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *downLoadLabel;

@property (nonatomic, strong) AppInfo *app;


@end
