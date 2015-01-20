//
//  GameViewController.h
//  Mine
//
//  Created by Sacchy on 2015/01/19.
//  Copyright (c) 2015年 Sacchy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlertController.h"

@interface GameViewController : AlertController

- (void)addHeaderBtn;
- (void)addGrid;
- (void)addNumber;
- (void)addSeal;
- (void)btnCallBack;

@property (readwrite) int _mapSize;
@property (readwrite) int _mineNum;

@end
