//
//  QuestionDetailViewController.h
//  jiankangyizu
//
//  Created by JEREI on 15-2-6.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JkConsultation.h"
#import "PullingRefreshTableView.h"
#import "WaitProgress.h"
#import "CommonUser.h"
@interface QuestionDetailViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,PullingRefreshTableViewDelegate>
{
    JkConsultation *jkconsultation;
    UIButton *moreButton;
    BOOL pcIsChange;
    BOOL now;
    BOOL firstDone;
    int imageheigth;
    UITextField *callbackContent;
    UIButton *submitbtn ;
    UIView *topview;
    CommonUser *user;
 }
@property(nonatomic,assign) float cellheigth;
@property JkConsultation *jkconsultation;
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
