//
//  Number.m
//  Mine
//
//  Created by 佐藤 昌樹 on 2015/01/20.
//  Copyright (c) 2015年 sacchy. All rights reserved.
//

#import "Number.h"
#import "AppMacro.h"

@interface Number()
{
    float _originY;
    float _splitSize;
    int _num;
}
@end

@implementation Number

- (id)initWithFrame:(CGRect)frame originY:(float)originY splitSize:(float)splitSize mapSize:(int)num
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        _originY = originY;
        _splitSize = splitSize;
        _num = num;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // オフセット
    float offsetX = (WIN_WIDTH - _splitSize)/2;
    
    // テキストを表示
    UIFont *font = [UIFont fontWithName:@"ArialRoundedMTBold" size:_splitSize/_num*0.5];
    [[UIColor colorWithRed:.8f green:0 blue:0 alpha:1.0f] set];
    for (int i = 0; i < _num; i++)
    {
        for (int j = 0; j < _num; j++)
        {
            [@"3" drawAtPoint:CGPointMake(offsetX + _splitSize/_num*(j+0.5) - font.pointSize/3, _originY + _splitSize/_num*(i+0.5) - font.pointSize/2) withFont:font];
        }
    }
}

@end
