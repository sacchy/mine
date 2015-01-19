//
//  Seal.m
//  Mine
//
//  Created by 佐藤 昌樹 on 2015/01/20.
//  Copyright (c) 2015年 sacchy. All rights reserved.
//

#import "Seal.h"
#import "AppMacro.h"

@interface Seal()
{
    float _originY;
    float _splitSize;
    int _num;
}
@end

@implementation Seal

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
    CGContextRef context = UIGraphicsGetCurrentContext();

    // グリッドを表示
    CGFloat color[4] = {0.5f, 0.0f, 1.0f, 1.0f};

    // オフセット
    float offsetX = (WIN_WIDTH - _splitSize)/2;

    // シールを貼る
    CGContextSetFillColor(context, color);
    for (int i = 0; i < _num; i++)
    {
        for (int j = 0; j < _num; j++)
        {
            CGContextFillRect(context, CGRectMake(offsetX + _splitSize/_num*j + 1 , _originY + _splitSize/_num*i + 1, _splitSize/_num - 2, _splitSize/_num - 2));
        }
    }
}

@end
