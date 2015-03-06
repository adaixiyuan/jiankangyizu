//
//  zhiShiKuList.h
//  jiankangyizu
//
//  Created by apple on 15/2/8.
//  Copyright (c) 2015年 jerei. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "RDVTabBarController.h"
#import "PullingRefreshTableView.h"
#import "WaitProgress.h"
#import "CommonUser.h"
#import "JkNews.h"
@interface zhiShiKuList : UIViewController<UITableViewDataSource,UITableViewDelegate,PullingRefreshTableViewDelegate,UITextFieldDelegate>
{
    UIButton *tableBottomButton;
    PullingRefreshTableView *postTable;
    UIView *topView;
    float tableViewWithOutHeight;
    UITextField *pingLunField;
    NSString *conditionString;
    BOOL now;
    int firstDone;
    int networkFlag;
    WaitProgress *waitPrograss;
    JkNewsDAO *dao;
}
@property(nonatomic,assign)int islach;
@property (assign)int page;
@property (assign)BOOL refreshing;
@property(nonatomic,strong)CommonUser *user;
@property(nonatomic,strong)NSURLConnection *connection1;
@property(nonatomic,strong)NSMutableData *receiveData1;
@property(nonatomic,strong)NSURLConnection *connection2;
@property(nonatomic,strong)NSMutableData *receiveData2;
@property(nonatomic,strong)NSMutableArray *postArray;
@end
