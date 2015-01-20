//
//  PickerUtil.h
//  Mine
//
//  Created by 佐藤 昌樹 on 2015/01/20.
//  Copyright (c) 2015年 sacchy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum PickerType
{
    Picker_Main,
} PickerType;

@interface PickerUtil : UIViewController

- (UIPickerView *)createPickerWithToolBarFrame:(CGRect)toolBarFrame PickerType:(PickerType)type;
- (int)getNumberOfComponent:(PickerType)type;

@end
