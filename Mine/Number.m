//
//  Number.m
//  Mine
//
//  Created by 佐藤 昌樹 on 2015/01/20.
//  Copyright (c) 2015年 sacchy. All rights reserved.
//

#import "Number.h"

@interface Number()
{
    float _originY;
    float _splitSize;
    int _num;
    int _number[MAX_MAP_SIZE][MAX_MAP_SIZE];
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
        [self initNumber];
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
            CGPoint point = CGPointMake(offsetX + _splitSize/_num*(i+0.5) - font.pointSize/3, _originY + _splitSize/_num*(j+0.5) - font.pointSize/2);
            [[NSString stringWithFormat:@"%d",_number[i][j]] drawAtPoint:point withFont:font];
        }
    }
}

/**
 * 各マスに表示する数をセットする
 */
- (void)initNumber
{
    // 初期化
    for (int i = 0; i < MAX_MAP_SIZE; i++)
    {
        for (int j = 0; j < MAX_MAP_SIZE; j++)
        {
            _number[i][j] = EMPTY;
        }
    }
    
    // Mineをセット
    for (int i = 0; i < MAX_MINE_NUM; )
    {
        int x = arc4random()%_num, y = arc4random()%_num;
        if (_number[x][y] != MINE)
        {
            _number[x][y] = MINE;
            
            // 数をセット（MINEの周囲を＋１する）
            for (int w = x-1; w <= x+1; w++)
            {
                for (int h = y-1; h <= y+1; h++)
                {
                    if (0 <= w && 0 <= h && w < _num && h < _num && _number[w][h] != MINE)
                    {
                        _number[w][h]++;
                    }
                }
            }
            i++;
        }
    }
}

/**
 * タップした位置の数を取得する
 */
- (int)getNumberByPos:(CGPoint)pos
{
    if (_originY < pos.y && pos.y < _originY + _splitSize)
    {
        return _number[(int)pos.x/(int)(_splitSize/_num)][(int)(pos.y - _originY)/(int)(_splitSize/_num)];
    }
    else
    {
        return ERROR;
    }
}

/**
 * 地雷の位置を全て取得する
 */
- (NSMutableArray*)getMinePos
{
    NSMutableArray* minesArray = [NSMutableArray array];
    for (int i = 0; i < _num; i++)
    {
        for (int j = 0; j < _num; j++)
        {
            if (_number[i][j] == MINE)
            {
                [minesArray addObject:[NSValue valueWithCGPoint:CGPointMake((WIN_WIDTH - _splitSize)/2 + _splitSize/_num*i + 1, _originY + _splitSize/_num*j + 1)]];
            }
        }
    }
    return minesArray;
}

@end
