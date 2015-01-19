//
//  AlertController.m
//  Mine
//
//  Created by 佐藤 昌樹 on 2015/01/20.
//  Copyright (c) 2015年 sacchy. All rights reserved.
//

#import "AlertController.h"

@implementation AlertController

- (void)showAlert:(NSString *)title message:(NSString *)message delegate:(id)delegate btnTitle:(NSString *)btnTitle
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:delegate
                                          cancelButtonTitle:btnTitle
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
            //１番目のボタンが押されたときの処理を記述する
            NSLog(@"click");
            break;
        case 1:
            //２番目のボタンが押されたときの処理を記述する
            break;
    }
}

@end
