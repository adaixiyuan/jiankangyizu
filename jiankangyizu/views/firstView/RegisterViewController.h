//
//  RegisterViewController.h
//  jiankangyizu
//
//  Created by JEREI on 15-2-10.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonUser.h"
@interface RegisterViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITableView *tableViewOfDenglu;
    NSString *name;
    NSString *password;
    NSString *email;
    NSString *method;
}
@property(nonatomic,strong)NSURLConnection *connection1;
@property(nonatomic,strong)NSMutableData *receiveData1;
@property(nonatomic,strong)NSURLConnection *connection2;
@property(nonatomic,strong)NSMutableData *receiveData2;
@end