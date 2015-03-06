//
//  NotificationMessageCell.h
//  ViewDeckExample
//
//  Created by apple on 13-11-14.
//  Copyright (c) 2013年 Adriaenssen BVBA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WcmCmsMemberMessage.h"
@interface NotificationMessageCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *notificationTable;
    int num;
    WcmCmsMemberMessage *ads;
}
@property(nonatomic,strong)UIImageView *imageViewa;
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong) UITableView *notificationTable;
@property(nonatomic,assign) int num;
@property(nonatomic,strong)WcmCmsMemberMessage *ads;
@end
