//
//  RecordHUD.h
//  ViewDeckExample
//
//  Created by apple on 13-2-21.
//  Copyright (c) 2013年 Adriaenssen BVBA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordHUD2 : UIViewController{
    UIImageView *voice;
    UILabel *seconds;
    NSTimer*  _timer;
    int num;
}
@property(nonatomic,strong)UIImageView *voice;
@property(nonatomic,strong)UILabel *seconds;

-(void)startVoice;
-(void)stopVoice;

@end
