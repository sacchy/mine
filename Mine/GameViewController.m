//
//  GameViewController.m
//  Mine
//
//  Created by 佐藤 昌樹 on 2015/01/19.
//  Copyright (c) 2015年 sacchy. All rights reserved.
//

#import "GameViewController.h"
#import "AppMacro.h"
#import "Grid.h"

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addGrid];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/**
 * グリッドを表示する
 */
- (void)addGrid
{
    Grid* grid = [[Grid alloc] initWithFrame:self.view.bounds headerHeight:STATUSBAR_HEIGHT + NAVIGATIONBAR_HEIGHT mainHeight:WIN_AVARABLE_VIEW_HEIGHT mapSize:5];
    [self.view addSubview:grid];
}

@end
