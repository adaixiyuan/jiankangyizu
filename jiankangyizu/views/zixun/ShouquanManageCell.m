//
//  ShouquanManageCell.m
//  jiankangyizu
//
//  Created by JEREI on 15-2-15.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "ShouquanManageCell.h"

@implementation ShouquanManageCell
@synthesize  userHeadImg;
@synthesize  userName;
@synthesize  linkPhone;
@synthesize  indicator;
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
        userHeadImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
        userName = [[UILabel alloc] initWithFrame:CGRectMake(80, 15, kDeviceWidth-30, 20)];
        userName.font = [UIFont boldSystemFontOfSize:18.0];
        linkPhone = [[UILabel alloc] initWithFrame:CGRectMake(80, 40, kDeviceWidth-30, 20)];
        indicator = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth-30, 26, 24, 24)];
        indicator.image = [UIImage imageNamed:@"bus_img_clickright.png"];
        
        [self.contentView addSubview:userHeadImg];
        [self.contentView addSubview:userName];
        [self.contentView addSubview:linkPhone];
        [self.contentView addSubview:indicator];
    }
    return self;
}
@end
