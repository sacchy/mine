//
//  GameViewController.h
//  Mine
//
//  Created by 佐藤 昌樹 on 2015/01/19.
//  Copyright (c) 2015年 sacchy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlertController.h"

@interface GameViewController : AlertController

- (void)addGrid;
- (void)addNumber;
- (void)addSeal;

@end
