//
//  LabelUtil.m
//  Mine
//
//  Created by Sacchy on 2015/01/17.
//  Copyright (c) 2015年 Sacchy. All rights reserved.
//

#import "LabelUtil.h"

@implementation LabelUtil

- (UILabel *)createLabel:(CGRect)frame labelType:(LabelType)type
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    
    switch (type)
    {
        case Label_Main:
            label.font = [UIFont systemFontOfSize:16];
            label.textAlignment   = NSTextAlignmentLeft;
            label.backgroundColor = [UIColor clearColor];
            break;
        default:
            break;
    }
    return label;
}

@end
