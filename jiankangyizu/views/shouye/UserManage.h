//
//  shouYeView.h
//  jiankangyizu
//
//  Created by apple on 15/2/2.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullingRefreshTableView.h"
#import "WaitProgress.h"
#import "CommonUser.h"
#import "JkUserManage.h"
@interface UserManage : UIViewController <UITableViewDataSource,UITableViewDelegate,PullingRefreshTableViewDelegate>
{
    UIButton *moreButton;
    BOOL pcIsChange;
    int networkFlag;
    BOOL now;
    BOOL firstDone;
    int userId;
    int companyId;
    int itemheight;
    NSMutableArray *flagarray;
    JkUserManageDao* dao;
}
@property(nonatomic,assign) int itemheight;
@property(nonatomic,strong) CommonUser *user;
@property(nonatomic,strong) NSMutableData *receiveData2;
@property(nonatomic,strong) NSURLConnection *connection2;
@property(nonatomic,strong) WaitProgress *wait;
@property(nonatomic,strong) PullingRefreshTableView *postView;
@property(nonatomic,retain) NSMutableArray *postArray;
@property(nonatomic,assign) NSInteger page;
@property(nonatomic) BOOL refreshing;
@property(nonatomic,assign)int height;
@end

