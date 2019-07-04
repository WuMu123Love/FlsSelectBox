//
//  FViewController.m
//  FlsSelectBox
//
//  Created by 1361825681@qq.com on 07/03/2019.
//  Copyright (c) 2019 1361825681@qq.com. All rights reserved.
//

#import "FViewController.h"
#import "FLSFiltrateView.h"

@interface FViewController ()

@end

@implementation FViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray * array = @[@"1",@"2",@"3",@"4"];
    FLSFiltrateView * flsview = [[FLSFiltrateView alloc] initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, array.count*60+20)];
    flsview.titleArray = array;
    flsview.backSelectItemArray = ^(NSArray * _Nonnull itemArray) {
        NSLog(@"%@",itemArray);
    };
    [self.view addSubview:flsview];}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
