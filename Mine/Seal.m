//
//  Seal.m
//  Mine
//
//  Created by 佐藤 昌樹 on 2015/01/20.
//  Copyright (c) 2015年 sacchy. All rights reserved.
//

#import "Seal.h"
#import "GameViewController.h"

@interface Seal()
{
    float _originY;
    float _splitSize;
    int _num;
    int _map[MAX_MAP_SIZE][MAX_MAP_SIZE];
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
        for (int i = 0; i < _num; i++)
        {
            for (int j = 0; j < _num; j++)
            {
                _map[i][j] = 1;
            }
        }
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
            if (_map[i][j])
            {
                CGContextFillRect(context, CGRectMake(offsetX + _splitSize/_num*i + 1 , _originY + _splitSize/_num*j + 1, _splitSize/_num - 2, _splitSize/_num - 2));
            }
        }
    }
}

/**
 * タップされた座標のシールを剥がす
 */
- (int)removePos:(CGPoint)pos
{
    if (_originY < pos.y && pos.y < _originY + _splitSize)
    {
        if (_map[(int)pos.x/(int)(_splitSize/_num)][(int)(pos.y - _originY)/(int)(_splitSize/_num)])
        {
            _map[(int)pos.x/(int)(_splitSize/_num)][(int)(pos.y - _originY)/(int)(_splitSize/_num)] = 0;
            
            // 再描画し直す
            [self setNeedsDisplay];
            
            // ゲームクリア判定
            int count = 0;
            for (int i = 0; i < _num; i++)
                for (int j = 0; j < _num; j++)
                    if (_map[i][j] != 0)
                        count++;
            
            if (count == MAX_MINE_NUM)
            {
                return GAME_CLEAR;
            }
            else
            {
                return ERROR;
            }
        }
        else
        {
            return ERROR;
        }
    }
    else
    {
        return ERROR;
    }
}

@end
