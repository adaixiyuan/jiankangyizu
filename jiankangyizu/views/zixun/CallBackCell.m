//
//  CallBackCell.m
//  jiankangyizu
//
//  Created by JEREI on 15-2-7.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "CallBackCell.h"
#import "CommonStr.h"
@implementation CallBackCell

@synthesize callbackContent;
@synthesize userHeadImg;
@synthesize userNameAndcallbackdate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        userHeadImg = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
        userNameAndcallbackdate = [[UILabel alloc] initWithFrame:CGRectMake(5, 50, kDeviceWidth-100, 40)];
        callbackContent = [[UILabel alloc] initWithFrame:CGRectZero];
        callbackContent.numberOfLines = 0;
        [self.contentView addSubview:userHeadImg];
        [self.contentView addSubview:userNameAndcallbackdate];
        [self.contentView addSubview:callbackContent];
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
