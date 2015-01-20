//
//  Number.h
//  Mine
//
//  Created by Sacchy on 2015/01/20.
//  Copyright (c) 2015年 Sacchy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Number : UIView

- (id)initWithFrame:(CGRect)frame originY:(float)originY splitSize:(float)splitSize mapSize:(int)num maxMineNum:(int)maxMineNum;
- (void)initNumber;
- (int)getNumberByPos:(CGPoint)pos;
- (NSMutableArray*)getMinePos;

@end
