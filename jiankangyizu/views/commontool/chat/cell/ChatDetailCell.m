//
//  ChatDetailCell.m
//  ViewDeckExample
//
//  Created by apple on 13-3-19.
//  Copyright (c) 2013年 Adriaenssen BVBA. All rights reserved.
//

#import "ChatDetailCell.h"

@implementation ChatDetailCell
@synthesize bubble;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        bubble=[[BubbleView alloc]initWithFrame:self.contentView.frame];
        bubble.bubbleImageView.frame=CGRectMake(100, 200, 200, 200);
        bubble.fromSelf=YES;
//        bubble.frame=self.contentView.frame;
        [self.contentView addSubview:bubble];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
