//
//  commonAction.m
//  asiastarbus
//
//  Created by apple on 14-8-20.
//  Copyright (c) 2014年 jerei. All rights reserved.
//

#import "commonAction.h"
#import "iToast.h"
#import "MBProgressHUD.h"
@implementation commonAction

+ (void)showToast:(NSString *)contents WhithNavigationController:(UINavigationController *)navigationController
{

    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:navigationController.view animated:YES];
    
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = contents;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:1.5];
   
}
@end
