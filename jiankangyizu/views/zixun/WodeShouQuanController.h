//
//  WodeShouQuanController.h
//  jiankangyizu
//
//  Created by JEREI on 15-2-15.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullingRefreshTableView.h"
#import "WaitProgress.h"
#import "CommonUser.h"
#import "JkUserManage.h"
@interface WodeShouQuanController : UIViewController <UITableViewDataSource,UITableViewDelegate,PullingRefreshTableViewDelegate>
{
    UIButton *moreButton;
    int networkFlag;
    BOOL pcIsChange;
    BOOL now;
    BOOL firstDone;
    CommonUser *user;
    JkUserManageDao* dao;
}
@property(nonatomic,strong) NSMutableData *receiveData2;
@property(nonatomic,strong) NSURLConnection *connection2;
@property(nonatomic,strong) WaitProgress *wait;
@property(nonatomic,strong) PullingRefreshTableView *postView;
@property(nonatomic,retain) NSMutableArray *postArray;
@property(nonatomic,assign) NSInteger page;
@property(nonatomic) BOOL refreshing;
@property(nonatomic,assign)int height;

@end
