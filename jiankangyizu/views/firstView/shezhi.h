//
//  shezhi.h
//  yuehandier
//
//  Created by apple on 14/12/13.
//  Copyright (c) 2014年 jerei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClearCacheAlert.h"
@interface shezhi : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *setView;
    UIButton *quitBtn;
    UIButton *clearBtn;
    ClearCacheAlert *clearCacheAlert;
}
@property(nonatomic,strong)UITableView *setView;
@property(nonatomic,strong)ClearCacheAlert *clearCacheAlert;
@end
