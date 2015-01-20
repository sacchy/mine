//
//  TableController.m
//  Mine
//
//  Created by Sacchy on 2015/01/17.
//  Copyright (c) 2015年 Sacchy. All rights reserved.
//

#import "TableController.h"
#import "TableUtil.h"
#import "LabelUtil.h"
#import "GameViewController.h"

@interface TableController ()
{
    UITableView* _tableview;
    UILabel*     _label;
}
@end

@implementation TableController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Levelを選択して下さい";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/**
 * レベル選択用のテーブルを描画
 */
- (void)addTable
{
    _tableview = [[TableUtil alloc] createTable:TABLE_RECT tableType:Table_Main];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [self.view addSubview:_tableview];
}

/**
 * テーブルのセクション数
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[TableUtil alloc] getTableSection:Table_Main];
}

/**
 * テーブルの行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[TableUtil alloc] getTableNumberOfRows:Table_Main];
}

/**
 * テーブルの高さ
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[TableUtil alloc] getTableCellHeight:Table_Main];
}

/**
 * テーブルの内容
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [_tableview dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.backgroundColor = [UIColor clearColor];
        
        _label = [[LabelUtil alloc] createLabel:CGRectMake(10.0, [[TableUtil alloc] getTableCellHeight:Table_Main]/4, WIN_VIEW_WIDTH, 20.0) labelType:Label_Main];
        _label.tag = 1;
        [cell.contentView addSubview:_label];
    }
    else
    {
        _label = (UILabel *)[cell.contentView viewWithTag:1];
    }

    NSMutableArray* textArray = [[TableUtil alloc] getTableTextOfLabel:Table_Main];
    _label.text = textArray[indexPath.row];
    
    return cell;
}

/**
 * テーブルがタップされた時の処理
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    GameViewController* gameViewController = [[GameViewController alloc] init];
    [self.navigationController pushViewController:gameViewController animated:YES];
}

@end
