//
//  Seal.h
//  Mine
//
//  Created by Sacchy on 2015/01/20.
//  Copyright (c) 2015年 Sacchy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Seal : UIView

- (id)initWithFrame:(CGRect)frame originY:(float)originY splitSize:(float)splitSize mapSize:(int)num maxMineNum:(int)maxMineNum;
- (int)removePos:(CGPoint)pos;
- (void)removeMineSeal:(CGPoint)pos;
- (void)checkPos:(CGPoint)pos;
- (BOOL)isCheckPos:(CGPoint)pos;
- (int)getNotEmptyCount;

@end
