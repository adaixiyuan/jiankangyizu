//
//  SubmitViewCell.h
//  ViewDeckExample
//
//  Created by apple on 13-4-9.
//  Copyright (c) 2013年 Adriaenssen BVBA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPlaceHolderTextView.h"

@interface SubmitViewCell : UITableViewCell{
    UILabel *title;
    UITextField *detail;
    UIPlaceHolderTextView *detail2;
    UIImageView *state;
    
}
@property(nonatomic,strong)UILabel *title;
@property(nonatomic,strong)UITextField *detail;
@property(nonatomic,strong)UIPlaceHolderTextView *detail2;
@property(nonatomic,strong)UIImageView *state;

@end
