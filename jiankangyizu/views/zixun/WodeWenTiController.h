//
//  WodeWenTiController.h
//  jiankangyizu
//
//  Created by JEREI on 15-2-15.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaitProgress.h"
#import "PullingRefreshTableView.h"
#import "CommonUser.h"
#import "JkConsultation.h"
@interface WodeWenTiController : UIViewController <UITableViewDataSource,UITableViewDelegate,PullingRefreshTableViewDelegate>
{
    UIButton *moreButton;
    BOOL pcIsChange;
    BOOL now;
    BOOL firstDone;
    CommonUser *user;
    int networkFlag;
    JkConsultationDAO *dao;
   
}

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
