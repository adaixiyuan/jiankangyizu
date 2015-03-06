//
//  notificationMessage.h
//  asiastarbus
//
//  Created by apple on 14-10-14.
//  Copyright (c) 2014年 jerei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WcmCmsMemberMessage.h"
@interface notificationMessage : UIViewController
{
    UIView *rightView;
    UILabel *titleLabel;
    UILabel *contentLabel;
    UIView *topView;
    UILabel *viewCountLabel;
    UILabel *shareButton;
    UIWebView *newsWebView;
}
@property(nonatomic,strong)WcmCmsMemberMessage *notifiction;
@end
