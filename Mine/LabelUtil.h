//
//  LabelUtil.h
//  Mine
//
//  Created by Sacchy on 2015/01/17.
//  Copyright (c) 2015年 Sacchy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum LabelType
{
    Label_Main,
} LabelType;

@interface LabelUtil : UIViewController

- (UILabel *)createLabel:(CGRect)frame labelType:(LabelType)type;

@end
