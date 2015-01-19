//
//  AppMacro.h
//  Mine
//
//  Created by 佐藤 昌樹 on 2015/01/17.
//  Copyright (c) 2015年 sacchy. All rights reserved.
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

#define TABLE_IOS_6 CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - self.navigationController.toolbar.frame.size.height*2)
#define TABLE_IOS_7 CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - self.navigationController.toolbar.frame.size.height*2-[[UIApplication sharedApplication] statusBarFrame].size.height)
#define TABLE_RECT ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) ? TABLE_IOS_7  : TABLE_IOS_6

#define MAX_MAP_SIZE 10
#endif
