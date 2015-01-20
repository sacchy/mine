//
//  TableUtil.m
//  Mine
//
//  Created by 佐藤 昌樹 on 2015/01/17.
//  Copyright (c) 2015年 Sacchy. All rights reserved.
//

#import "TableUtil.h"

@interface TableUtil ()

@end

@implementation TableUtil

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/**
 * テーブルを作成
 */
- (UITableView *)createTable:(CGRect)frame tableType:(TableType)type
{
    UITableView *tableView;
    
    switch (type)
    {
        case Table_Main:
            tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
            tableView.allowsSelection = YES;
            tableView.scrollEnabled   = YES;
            tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
            tableView.backgroundColor = [UIColor clearColor];
            break;
        default:
            break;
    }
    return tableView;
}

/**
 * テーブルのセクション数を返す
 */
- (int)getTableSection:(TableType)type
{
    int section = 0;
    
    switch (type)
    {
        case Table_Main:
            section = 1;
            break;
        default:
            break;
    }
    return section;
}

/**
 * テーブルの行数を返す
 */
- (int)getTableNumberOfRows:(TableType)type
{
    int row = 0;
    
    switch (type)
    {
        case Table_Main:
            row = 1;
            break;
        default:
            break;
    }
    return row;
}

/**
 * テーブルの高さを返す
 */
- (int)getTableCellHeight:(TableType)type
{
    int height = 0;
    
    switch (type)
    {
        case Table_Main:
            height = 50;
            break;
        default:
            break;
    }
    return height;
}

/**
 * テーブルに表示するテキストを返す
 */
- (NSMutableArray *)getTableTextOfLabel:(TableType)type
{
    NSMutableArray *data = [NSMutableArray array];
    
    switch (type)
    {
        case Table_Main:
            [data addObject:@"Lebel 1に挑戦する？"];
            break;
        default:
            break;
    }
    return data;
}

@end
