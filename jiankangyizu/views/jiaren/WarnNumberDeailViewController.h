//
//  WarnNumberDeailViewViewController.h
//  jiankangyizu
//
//  Created by JEREI on 15-2-3.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullingRefreshTableView.h"
#import "WaitProgress.h"
#import "SDImageView+SDWebCache.h"
#import "CommonUser.h"
#import "JkHealthy.h"
@interface WarnNumberDeailViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,PullingRefreshTableViewDelegate>
{
    UIButton *moreButton;
    int networkFlag;
    BOOL pcIsChange;
    BOOL now;
    BOOL firstDone;
    int userId;
    int companyId;
    NSString *tableName;
    int healthFlag;
    NSString *titles;
    CommonUser *user;
    JkHealthyDAO* dao;
}
@property(nonatomic,strong)  NSString *tableName;
@property(nonatomic,assign) int healthFlag;
@property(nonatomic,strong) NSString *titles;
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
