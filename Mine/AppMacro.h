//
//  AppMacro.h
//  Mine
//
//  Created by Sacchy on 2015/01/17.
//  Copyright (c) 2015年 Sacchy. All rights reserved.
//

#ifndef Mine_AppMacro_h
#define Mine_AppMacro_h

#define WIN_VIEW_SIZE self.view.bounds.size
#define WIN_VIEW_WIDTH WIN_VIEW_SIZE.width
#define WIN_VIEW_HEIGHT WIN_VIEW_SIZE.height
#define WIN_SIZE self.bounds.size
#define WIN_WIDTH WIN_SIZE.width
#define WIN_HEIGHT WIN_SIZE.height
#define STATUSBAR_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height
#define NAVIGATIONBAR_HEIGHT self.navigationController.navigationBar.frame.size.height
#define WIN_AVARABLE_VIEW_HEIGHT WIN_VIEW_HEIGHT - STATUSBAR_HEIGHT - NAVIGATIONBAR_HEIGHT
#define WIN_AVARABLE_HEIGHT WIN_HEIGHT - STATUSBAR_HEIGHT - NAVIGATIONBAR_HEIGHT

#define TABLE_IOS_6 CGRectMake(0, 0, WIN_VIEW_WIDTH, WIN_VIEW_HEIGHT - self.navigationController.toolbar.frame.size.height*2)
#define TABLE_IOS_7 CGRectMake(0, 0, WIN_VIEW_WIDTH, WIN_VIEW_HEIGHT - self.navigationController.toolbar.frame.size.height*2-STATUSBAR_HEIGHT)
#define TABLE_RECT ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) ? TABLE_IOS_7  : TABLE_IOS_6

//_/_/_/ Game Setting /_/_/_/
#undef DEBUG
#define MAP_SIZE 5
#define MAX_MAP_SIZE 50
#define MAX_MINE_NUM 5
#define ERROR -2
#define MINE -1
#define EMPTY 0
#define SEAL 1
#define CHECK 2
#define GAME_CLEAR 888
#endif