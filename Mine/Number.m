//
//  Number.m
//  Mine
//
//  Created by Sacchy on 2015/01/20.
//  Copyright (c) 2015年 Sacchy. All rights reserved.
//

#import "Number.h"

@interface Number()
{
    float _originY;
    float _splitSize;
    int _num;
    int _maxMinNum;
    int _number[MAX_MAP_SIZE][MAX_MAP_SIZE];
    NSMutableArray* _searchPos;
    NSMutableArray* _finishPos;
}
@end

@implementation Number

- (id)initWithFrame:(CGRect)frame originY:(float)originY splitSize:(float)splitSize mapSize:(int)num maxMineNum:(int)maxMineNum
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        _originY = originY;
        _splitSize = splitSize;
        _num = num;
        _maxMinNum = maxMineNum;
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
            if (_number[i][j] == MINE)
            {
                CGPoint point = CGPointMake(offsetX + _splitSize/_num*(i+0.5) - font.pointSize/2, _originY + _splitSize/_num*(j+0.5) - font.pointSize/2);
                [@"爆" drawAtPoint:point withFont:font];
            }
            else if (_number[i][j] != EMPTY)
            {
                CGPoint point = CGPointMake(offsetX + _splitSize/_num*(i+0.5) - font.pointSize/3.5, _originY + _splitSize/_num*(j+0.5) - font.pointSize/2);
                [[NSString stringWithFormat:@"%d",_number[i][j]] drawAtPoint:point withFont:font];
            }
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
    for (int i = 0; i < _maxMinNum; )
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
 * @param pos タップした位置
 * @return タップした位置の値を返す
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
 * @return シールを剥がす座標を返す
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
                [minesArray addObject:[NSValue valueWithCGPoint:CGPointMake(i, j)]];
            }
        }
    }
    return minesArray;
}

/**
 * 空白マスをタップした時に自動でシールを剥がす
 * @param pos 検索対象座標
 * @return シールを剥がす座標を返す
 */
- (NSMutableArray*)autoCheckNumber:(CGPoint)pos
{
    _searchPos = [NSMutableArray array];
    _finishPos = [NSMutableArray array];
    [_searchPos addObject:[NSValue valueWithCGPoint:pos]];
    
    while (_searchPos.count != 0)
    {
        CGPoint targetPos = [_searchPos[0] CGPointValue];
        [_finishPos addObject:[NSValue valueWithCGPoint:targetPos]];
        [_searchPos removeObjectAtIndex:0];

        NSArray* pointArray = [NSArray arrayWithObjects:
                               [NSValue valueWithCGPoint:CGPointMake(targetPos.x-1,  targetPos.y-1)],
                               [NSValue valueWithCGPoint:CGPointMake(targetPos.x,  targetPos.y-1)],
                               [NSValue valueWithCGPoint:CGPointMake(targetPos.x+1,targetPos.y-1)],
                               [NSValue valueWithCGPoint:CGPointMake(targetPos.x-1,targetPos.y)],
                               [NSValue valueWithCGPoint:CGPointMake(targetPos.x,targetPos.y)],
                               [NSValue valueWithCGPoint:CGPointMake(targetPos.x+1,targetPos.y)],
                               [NSValue valueWithCGPoint:CGPointMake(targetPos.x-1,targetPos.y+1)],
                               [NSValue valueWithCGPoint:CGPointMake(targetPos.x,  targetPos.y+1)],
                               [NSValue valueWithCGPoint:CGPointMake(targetPos.x+1,targetPos.y+1)], nil];
        
        // 8方向を検索する
        for (int i = 0, w, h; i < pointArray.count; i++)
        {
            w = [pointArray[i] CGPointValue].x;
            h = [pointArray[i] CGPointValue].y;
            
            if ([self isExistSearchPos:[pointArray[i] CGPointValue]] == YES || [self isExistFinishPos:[pointArray[i] CGPointValue]] == YES)
            {
                continue;
            }
            else if (0 <= w && 0 <= h && w < _num && h < _num && _number[w][h] == EMPTY)
            {
                [_searchPos addObject:[NSValue valueWithCGPoint:CGPointMake(w, h)]];
            }
            else if (0 <= w && 0 <= h && w < _num && h < _num && _number[w][h] != EMPTY)
            {
                [_finishPos addObject:[NSValue valueWithCGPoint:CGPointMake(w, h)]];
            }
        }
    }

    return _finishPos;
}

/**
 * すでに検索予約されているかどうかを取得する
 * @param pos 検索予約されたかどうかを調べる位置
 * @return YES:検索予約されている NO:検索予約されていない
 */
- (BOOL)isExistSearchPos:(CGPoint)pos
{
    for (int i = 0; i < _searchPos.count; i++)
    {
        if (CGPointEqualToPoint([_searchPos[i] CGPointValue], pos) == YES)
        {
            return YES;
        }
    }
    return NO;
}

/**
 * すでに検索が終わった位置かどうかを取得する
 * @param pos 検索されたかどうかを調べる位置
 * @return YES:検索が終わっている NO:検索が終わっていない
 */
- (BOOL)isExistFinishPos:(CGPoint)pos
{
    for (int i = 0; i < _finishPos.count; i++)
    {
        if (CGPointEqualToPoint([_finishPos[i] CGPointValue], pos) == YES)
        {
            return YES;
        }
    }
    return NO;
}

@end
