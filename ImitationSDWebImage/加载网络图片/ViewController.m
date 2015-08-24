//
//  ViewController.m
//  加载网络图片
//
//  Created by Theshy on 15/8/22.
//  Copyright © 2015年 Theshy. All rights reserved.
//

#import "ViewController.h"
#import "AppInfo.h"
#import "AppCell.h"
#import "NSString+path.h"

@interface ViewController ()
@property (nonatomic, strong) NSArray *apps;
@property (nonatomic, strong) NSOperationQueue *queue;
@property (nonatomic, strong) NSMutableDictionary *operationcache;
@property (nonatomic, strong) NSMutableDictionary *imagecache;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    NSLog(@"%@",self.apps);
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.apps.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AppCell *cell = [tableView dequeueReusableCellWithIdentifier:@"appCell" forIndexPath:indexPath];
        
        AppInfo *app = self.apps[indexPath.row];
        cell.app = app;
        if (self.imagecache[app.icon] != nil) {
            cell.imageView.image = self.imagecache[app.icon];
            NSLog(@"从内存加载...");
            return cell;
        }
    UIImage *image = [UIImage imageWithContentsOfFile:app.icon.appCacheDir];
    if (image) {
        [self.imagecache setObject:image forKey:app.icon];
        cell.imageView.image = self.imagecache[app.icon];
        NSLog(@"从沙盒加载....");
        return cell;
    }
    
    [self downloadImage:app indexPath:indexPath];
    
    return cell;
}

- (void)downloadImage: (AppInfo *)app indexPath: (NSIndexPath *)indexPath {
    if ([self.operationcache objectForKey:app.icon]) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"图片正在下载中...");
        NSURL *url = [NSURL URLWithString:app.icon];
        NSData *data = [NSData dataWithContentsOfURL:url];
        if (data) {
            
            [data writeToFile:app.icon.appCacheDir atomically:YES];
        }
        UIImage *image = [UIImage imageWithData:data];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            //                cell.iconView.image = image;
            [weakSelf.operationcache removeObjectForKey:app.icon];
//            app.image = image;
            if (image != nil) {
                [self.imagecache setObject:image forKey:app.icon];
                [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }
        }];
        
    }];
    
    [self.operationcache setObject:op forKey:app.icon];
    [self.queue addOperation:op];
}


- (NSMutableDictionary *)imagecache {
    if (_imagecache == nil) {
        _imagecache = [NSMutableDictionary dictionary];
    }
    return _imagecache;
}

- (NSMutableDictionary *)operationcache {
    if (_operationcache == nil) {
        _operationcache = [NSMutableDictionary dictionary];
    }
    return _operationcache;
}

- (NSOperationQueue *)queue {
    if (_queue == nil) {
        _queue = [[NSOperationQueue alloc] init];
        
    }
    return _queue;
}

- (NSArray *)apps {
    if (_apps == nil) {
        _apps = [AppInfo apps];
    }
    return _apps;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self.queue cancelAllOperations];
    [self.operationcache removeAllObjects];
    [self.imagecache removeAllObjects];
    
    
}

@end
