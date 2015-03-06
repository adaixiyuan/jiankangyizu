//
//  ChatFaceView.h
//  ViewDeckExample
//
//  Created by apple on 13-4-11.
//  Copyright (c) 2013年 Adriaenssen BVBA. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChatFaceViewDelegate <NSObject>

-(void)selectFace:(NSString *)_face;
-(void)disFaceAction;

@end

@interface ChatFaceView : UIViewController{
    UIImageView *faceBg;
    UIView *faceView2;
    UIView *buttonView;
    UIButton *sunny;
    UIButton *others;
    UILabel *sunnyLabel;
    UILabel *othersLabel;
    UIScrollView *faceScroll;
    UIScrollView *faceScroll2;
    id<ChatFaceViewDelegate>delegate;
}
@property(nonatomic,strong)UIImageView *faceBg;
@property(nonatomic,strong)UIView *faceView2;
@property(nonatomic,strong)UIView *buttonView;
@property(nonatomic,strong)UIScrollView *faceScroll;
@property(nonatomic,strong)UIScrollView *faceScroll2;
@property(nonatomic,strong)UILabel *sunnyLabel;
@property(nonatomic,strong)UILabel *othersLabel;
@property(nonatomic,strong)id<ChatFaceViewDelegate>delegate;

@end
