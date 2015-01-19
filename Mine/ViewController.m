//
//  ViewController.m
//  Mine
//
//  Created by 佐藤 昌樹 on 2015/01/17.
//  Copyright (c) 2015年 sacchy. All rights reserved.
//

#import "ViewController.h"
#import "TableUtil.h"
#import "AppMacro.h"

@interface ViewController ()
{
    UITableView* _tableview;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self addTable];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
