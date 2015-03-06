//
//  JiankangJIanHuCell.m
//  jiankangyizu
//
//  Created by JEREI on 15-2-12.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "JiankangJIanHuCell.h"

@implementation JiankangJIanHuCell

@synthesize zhibiaolable;
@synthesize zhibiaoimg;
@synthesize shutiao;
@synthesize celiangtime;
@synthesize celiangaddress;
@synthesize yujing;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        
        zhibiaolable = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 60, 44)];
        zhibiaolable.textColor = YINGYONG_COLOR;
        zhibiaolable.font = [UIFont boldSystemFontOfSize:15];
        
        zhibiaoimg = [[UIImageView alloc] initWithFrame:CGRectMake(75, 5, 33, 33)];
        
        shutiao = [[UIImageView alloc] initWithFrame:CGRectMake(91.5, 0, 1, 60)];
        shutiao.image = [UIImage imageNamed:@"comm_usercenter_horizon_bg.png"];
        celiangtime = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/2, 5, 100, 20)];
        celiangtime.font = [UIFont systemFontOfSize:12.0];
        celiangaddress = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/2, 25, kDeviceWidth-50, 20)];
        celiangaddress.font = [UIFont systemFontOfSize:12.0];
        yujing = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth-50, 5, 40, 20)];
        [yujing setBackgroundImage:[UIImage imageNamed:@"warning_noty_bg.png"] forState:UIControlStateNormal];
        [yujing setTitle:@"预警" forState:UIControlStateNormal];
        yujing.titleLabel.font = [UIFont systemFontOfSize:12.0];
      
        [self.contentView addSubview:shutiao];
        [self.contentView addSubview:zhibiaoimg];
        [self.contentView addSubview:celiangtime];
        [self.contentView addSubview:celiangaddress];
        [self.contentView addSubview:yujing];
        [self.contentView addSubview:zhibiaolable];
        
    
    }
    
    return self;
}
@end
