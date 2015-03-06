
//
//  UerManageListViewCell.m
//  jiankangyizu
//
//  Created by JEREI on 15-2-5.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "UerManageListViewCell.h"

@implementation UerManageListViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
   [super setSelected:selected animated:animated];
    }



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
       
        userHeadImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 70, 60)];
        userHeadImg.contentMode= UIViewContentModeScaleAspectFit;
        userName = [[UILabel alloc] initWithFrame:CGRectMake(85, 15, 120, 20)];
        sexAndage = [[UILabel alloc] initWithFrame:CGRectMake(85, 50, 50, 20)];
        warnDetail = [[UIButton alloc] initWithFrame:CGRectMake(140, 50, 50, 20)];
        [warnDetail setBackgroundImage:[UIImage imageNamed:@"warning_noty_bg.png"] forState:UIControlStateNormal];
        [warnDetail setUserInteractionEnabled:NO];
        warnDetail.titleLabel.font = [UIFont systemFontOfSize:12.0];
        incator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"comm_salout_more_unpress.png"]];
        incator.frame = CGRectMake(kDeviceWidth-60, 25, 18, 14);
        
        
        UILabel *linelable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 1)];
        linelable.backgroundColor = [UIColor lightGrayColor];
        
        sublable = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, kDeviceWidth, 44)];
        sublable.backgroundColor = [UIColor clearColor];
        
        jiankanjianhubtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [jiankanjianhubtn.layer setMasksToBounds:YES];
        [jiankanjianhubtn.layer setCornerRadius:5.0];
        jiankanjianhubtn.frame = CGRectMake(10, 10, 90, 30);
        [jiankanjianhubtn setTitle:@"健康监护" forState:UIControlStateNormal];
        [jiankanjianhubtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [jiankanjianhubtn setBackgroundColor:QIANLANCOLOR];
        
        guijijiancebtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [guijijiancebtn.layer setMasksToBounds:YES];
        [guijijiancebtn.layer setCornerRadius:5.0];
        guijijiancebtn.frame = CGRectMake(kDeviceWidth/3+5, 10, 90, 30);
        [guijijiancebtn setTitle:@"安全监护" forState:UIControlStateNormal];
        [guijijiancebtn setBackgroundColor:SHENLUCOLOR];
        [guijijiancebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        yonghuxinxibth = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [yonghuxinxibth.layer setMasksToBounds:YES];
        [yonghuxinxibth.layer setCornerRadius:5.0];
        yonghuxinxibth.frame = CGRectMake(kDeviceWidth/3*2+5, 10, 90, 30);
        [yonghuxinxibth setTitle:@"用户信息" forState:UIControlStateNormal];
        [yonghuxinxibth setBackgroundColor:QIANLUCOLOR];
        [yonghuxinxibth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        itemlable = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 80)];
        [sublable addSubview:jiankanjianhubtn];
        [sublable addSubview:guijijiancebtn];
        [sublable addSubview:yonghuxinxibth];
        [sublable addSubview:linelable];
        [sublable setHidden:YES];
        
        [itemlable addSubview:userHeadImg];
        [itemlable addSubview:userName];
        [itemlable addSubview:sexAndage];
        [itemlable addSubview:warnDetail];
        [itemlable addSubview:incator];
        
        [self.contentView addSubview:sublable];
        [self.contentView addSubview:itemlable];
        
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
@synthesize itemlable;
@synthesize sublable;
@synthesize jiankanjianhubtn;
@synthesize guijijiancebtn;
@synthesize yonghuxinxibth;



@end
