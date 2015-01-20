//
//  PickerViewController.h
//  Mine
//
//  Created by 佐藤 昌樹 on 2015/01/20.
//  Copyright (c) 2015年 sacchy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerViewController : UIViewController
<
UIPickerViewDelegate,
UIPickerViewDataSource
>

- (void)initData;
- (void)addToolbar;
- (void)addPicker;
- (void)addInvisibleBtn;
- (void)showPicker;
- (void)hidePicker;
- (void)done;

@end
