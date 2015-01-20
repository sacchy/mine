//
//  PickerViewController.m
//  Mine
//
//  Created by 佐藤 昌樹 on 2015/01/20.
//  Copyright (c) 2015年 sacchy. All rights reserved.
//

#import "PickerViewController.h"
#import "PickerUtil.h"
#import "GameViewController.h"

@interface PickerViewController ()
{
    int _mapSize;
    int _mineNum;
    UIToolbar *_toolbar;
    UIPickerView* _picker;
    UIButton *_invisibleButton;
    NSMutableArray* _pickerSizeTitleArray;
    NSMutableArray* _pickerMineTitleArray;
}
@end

@implementation PickerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initData];
    [self addInvisibleBtn];
    [self addToolbar];
    [self addPicker];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)initData
{
    _mapSize = MIN_MAP_SIZE;
    _mineNum = MIN_MINE_NUM;

    _pickerSizeTitleArray = [NSMutableArray array];
    _pickerMineTitleArray = [NSMutableArray array];
    
    for (int i = 2; i <= MAX_MAP_SIZE; i++)
        [_pickerSizeTitleArray addObject:[NSString stringWithFormat:@"マス %d ✕ %d",i,i]];

    for (int i = 1; i <= INIT_MINE_NUM; i++)
        [_pickerMineTitleArray addObject:[NSString stringWithFormat:@"地雷 %d 個",i]];
}

/**
 * ツールバーを表示する
 */
- (void)addToolbar
{
    _toolbar = [[UIToolbar alloc] initWithFrame:self.navigationController.toolbar.frame];
    _toolbar.frame = self.navigationController.toolbar.frame;
    _toolbar.barStyle = UIBarStyleBlack;
    _toolbar.translucent = YES;
    UIBarButtonItem *Adjustflex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *DoneItem = [[UIBarButtonItem alloc] initWithTitle:@"スタート"
                                                                 style:UIBarButtonItemStyleDone
                                                                target:self
                                                                action:@selector(done)];
    NSArray *buttonItems = [NSArray arrayWithObjects:Adjustflex,DoneItem, nil];
    [_toolbar setItems:buttonItems animated:NO];
}

/**
 * ピッカーを表示する
 */
- (void)addPicker
{
    _picker = [[PickerUtil alloc] createPickerWithToolBarFrame:_toolbar.frame PickerType:Picker_Main];
    _picker.delegate = self;
    _picker.dataSource = self;
    
    float addFrame = STATUSBAR_HEIGHT;
    CGRect slotframe = _picker.frame;
    _toolbar.frame = self.navigationController.toolbar.frame;
    slotframe.origin.y = _toolbar.frame.origin.y + _toolbar.frame.size.height + addFrame;
    _picker.frame = slotframe;
}

/**
 *
 */
- (void)addInvisibleBtn
{
    _invisibleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _invisibleButton.backgroundColor = [UIColor clearColor];
    [_invisibleButton addTarget:self action:@selector(hidePicker)forControlEvents:UIControlEventTouchUpInside];
    [_invisibleButton setTitle:@"" forState:UIControlStateDisabled];
}

/**
 * ゲームスタート
 */
- (void)done
{
    GameViewController* _gameViewController = [[GameViewController alloc] init];
    _gameViewController._mapSize = _mapSize;
    _gameViewController._mineNum = _mineNum;
    [self.navigationController pushViewController:_gameViewController animated:YES];
}

/**
 * ピッカーを表示する
 */
- (void)showPicker
{
    [_picker selectRow:0 inComponent:0 animated:NO];
    [_picker selectRow:0 inComponent:1 animated:NO];

    [self.view addSubview:_invisibleButton];
    [self.view addSubview:_picker];
    [self.view addSubview:_toolbar];
    [_picker reloadAllComponents];

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelay:0.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    CGRect toolbarframe = _toolbar.frame;
    toolbarframe.origin.y = toolbarframe.origin.y - toolbarframe.size.height*2 - _picker.frame.size.height;
    _toolbar.frame = toolbarframe;
    
    CGRect slotframe = _picker.frame;
    slotframe.origin.y = slotframe.origin.y - toolbarframe.size.height*2 - _picker.frame.size.height;
    _picker.frame = slotframe;
    
    CGRect _invisibleFrame = _toolbar.frame;
    _invisibleFrame.size.height = _toolbar.frame.origin.y;
    _invisibleFrame.origin.y = 0;
    _invisibleButton.frame = _invisibleFrame;
    
    [UIView commitAnimations];
}

/**
 * ピッカーを隠す
 */
- (void)hidePicker
{
    [_invisibleButton removeFromSuperview];
    
    // 初期化
    _mapSize = MIN_MAP_SIZE;
    _mineNum = MIN_MINE_NUM;
    _pickerMineTitleArray = [NSMutableArray array];
    for (int i = 1; i <= INIT_MINE_NUM; i++)
        [_pickerMineTitleArray addObject:[NSString stringWithFormat:@"地雷 %d 個",i]];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelay:0.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    float addFrame = STATUSBAR_HEIGHT;
    CGRect slotframe = _picker.frame;
    _toolbar.frame = self.navigationController.toolbar.frame;
    slotframe.origin.y = _toolbar.frame.origin.y + _toolbar.frame.size.height + addFrame;
    _picker.frame = slotframe;
    
    [UIView commitAnimations];
}

#pragma mark - Picker Method

/**
 * ピッカーの列数
 */
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return [[PickerUtil alloc] getNumberOfComponent:Picker_Main];
}

/**
 * 各ピッカーの行数
 */
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component == 0)
    {
        return _pickerSizeTitleArray.count;
    }
    else
    {
        return _pickerMineTitleArray.count;
    }
}

/**
 * 表示するテキスト
 */
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component == 0)
    {
        return _pickerSizeTitleArray[row];
    }
    else
    {
        return  _pickerMineTitleArray[row];
    }
}

/**
 * ピッカー選択時の処理
 */
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0)
    {
        _mapSize = (int)row + 2;
        
        // 地雷の表示を更新する
        _pickerMineTitleArray = [NSMutableArray array];
        for (int i = 1; i <= (row+2)*(row+2); i++)
            [_pickerMineTitleArray addObject:[NSString stringWithFormat:@"地雷 %d 個",i]];
        
        // 最大の地雷数を超えている場合
        if (((int)row+2)*((int)row+2) < _mineNum)
        {
            _mineNum = ((int)row+2)*((int)row+2);
        }
        
        [_picker reloadAllComponents];
    }
    else
    {
        _mineNum = (int)row + 1;
    }
}

@end
