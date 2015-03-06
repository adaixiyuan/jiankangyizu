//
//  WarnDetailCellTableViewCell.h
//  jiankangyizu
//
//  Created by JEREI on 15-2-4.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WarnDetailCellTableViewCell : UITableViewCell
{
    UIImageView *userHeadImg;
    UILabel *userName;
    UILabel *sexAndage;
    UILabel *warnTime;
    UILabel *warnNumber;
    UIButton *warnDetail;
    UIImageView *incator;
}
@property (strong ,nonatomic) UIImageView *incator;
@property (strong ,nonatomic) UIImageView *userHeadImg;
@property (strong ,nonatomic) UILabel *userName;
@property (strong ,nonatomic) UILabel *sexAndage;
@property (strong ,nonatomic) UILabel *warnTime;
@property (strong ,nonatomic) UILabel *warnNumber;
@property (strong ,nonatomic) UIButton *warnDetail;
@end
