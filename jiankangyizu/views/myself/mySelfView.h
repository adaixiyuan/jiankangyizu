//
//  mySelfView.h
//  jiankangyizu
//
//  Created by apple on 15/2/2.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonUser.h"
@interface mySelfView : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myselfTable;
    NSMutableArray *arrayData;
    UITableView *myTableView;
    CommonUser *user;
    UIImageView *userTitleImg;
    UILabel *username;
    UILabel *usersexAndage;
    UILabel *zhanghao;
    UIButton *mymessageBtn;
}


@end
