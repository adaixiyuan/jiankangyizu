//
//  UserMessageViewController.h
//  jiankangyizu
//
//  Created by JEREI on 15-2-5.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullingRefreshTableView.h"
#import "WaitProgress.h"
#import "SDImageView+SDWebCache.h"
#import "CommonUser.h"
#import "JkUserManage.h"
#import "JkCase.h"
@interface UserMessageViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,PullingRefreshTableViewDelegate>
{
    UIButton *moreButton;
    BOOL pcIsChange;
    int networkFlag;
    BOOL now;
    BOOL firstDone;
    int userId;
    int companyId;
    CommonUser *user;
    JkUserManage *userManage;
    int postviewaddheigth;
    JkCaseDAO* dao;
}
@property(nonatomic,strong) JkUserManage *userManage;
@property(nonatomic,strong) CommonUser *user;
@property(nonatomic,strong) NSMutableData *receiveData2;
@property(nonatomic,strong) NSMutableData *receiveData1;
@property(nonatomic,strong) NSURLConnection *connection2;
@property(nonatomic,strong) WaitProgress *wait;
@property(nonatomic,strong) NSURLConnection *connection1;
@property(nonatomic,strong) PullingRefreshTableView *postView;
@property(nonatomic,retain) NSMutableArray *postArray;
@property(nonatomic,assign) NSInteger page;
@property(nonatomic) BOOL refreshing;
@property(nonatomic,assign)int height;

@end
