//
//  Seal.h
//  Mine
//
//  Created by 佐藤 昌樹 on 2015/01/20.
//  Copyright (c) 2015年 sacchy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Seal : UIView

- (id)initWithFrame:(CGRect)frame originY:(float)originY splitSize:(float)splitSize mapSize:(int)num;
- (int)removePos:(CGPoint)pos;
- (void)checkPos:(CGPoint)pos;
- (BOOL)isCheckPos:(CGPoint)pos;

@end
