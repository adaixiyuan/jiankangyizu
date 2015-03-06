//
//  CaseDetailViewController.h
//  jiankangyizu
//
//  Created by JEREI on 15-2-5.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JkCase.h"
#import "JkUserManage.h"
@interface CaseDetailViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    JkCase *jkcase;
    JkUserManage *jkUserManage;
    NSMutableArray *arrayData;
    UITableView *myTableView;
}

@property(nonatomic,strong) JkUserManage *jkUserManage;
@property(nonatomic,strong) JkCase *jkcase;
@end
