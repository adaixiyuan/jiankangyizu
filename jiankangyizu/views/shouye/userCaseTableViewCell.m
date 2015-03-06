
//
//  userCaseTableViewCell.m
//  jiankangyizu
//
//  Created by JEREI on 15-2-5.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "userCaseTableViewCell.h"

@implementation userCaseTableViewCell
@synthesize caseDate;
@synthesize CaseDetail;
@synthesize indicator;
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        CaseDetail = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kDeviceWidth-100, 20)];
        caseDate = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth-115, 10, 100, 20)];
        indicator = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth-20, 10, 20, 20)];
        indicator.image = [UIImage imageNamed:@"bus_img_clickright.png"];
        
        [self addSubview:caseDate];
        [self addSubview:CaseDetail];
        [self addSubview:indicator];
        
    }
    return self;
}

@end
