//
//  WarnDetailCellTableViewCell.m
//  jiankangyizu
//
//  Created by JEREI on 15-2-4.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "WarnDetailCellTableViewCell.h"

@implementation WarnDetailCellTableViewCell


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        userHeadImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 70, 70)];
        userName = [[UILabel alloc] initWithFrame:CGRectMake(85, 10, 120, 20)];
        sexAndage = [[UILabel alloc] initWithFrame:CGRectMake(85, 50, 50, 20)];
        warnTime = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth-120, 10, 120, 20)];
        warnNumber = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth-120, 35, 100, 20)];
        warnDetail = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth-120, 60, 50, 20)];
        [warnDetail setBackgroundImage:[UIImage imageNamed:@"warning_noty_bg.png"] forState:UIControlStateNormal];
        [warnDetail setUserInteractionEnabled:NO];
        
        incator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bus_img_clickright.png"]];
        incator.frame = CGRectMake(kDeviceWidth-30, 20, 20, 40);
        [self addSubview:userHeadImg];
        [self addSubview:userName];
        [self addSubview:sexAndage];
        [self addSubview:warnTime];
        [self addSubview:warnNumber];
        [self addSubview:warnDetail];
//        [self addSubview:incator];
       
    }
    return self;
}

@synthesize userHeadImg;
@synthesize userName;
@synthesize sexAndage;
@synthesize warnTime;
@synthesize warnNumber;
@synthesize warnDetail;
@synthesize incator;
@end






