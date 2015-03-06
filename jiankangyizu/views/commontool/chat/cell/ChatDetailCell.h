//
//  ChatDetailCell.h
//  ViewDeckExample
//
//  Created by apple on 13-3-19.
//  Copyright (c) 2013年 Adriaenssen BVBA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BubbleView.h"

@interface ChatDetailCell : UITableViewCell{
    BubbleView *bubble;
}
@property(nonatomic,strong)BubbleView *bubble;

@end
