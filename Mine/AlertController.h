//
//  AlertController.h
//  Mine
//
//  Created by 佐藤 昌樹 on 2015/01/20.
//  Copyright (c) 2015年 sacchy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertController : UIViewController
<
UIAlertViewDelegate
>
- (void)showAlert:(NSString*)title message:(NSString*)message delegate:(id)delegate btnTitle:(NSString*)btnTitle;

@end
