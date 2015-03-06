//
//  BubbleView.h
//  ViewDeckExample
//
//  Created by apple on 13-2-25.
//  Copyright (c) 2013年 Adriaenssen BVBA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatLabel3.h"

@interface BubbleView : UIView{
    BOOL fromSelf;
    //UIImageView *bubbleImageView;//气泡背景
    UIButton *bubbleImageView;//气泡背景
    UIImageView *noFaceImage;
    UIImageView *iconImgView;//头像
    
    ChatLabel3 *bubbleText;//文字
    UIImageView *contentImage;//图片
    
    UIImageView *timeBg;//时间背景
//    UILabel *time;//时间
    
    UIImageView *state;//状态
    UIActivityIndicatorView *activityView;
    
    UIImageView *noRead;//未读提示
    
    BOOL isSuccess;
    
    UIImageView *voiceImage;
    UIImageView *playImage;
    
    int num;
    NSTimer*  _timer;
    
    UILabel *title;
    UILabel *check;
}
@property(nonatomic,assign)BOOL fromSelf;
//@property(nonatomic,strong)UIImageView *bubbleImageView;//气泡背景
@property(nonatomic,strong)UIButton *bubbleImageView;//气泡背景
@property(nonatomic,strong)UIImageView *noFaceImage;
@property(nonatomic,strong)UIImageView *iconImgView;//头像

@property(nonatomic,strong)ChatLabel3 *bubbleText;
@property(nonatomic,strong)UIImageView *contentImage;

@property(nonatomic,strong)UIImageView *timeBg;
@property(nonatomic,strong)UILabel *time;

@property(nonatomic,strong)UIImageView *state;
@property(nonatomic,strong)UIActivityIndicatorView *activityView;

@property(nonatomic,strong)UIImageView *noRead;

@property(nonatomic,assign)BOOL isSuccess;

@property(nonatomic,strong)UIImageView *voiceImage;
@property(nonatomic,strong)UIImageView *playImage;

@property(nonatomic,assign)int num;

@property(nonatomic,strong)UILabel *title;
@property(nonatomic,strong)UILabel *check;

-(void)createView;
-(void)createNewsView;
-(void)repeatAnimation2;

@end
