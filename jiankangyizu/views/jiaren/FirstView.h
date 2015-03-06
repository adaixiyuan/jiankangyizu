//
//  jiaRenView.h
//  jiankangyizu
//
//  Created by apple on 15/2/2.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKWarnNumber.h"
#import "WarnNumberDeailViewController.h"


@interface FirstView : UIViewController
{
    UILabel *jiancerenci;
    UIButton *xueyabtn;
    UIButton *erwenbtn;
    UIButton *xuetangbtn;
    UIButton *jiancebtn;
    JKWarnNumber *jkWarnNumber ;
    WarnNumberDeailViewController *WarnController;
    NSString *warnTableName;
    NSString *warnTitle;
    int warnhealflag;
    UILabel *cityAndWeather;
    UILabel *dateAndWeather;
  
}

@end
