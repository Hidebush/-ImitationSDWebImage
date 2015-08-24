//
//  ViewController.m
//  加载网络图片
//
//  Created by Theshy on 15/8/22.
//  Copyright © 2015年 Theshy. All rights reserved.
//

#import "ViewController.h"
#import "AppCell.h"


@interface ViewController ()
@property (nonatomic, strong) NSArray *apps;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.apps.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AppCell *cell = [tableView dequeueReusableCellWithIdentifier:@"appCell" forIndexPath:indexPath];
        
        AppInfo *app = self.apps[indexPath.row];
        cell.app = app;

    return cell;
}


- (NSArray *)apps {
    if (_apps == nil) {
        _apps = [AppInfo apps];
    }
    return _apps;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

@end
