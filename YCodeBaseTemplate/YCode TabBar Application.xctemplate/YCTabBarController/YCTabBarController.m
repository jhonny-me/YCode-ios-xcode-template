//
//  YCTabBarController.m
//  test2
//
//  Created by 顾强 on 16/5/5.
//  Copyright © 2016年 ycode. All rights reserved.
//

#import "YCTabBarController.h"
#import <objc/runtime.h>

@interface YCTabBarController ()

@end

@implementation YCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *configArray = [self readConfigFile];
    NSMutableArray *viewControllers = [NSMutableArray arrayWithCapacity:4];
    for (NSDictionary *dic in configArray) {
        Class ViewController = NSClassFromString(dic[@"ViewController"]);
        id vc = [ViewController new];
        
        UIImage *image = [UIImage imageNamed:dic[@"img"]];
        UIImage *selectedImage = [UIImage imageNamed:dic[@"highlightImg"]];
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:dic[@"title"] image:image selectedImage:selectedImage];
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:(UIViewController *)vc];
        nav.view.backgroundColor = [UIColor whiteColor];
        nav.tabBarItem = item;
        [viewControllers addObject:nav];
    }
    [self setViewControllers:viewControllers animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methods

- (NSArray *)readConfigFile{
    return [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MainTabBarConfig" ofType:@"plist"]];
}

@end
