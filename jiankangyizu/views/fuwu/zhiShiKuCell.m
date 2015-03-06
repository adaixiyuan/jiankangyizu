//
//  zhiShiKuCell.m
//  jiankangyizu
//
//  Created by apple on 15/2/8.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "zhiShiKuCell.h"

@implementation zhiShiKuCell
@synthesize touxiangImage;
@synthesize titleLabel;
@synthesize otherXinxilabel;
@synthesize zhanghaoLabel;
@synthesize typeLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        touxiangImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 14, 56, 56)];
        
        [self.contentView addSubview:touxiangImage];
        typeLabel = [[UIButton alloc]init];
        typeLabel.frame = CGRectMake(70, 14, 70, 20);
        [typeLabel setTitleColor:YINGYONG_COLOR forState:UIControlStateNormal];
        typeLabel.titleLabel.font =[UIFont systemFontOfSize:12] ;
        [typeLabel setBackgroundImage:[[UIImage imageNamed:@"button_blue_kuang.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:5] forState:UIControlStateNormal];
        [self.contentView addSubview:typeLabel];
        titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(140, 14, kDeviceWidth-80-70, 20)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:14];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:titleLabel];
        otherXinxilabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 34, kDeviceWidth-80, 16)];
        otherXinxilabel.backgroundColor = [UIColor clearColor];
        otherXinxilabel.textColor = [UIColor darkGrayColor];
        otherXinxilabel.font = [UIFont systemFontOfSize:12];
        
        
        otherXinxilabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:otherXinxilabel];
        zhanghaoLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 50, kDeviceWidth-80, 16)];
        zhanghaoLabel.backgroundColor = [UIColor clearColor];
        zhanghaoLabel.textColor = [UIColor darkGrayColor];
        zhanghaoLabel.font = [UIFont systemFontOfSize:10];
        //        zhanghaoLabel.text = [NSString stringWithFormat:@"账号 %@",user.usern];
        zhanghaoLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:zhanghaoLabel];
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
