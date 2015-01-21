//
//  GameViewController.m
//  Mine
//
//  Created by Sacchy on 2015/01/19.
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
    kStateCheckMode,
    kStateEnd,
} kState;

@interface GameViewController()
{
    kState _state;
}
@end

@implementation GameViewController
@synthesize _mapSize, _mineNum;

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSLOG(@"map:%ld mine:%ld", (long)_mapSize, (long)_mineNum);
    _state = kStatePlay;
    [self addHeaderBtn];
    [self addGrid];
    [self addNumber];
    [self addSeal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/**
 * 地雷チェックボタンを追加
 */
- (void)addHeaderBtn
{
    UIBarButtonItem *modeChangeButton = [[UIBarButtonItem alloc] initWithTitle:@"地雷チェックモードに変更"
                                                                  style:UIBarButtonItemStyleDone
                                                                 target:self
                                                                 action:@selector(btnCallBack)];
    self.navigationController.navigationBar.tintColor = nil;
    self.navigationItem.rightBarButtonItem = modeChangeButton;
}

/**
 * グリッドを表示する
 */
- (void)addGrid
{
    Grid* grid = [[Grid alloc] initWithFrame:self.view.bounds
                                headerHeight:STATUSBAR_HEIGHT + NAVIGATIONBAR_HEIGHT
                                  mainHeight:WIN_AVARABLE_VIEW_HEIGHT
                                     mapSize:_mapSize];
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
                                               mapSize:_mapSize
                                            maxMineNum:_mineNum];
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
                                         mapSize:(int)_mapSize
                                        maxMineNum:_mineNum];
        [seal setTag:kTagSeal];
        [self.view addSubview:seal];
        
        if ([seal getNotEmptyCount] == _mineNum)
        {
            [self gameClear];
        }
    }
    else
    {
        [self showAlert:@"問題が発生しました" message:@"正常に読み込みができませんでした" delegate:self btnTitle:@"確認"];
    }
}

/**
 * 地雷チェックモードと地雷チェックモードの解除を実行
 */
- (void)btnCallBack
{
    if (_state == kStateEnd)
    {
        return;
    }
    else if (_state != kStateCheckMode)
    {
        _state = kStateCheckMode;
        self.navigationController.navigationBar.tintColor = [UIColor redColor];
        self.navigationItem.rightBarButtonItem.title = @"地雷チェックモード解除";
    }
    else
    {
        _state = kStatePlay;
        self.navigationController.navigationBar.tintColor = nil;
        self.navigationItem.rightBarButtonItem.title = @"地雷チェックモードに変更";
    }
}

/**
 * タップされたシールを剥がす
 */
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    Seal* seal = (Seal*)[self.view viewWithTag:kTagSeal];
    Number* number = (Number*)[self.view viewWithTag:kTagNumber];
    Grid* grid = (Grid*)[self.view viewWithTag:kTagGrid];
    
    if (seal && number && grid && _state == kStatePlay)
    {
        UITouch *touch = [touches anyObject];
        CGPoint touchpoint = [touch locationInView:self.view];
        int num = [number getNumberByPos:CGPointMake(touchpoint.x, touchpoint.y)];
        
        if ([seal isCheckPos:CGPointMake(touchpoint.x, touchpoint.y)] == YES)
        {
            return;
        }
        else if (num == MINE)
        {
            _state = kStateEnd;
            [self showAlert:@"ゲームオーバー" message:@"またの挑戦をお待ちしております" delegate:self btnTitle:@"確認"];
            NSMutableArray* removePosArray = [number getMinePos];
            for (int i = 0; i < removePosArray.count; i++)
            {
                [seal removeMineSealByIdx:[removePosArray[i] CGPointValue]];
            }
            [seal setNeedsDisplay];
            self.navigationItem.rightBarButtonItem.title = @"お疲れ様でした";
        }
        else if (num == EMPTY)
        {
            // タップされた座標を添字に変換
            int x = (int)touchpoint.x/((int)[grid getSplitSize]/_mapSize);
            int y = ((int)touchpoint.y - (STATUSBAR_HEIGHT + NAVIGATIONBAR_HEIGHT + (WIN_AVARABLE_VIEW_HEIGHT - (int)[grid getSplitSize])/2))/((int)[grid getSplitSize]/_mapSize);
            NSMutableArray* removePosArray = [number autoCheckNumber:CGPointMake(x, y)];
            for (int i = 0; i < removePosArray.count; i++)
            {
                if ([seal removePosByIdx:[removePosArray[i] CGPointValue]] == GAME_CLEAR)
                {
                    NSLOG(@"clear x:%f y:%f",[removePosArray[i] CGPointValue].x,[removePosArray[i] CGPointValue].y);
                    [self gameClear];
                }
            }
            [seal setNeedsDisplay];
        }
        else if (num != ERROR)
        {
            if ([seal removePos:CGPointMake(touchpoint.x, touchpoint.y)] == GAME_CLEAR)
            {
                [self gameClear];
            }
        }
        else
        {
            NSLOG(@"エラー");
        }
    }
    else if (seal && _state == kStateCheckMode)
    {
        UITouch *touch = [touches anyObject];
        CGPoint touchpoint = [touch locationInView:self.view];
        [seal checkPos:CGPointMake(touchpoint.x, touchpoint.y)];
    }
    else
    {
        NSLOG(@"ゲームは終了しています");
    }
}

/**
 * ゲームクリアアラートを表示する
 */
- (void)gameClear
{
    _state = kStateEnd;
    [self showAlert:@"ゲームクリア" message:@"おめでとうございます" delegate:self btnTitle:@"確認"];
    self.navigationItem.rightBarButtonItem.title = @"お疲れ様でした";
}

@end
