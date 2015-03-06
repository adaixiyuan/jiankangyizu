//
//  dengLuView.h
//  yuehandier
//
//  Created by apple on 14/12/11.
//  Copyright (c) 2014年 jerei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonUser.h"
#import "RDVTabBarController.h"
@interface dengLuView : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITableView *tableViewOfDenglu;
    NSString *name;
    NSString *password;
    NSString *method;
    UIAlertView* alert ;
    RDVTabBarController *tabBarController;
}
@property(nonatomic,assign) int LoginFlag;
@property(nonatomic,strong)NSURLConnection *connection1;
@property(nonatomic,strong)NSMutableData *receiveData1;
@property(nonatomic,strong)NSURLConnection *connection2;
@property(nonatomic,strong)NSMutableData *receiveData2;
@end
