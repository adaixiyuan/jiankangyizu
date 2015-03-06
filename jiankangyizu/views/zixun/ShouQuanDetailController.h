//
//  ShouQuanDetailController.h
//  jiankangyizu
//
//  Created by JEREI on 15-2-15.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JkUserManage.h"
#import "CommonUser.h"
#import "ChatDetailView.h"
@interface ShouQuanDetailController : UIViewController
{
    CommonUser *user;
}
@property(nonatomic,strong)JkUserManage *userManage;
@end
