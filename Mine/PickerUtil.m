//
//  PickerUtil.m
//  Mine
//
//  Created by 佐藤 昌樹 on 2015/01/20.
//  Copyright (c) 2015年 sacchy. All rights reserved.
//

#import "PickerUtil.h"

@interface PickerUtil ()

@end

@implementation PickerUtil

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (UIPickerView *)createPickerWithToolBarFrame:(CGRect)toolBarFrame PickerType:(PickerType)type
{
    UIPickerView *pic = [[UIPickerView alloc] init];
    CGRect slotframe = pic.frame;
    
    switch (type)
    {
        case Picker_Main:
            slotframe.origin.y = toolBarFrame.origin.y + toolBarFrame.size.height - STATUSBAR_HEIGHT;
            pic.backgroundColor = [UIColor whiteColor];
            pic.frame = slotframe;
            pic.showsSelectionIndicator = YES;
            break;
        default:
            break;
    }
    return pic;
}

/**
 * ピッカーの列数を取得する
 */
- (int)getNumberOfComponent:(PickerType)type
{
    switch (type)
    {
        case Picker_Main:
            return 2;
        default:
            return 0;
    }
}

@end
