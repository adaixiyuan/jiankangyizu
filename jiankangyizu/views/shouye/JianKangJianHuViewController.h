//
//  JianKangJianHuViewController.h
//  jiankangyizu
//
//  Created by JEREI on 15-2-9.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JkUserManage.h"
#import "PMCalendar.h"
#import "CommonUser.h"
#import "WaitProgress.h"
#import "PullingRefreshTableView.h"
@interface JianKangJianHuViewController : UIViewController <PMCalendarControllerDelegate,UITableViewDataSource,UITableViewDelegate,PullingRefreshTableViewDelegate>
{
    UIButton *moreButton;
    BOOL pcIsChange;
    BOOL now;
    BOOL firstDone;
    int companyId;
    CommonUser *user;
    NSMutableArray *flagarray;
    int queyFlag;
     UIDatePicker *startdatePicker;
     UIDatePicker *enddatePicker;
}
@property(nonatomic,strong) JkUserManage *jkuserManahe;
@property(nonatomic,strong) NSMutableData *receiveData2;
@property(nonatomic,strong) NSURLConnection *connection2;
@property(nonatomic,strong) WaitProgress *wait;
@property(nonatomic,strong) PullingRefreshTableView *postView;
@property(nonatomic,retain) NSMutableArray *postArray;
@property(nonatomic,assign) NSInteger page;
@property(nonatomic) BOOL refreshing;
@property(nonatomic,assign)int height;
@end
