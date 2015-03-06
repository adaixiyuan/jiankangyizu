//
//  FormDetailCell.m
//  jiankangyizu
//
//  Created by JEREI on 15-2-6.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "FormDetailCell.h"
@interface FormDetailCell()
@property (strong,nonatomic) UILabel *Lname;
@property (strong,nonatomic) UILabel *Lvalue;
@end
@implementation FormDetailCell
@synthesize lablename;
@synthesize lablevalue;
- (void)awakeFromNib {
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
       [self setSelectionStyle:UITableViewCellSelectionStyleNone]; 
         lablename = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 110, 20)];
         lablevalue = [[UILabel alloc] initWithFrame:CGRectMake(120, 15, kDeviceWidth-130, 20)];
        lablevalue.textAlignment = NSTextAlignmentRight;
       
        [self.contentView addSubview:lablename];
        [self.contentView addSubview:lablevalue];
    }
    return self;

}

@end
