//
//  AppMacro.h
//  Mine
//
//  Created by 佐藤 昌樹 on 2015/01/17.
//  Copyright (c) 2015年 sacchy. All rights reserved.
//

#ifndef Mine_AppMacro_h
#define Mine_AppMacro_h

#define WIN_SIZE self.view.bounds.size
#define WIN_WIDTH WIN_SIZE.width
#define WIN_HEIGHT WIN_SIZE.height
#define STATUSBAR_HEIGHT 20
#define TABLE_IOS_6 CGRectMake(0, STATUSBAR_HEIGHT, self.view.bounds.size.width, self.view.bounds.size.height - self.navigationController.toolbar.frame.size.height*2)
#define TABLE_IOS_7 CGRectMake(0, STATUSBAR_HEIGHT, self.view.bounds.size.width, self.view.bounds.size.height - self.navigationController.toolbar.frame.size.height*2-[[UIApplication sharedApplication] statusBarFrame].size.height)
#define TABLE_RECT ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) ? TABLE_IOS_7  : TABLE_IOS_6
#endif
