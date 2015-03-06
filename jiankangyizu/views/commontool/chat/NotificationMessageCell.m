//
//  NotificationMessageCell.m
//  ViewDeckExample
//
//  Created by apple on 13-11-14.
//  Copyright (c) 2013年 Adriaenssen BVBA. All rights reserved.
//

#import "NotificationMessageCell.h"
#import "SDImageView+SDWebCache.h"
@implementation NotificationMessageCell
@synthesize num;
@synthesize notificationTable;
@synthesize ads;
@synthesize imageViewa;
@synthesize label;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        imageViewa=[[UIImageView alloc]initWithFrame:CGRectMake((kDeviceWidth-288)/2, 5, 288, 140)];
        //        setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_IP,pic.imgSmall]]refreshCache:NO placeholderImage:[UIImage imageNamed:@"default_160x200.png"]
        //        [imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",ads.cover]] placeholderImage:[UIImage imageNamed:@"default_320x150.png"]];
        [imageViewa setImageWithURL:[NSURL URLWithString:ads.cover] refreshCache:NO placeholderImage:[UIImage imageNamed:@"defaultImage_102x70.png"]];
        [self.contentView addSubview:imageViewa];
        label=[[UILabel alloc]initWithFrame:CGRectMake((kDeviceWidth-290)/2, 125, 290, 20)];
        label.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        label.text=ads.title;
        label.textAlignment=NSTextAlignmentLeft;
        label.textColor=[UIColor whiteColor];
        label.font=[UIFont systemFontOfSize:14];
        [self.contentView addSubview:label];
        
        // Initialization code
//        notificationTable=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, (num-1)*50+145) style:UITableViewStyleGrouped];
//        notificationTable.delegate=self;
//        notificationTable.dataSource=self;
//        notificationTable.scrollEnabled=NO;
//        [self.contentView addSubview:notificationTable];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
