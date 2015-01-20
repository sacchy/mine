//
//  TableUtil.h
//  Mine
//
//  Created by Sacchy on 2015/01/17.
//  Copyright (c) 2015年 Sacchy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum TableType
{
    Table_Main,
} TableType;

@interface TableUtil : UIViewController

- (UITableView *)createTable:(CGRect)frame tableType:(TableType)type;
- (int)getTableSection:(TableType)type;
- (int)getTableNumberOfRows:(TableType)type;
- (int)getTableCellHeight:(TableType)type;
- (NSMutableArray *)getTableTextOfLabel:(TableType)type;

@end
