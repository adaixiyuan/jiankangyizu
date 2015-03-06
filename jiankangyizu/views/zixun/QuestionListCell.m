//
//  QuestionListCell.m
//  jiankangyizu
//
//  Created by JEREI on 15-2-6.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "QuestionListCell.h"

@implementation QuestionListCell
@synthesize questiontitle;
@synthesize questiondate;
@synthesize huifuNumber;
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
        questiontitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, kDeviceWidth-100, 20)];
        questiondate  = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth-100, 2, 100, 20)];
        huifuNumber = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth-100, 22, 100, 20)];
        huifuNumber.textColor = LIGHTBLUECOLOR;
        [self.contentView addSubview:questiondate];
        [self.contentView addSubview:questiontitle];
        [self.contentView addSubview:huifuNumber];
    }
    return self;
}
@end
