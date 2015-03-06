//
//  UerManageListViewCell.h
//  jiankangyizu
//
//  Created by JEREI on 15-2-5.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UerManageListViewCell : UITableViewCell
{
    UIButton *itemlable;
    UIImageView *userHeadImg;
    UILabel *userName;
    UILabel *sexAndage;
    UILabel *warnTime;
    UILabel *warnNumber;
    UIButton *warnDetail;
    UIImageView *incator;
    UILabel *sublable;
    UIButton *jiankanjianhubtn;
    UIButton *guijijiancebtn;
    UIButton *yonghuxinxibth;
   
}
@property (strong,nonatomic) UIButton *itemlable;
@property (strong ,nonatomic) UIImageView *incator;
@property (strong ,nonatomic) UIImageView *userHeadImg;
@property (strong ,nonatomic) UILabel *userName;
@property (strong ,nonatomic) UILabel *sexAndage;
@property (strong ,nonatomic) UILabel *warnTime;
@property (strong ,nonatomic) UILabel *warnNumber;
@property (strong ,nonatomic) UIButton *warnDetail;
@property (strong ,nonatomic) UIButton *jiankanjianhubtn;
@property (strong ,nonatomic) UIButton *guijijiancebtn;
@property (strong ,nonatomic) UIButton *yonghuxinxibth;
@property (strong ,nonatomic) UILabel *sublable;


@end
@protocol buttonclickDelegate

- (void)buttonClick:(long)buttonflag;

@end
