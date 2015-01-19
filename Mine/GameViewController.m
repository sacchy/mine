//
//  GameViewController.m
//  Mine
//
//  Created by 佐藤 昌樹 on 2015/01/19.
//  Copyright (c) 2015年 sacchy. All rights reserved.
//

#import "GameViewController.h"
#import "AppMacro.h"
#import "Grid.h"
#import "Seal.h"

typedef enum kTagGame : long
{
    kTagGrid = 1,
    kTagSeal,
} kTagGame;

@interface GameViewController()
{

}
@end

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addGrid];
    [self addSeal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//    [_grid setNeedsDisplay];
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
 * マスの上に貼るシールを表示する
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
 * タップされた位置を取得する
 */
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
//    NSLog(@"%@", touch.view);
    
    //タッチされた位置を取得
    CGPoint touchpoint = [touch locationInView:self.view];
    NSLog(@"x:%lf y:%lf",touchpoint.x, touchpoint.y);
    
    //得られた位置にあるlayerを取得
//    CALayer *layer = [self.view.layer hitTest:touchpoint];
}

@end
