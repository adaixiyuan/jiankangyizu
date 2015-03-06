//
//  SubmitViewCell.m
//  ViewDeckExample
//
//  Created by apple on 13-4-9.
//  Copyright (c) 2013年 Adriaenssen BVBA. All rights reserved.
//

#import "SubmitViewCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation SubmitViewCell
@synthesize title,detail,detail2,state;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIToolbar *keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 38.0f)];
        keyboardToolbar.barStyle = UIBarStyleBlackTranslucent;
        UIBarButtonItem *spaceBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                      target:nil
                                                                                      action:nil];
        
        UIBarButtonItem *doneBarItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"完成", @"")
                                                                        style:UIBarButtonItemStyleDone
                                                                       target:self
                                                                       action:@selector(resignKeyboard)];
        
        [keyboardToolbar setItems:[NSArray arrayWithObjects:spaceBarItem, doneBarItem, nil]];
        state=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 21.5, 22.5)];
        [self.contentView addSubview:state];
        title=[[UILabel alloc]initWithFrame:CGRectMake(40, 2, 85, 39)];
        title.textAlignment=NSTextAlignmentLeft;
        title.backgroundColor=[UIColor clearColor];
        title.textColor=[UIColor darkTextColor];
        title.font=[UIFont systemFontOfSize:16];
        [self.contentView addSubview:title];
        
        detail=[[UITextField alloc]initWithFrame:CGRectMake(125, 12.5, kDeviceWidth-30-125, 18)];
        detail.font=[UIFont systemFontOfSize:16];
        detail.returnKeyType=UIReturnKeyDone;
        detail.contentMode=UIViewContentModeCenter;
        detail.textAlignment=NSTextAlignmentRight;
        detail.inputAccessoryView=keyboardToolbar;
        
        /*
        detail.layer.borderWidth=1;
        [detail.layer setMasksToBounds:YES];
        [detail.layer setCornerRadius:7.0];
        detail.layer.borderColor=[[UIColor colorWithRed:124.0/255.0 green:191.0/255.0 blue:50.0/255.0 alpha:1]CGColor];
         */
        [self.contentView addSubview:detail];
        
        detail2=[[UIPlaceHolderTextView alloc]initWithFrame:CGRectZero];
        detail2.placeHolderLabel.textAlignment=NSTextAlignmentRight;
        detail2.textAlignment=NSTextAlignmentRight;
        detail2.backgroundColor=[UIColor clearColor];
        detail2.placeholderColor=[UIColor grayColor];
        detail2.font=[UIFont systemFontOfSize:16];
        detail2.inputAccessoryView=keyboardToolbar;
        [self.contentView addSubview:detail2];
        
        
        
    }
    return self;
}
-(void)resignKeyboard{
    [detail resignFirstResponder];
    [detail2 resignFirstResponder];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
