//
//  GameViewController.m
//  Mine
//
//  Created by 佐藤 昌樹 on 2015/01/19.
//  Copyright (c) 2015年 sacchy. All rights reserved.
//

#import "GameViewController.h"
#import "Grid.h"
#import "Number.h"
#import "Seal.h"

typedef enum kTagGame : long
{
    kTagGrid = 1,
    kTagNumber,
    kTagSeal,
} kTagGame;

typedef enum kState : int
{
    kStatePlay = 1,
    kStateEnd,
} kState;

@interface GameViewController()
{
    kState _state;
}
@end

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _state = kStatePlay;
    [self addGrid];
    [self addNumber];
    [self addSeal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/**
 * グリッドを表示する
 */
- (void)addGrid
{
    Grid* grid = [[Grid alloc] initWithFrame:self.view.bounds
                           headerHeight:STATUSBAR_HEIGHT + NAVIGATIONBAR_HEIGHT
                             mainHeight:WIN_AVARABLE_VIEW_HEIGHT
                                mapSize:MAP_SIZE];
    [grid setTag:kTagGrid];
    [self.view addSubview:grid];
}

/**
 * 数を表示する
 */
- (void)addNumber
{
    Grid* grid = (Grid*)[self.view viewWithTag:kTagGrid];
    if (grid)
    {
        Number* number = [[Number alloc] initWithFrame:self.view.bounds
                                         originY:STATUSBAR_HEIGHT + NAVIGATIONBAR_HEIGHT + (WIN_AVARABLE_VIEW_HEIGHT - [grid getSplitSize])/2
                                       splitSize:[grid getSplitSize]
                                         mapSize:MAP_SIZE];
        [number setTag:kTagNumber];
        [self.view addSubview:number];
    }
    else
    {
        [self showAlert:@"問題が発生しました" message:@"正常に読み込みができませんでした" delegate:self btnTitle:@"確認"];
    }
}

/**
 * 数の上に貼るシールを表示する
 */
- (void)addSeal
{
    Grid* grid = (Grid*)[self.view viewWithTag:kTagGrid];
    if (grid)
    {
        Seal* seal = [[Seal alloc] initWithFrame:self.view.bounds
                                    originY:STATUSBAR_HEIGHT + NAVIGATIONBAR_HEIGHT + (WIN_AVARABLE_VIEW_HEIGHT - [grid getSplitSize])/2
                                  splitSize:[grid getSplitSize]
                                    mapSize:MAP_SIZE];
        [seal setTag:kTagSeal];
        [self.view addSubview:seal];
    }
    else
    {
        [self showAlert:@"問題が発生しました" message:@"正常に読み込みができませんでした" delegate:self btnTitle:@"確認"];
    }
}

/**
 * タップされたシールを剥がす
 */
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    Seal* seal = (Seal*)[self.view viewWithTag:kTagSeal];
    Number* number = (Number*)[self.view viewWithTag:kTagNumber];
    if (seal && number && _state == kStatePlay)
    {
        UITouch *touch = [touches anyObject];
        CGPoint touchpoint = [touch locationInView:self.view];
        int num = [number getNumberByPos:CGPointMake(touchpoint.x, touchpoint.y)];
        if (num == MINE)
        {
            _state = kStateEnd;
            [self showAlert:@"ゲームオーバー" message:@"またの挑戦をお待ちしております" delegate:self btnTitle:@"メインへ"];
            NSMutableArray* removePosArray = [number getMinePos];
            for (int i = 0; i < removePosArray.count; i++)
            {
                [seal removePos:[removePosArray[i] CGPointValue]];
            }
        }
        else if (num != ERROR)
        {
            if ([seal removePos:CGPointMake(touchpoint.x, touchpoint.y)] == GAME_CLEAR)
            {
                _state = kStateEnd;
                [self showAlert:@"ゲームクリア" message:@"おめでとうございます" delegate:self btnTitle:@"メインへ"];
            }
        }
        else
        {
            NSLOG(@"エラー");
        }
    }
    else
    {
        NSLOG(@"ゲームは終了しています");
    }
}

@end
