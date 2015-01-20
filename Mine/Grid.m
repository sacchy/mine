//
//  Grid.m
//  Mine
//
//  Created by Sacchy on 2015/01/19.
//  Copyright (c) 2015年 Sacchy. All rights reserved.
//

#import "Grid.h"

@interface Grid()
{
    float _headerHeight;
    float _mainHeight;
    int _num;
}
@end

@implementation Grid

- (id)initWithFrame:(CGRect)frame headerHeight:(float)headerHeight mainHeight:(float)mainHeight mapSize:(int)num
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        _headerHeight = headerHeight;
        _mainHeight = mainHeight;
        _num = num;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // グリッドを表示
    CGFloat color[4] = {0.5f, 0.0f, 1.0f, 1.0f};
    CGContextSetStrokeColor(context, color);
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, .5f);
    
    // オフセット
    float win_width = [self getSplitSize];
    float offsetX = (WIN_WIDTH - win_width)/2;
    float offsetY = (_mainHeight - win_width)/2;
    
    // 縦線を表示
    for (int x = 0; x <= win_width; x += win_width/_num)
    {
        CGContextMoveToPoint(   context, x + offsetX, _headerHeight + offsetY);
        CGContextAddLineToPoint(context, x + offsetX, _headerHeight + offsetY + win_width);
    }

    // 横線を表示
    for (int y = _headerHeight; y <= _headerHeight + win_width; y += win_width/_num)
    {
        CGContextMoveToPoint(   context, offsetX            , y + offsetY);
        CGContextAddLineToPoint(context, offsetX + win_width, y + offsetY);
    }
    CGContextStrokePath(context);
}

/**
 * マスを分割するサイズを取得する
 * @return サイズ
 */
- (int)getSplitSize
{
    for (int size = WIN_WIDTH; 0 < size; size--)
    {
        if (size % _num == 0)
        {
            return size;
        }
    }
    NSLOG(@"警告：デフォルト値を使います");
    return 40;
}

@end
