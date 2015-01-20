//
//  Grid.h
//  Mine
//
//  Created by Sacchy on 2015/01/19.
//  Copyright (c) 2015年 Sacchy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Grid : UIView

- (id)initWithFrame:(CGRect)frame headerHeight:(float)headerHeight mainHeight:(float)mainHeight mapSize:(int)num;
- (int)getSplitSize;

@end
