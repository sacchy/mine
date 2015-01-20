//
//  TableController.h
//  Mine
//
//  Created by Sacchy on 2015/01/17.
//  Copyright (c) 2015年 Sacchy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickerViewController.h"

@interface TableController : PickerViewController
<
    UITableViewDataSource,
    UITableViewDelegate
>

- (void)addTable;

@end
