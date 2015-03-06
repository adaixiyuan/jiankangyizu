//
//  ziXunView.h
//  jiankangyizu
//
//  Created by apple on 15/2/2.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullingRefreshTableView.h"
#import "CommonUser.h"
#import "WaitProgress.h"
#import "MLTableAlert.h"
#import "JkConsultation.h"
@interface ziXunView : UIViewController <UITableViewDataSource,UITableViewDelegate,PullingRefreshTableViewDelegate>
{
    UIButton *moreButton;
    BOOL pcIsChange;
    int networkFlag;
    BOOL now;
    BOOL firstDone;
    CommonUser *user;
    NSString *queryFlag;
    NSString *queryCondition;
    NSMutableArray *dataList;
    NSMutableArray *departmentList;
    UIButton *quanbukeshibtn;
    UIButton *quanbuwentibtn;
    NSString *departmentNo;
    int questionFlag;
    JkConsultationDAO* dao;
    
}
@property (strong, nonatomic) MLTableAlert *alert;
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
