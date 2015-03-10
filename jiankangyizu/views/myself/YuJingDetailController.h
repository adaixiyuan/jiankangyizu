//
//  YuJingDetailController.h
//  jiankangyizu
//
//  Created by JEREI on 15-2-14.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonUser.h"
@interface YuJingDetailController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSMutableArray *dataArray;
    NSMutableArray *dataArray2;
    UIPickerView *zuigaoPickView;
    UIPickerView *zuidiPickView;
    CommonUser *user;
    NSString *value1;
    NSString *value2;
    NSString *value3;
    NSString *value4;
    CommonUserDAO *dao;
   
}

@property(nonatomic,strong) NSString *viewTitle;
@property(nonatomic,assign) int Flag;
@end
