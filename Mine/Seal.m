//
//  Seal.m
//  Mine
//
//  Created by Sacchy on 2015/01/20.
//  Copyright (c) 2015年 Sacchy. All rights reserved.
//

#import "Seal.h"
#import "GameViewController.h"

@interface Seal()
{
    float _originY;
    float _splitSize;
    int _num;
    int _maxMinNum;
    int _map[MAX_MAP_SIZE][MAX_MAP_SIZE];
}
@end

@implementation Seal

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
        
        for (int i = 0; i < _num; i++)
        {
            for (int j = 0; j < _num; j++)
            {
                _map[i][j] = SEAL;
            }
        }
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();

    // グリッドを表示
    CGFloat emptyColor[4] = {0.5f, 0.0f, 1.0f, 1.0f};
    CGFloat checkColor[4] = {0.8f, 0.0f, 0.7f, 1.0f};

    // オフセット
    float offsetX = (WIN_WIDTH - _splitSize)/2;

    // シールを貼る
    for (int i = 0; i < _num; i++)
    {
        for (int j = 0; j < _num; j++)
        {
            if (_map[i][j] == SEAL)
            {
                CGContextSetFillColor(context, emptyColor);
                CGContextFillRect(context, CGRectMake(offsetX + _splitSize/_num*i + 1 , _originY + _splitSize/_num*j + 1, _splitSize/_num - 2, _splitSize/_num - 2));
            }
            else if (_map[i][j] == CHECK)
            {
                CGContextSetFillColor(context, checkColor);
                CGContextFillRect(context, CGRectMake(offsetX + _splitSize/_num*i + 1 , _originY + _splitSize/_num*j + 1, _splitSize/_num - 2, _splitSize/_num - 2));
            }
        }
    }
}

/**
 * タップされた座標のシールを剥がす
 * @param pos タップされた座標
 */
- (int)removePos:(CGPoint)pos
{
    if (_originY < pos.y && pos.y < _originY + _splitSize)
    {
        if (_map[(int)pos.x/(int)(_splitSize/_num)][(int)(pos.y - _originY)/(int)(_splitSize/_num)] == SEAL)
        {
            _map[(int)pos.x/(int)(_splitSize/_num)][(int)(pos.y - _originY)/(int)(_splitSize/_num)] = EMPTY;
            
            // 再描画し直す
            [self setNeedsDisplay];
            
            // ゲームクリア判定
            int count = 0;
            for (int i = 0; i < _num; i++)
                for (int j = 0; j < _num; j++)
                    if (_map[i][j] != EMPTY)
                        count++;
            
            if (count == _maxMinNum)
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

/**
 * 地雷の上に貼られているシールを剥がす
 * @param pos 地雷の上に貼られているシールの座標（添字）
 */
- (void)removeMineSeal:(CGPoint)pos
{
    _map[(int)pos.x][(int)pos.y] = EMPTY;
}

/**
 * 地雷チェックした座標のシールの色を変更する
 * @param pos タップされた座標
 */
- (void)checkPos:(CGPoint)pos
{
    if (_originY < pos.y && pos.y < _originY + _splitSize)
    {
        if (_map[(int)pos.x/(int)(_splitSize/_num)][(int)(pos.y - _originY)/(int)(_splitSize/_num)] == SEAL)
        {
            _map[(int)pos.x/(int)(_splitSize/_num)][(int)(pos.y - _originY)/(int)(_splitSize/_num)] = CHECK;
            
            // 再描画し直す
            [self setNeedsDisplay];
        }
        else if (_map[(int)pos.x/(int)(_splitSize/_num)][(int)(pos.y - _originY)/(int)(_splitSize/_num)] == CHECK)
        {
            _map[(int)pos.x/(int)(_splitSize/_num)][(int)(pos.y - _originY)/(int)(_splitSize/_num)] = SEAL;
            
            // 再描画し直す
            [self setNeedsDisplay];
        }
    }
}

/**
 * 地雷チェックした座標かどうかを取得する
 * @param pos タップされた座標
 */
- (BOOL)isCheckPos:(CGPoint)pos
{
    if (_originY < pos.y && pos.y < _originY + _splitSize)
    {
        if (_map[(int)pos.x/(int)(_splitSize/_num)][(int)(pos.y - _originY)/(int)(_splitSize/_num)] == CHECK)
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    else
    {
        return NO;
    }
}

@end
