//
//  AppCell.m
//  加载网络图片
//
//  Created by Theshy on 15/8/22.
//  Copyright © 2015年 Theshy. All rights reserved.
//

#import "AppCell.h"


@implementation AppCell

- (void)setApp:(AppInfo *)app {
    _app = app;
    self.titleLabel.text = app.name;
    self.downLoadLabel.text = app.download;
    self.iconView.image = [UIImage imageNamed:@"user_default"];
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
