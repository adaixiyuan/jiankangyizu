//
//  ClearCacheAlert.h
//  ViewDeckExample
//
//  Created by apple on 13-4-1.
//  Copyright (c) 2013年 Adriaenssen BVBA. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClearCacheAlertDelegate <NSObject>

-(void)clearCacheYes;
-(void)clearCacheNo;

@end

@interface ClearCacheAlert : UIViewController{
    UILabel *intro;
    UIButton *yes;
    UIButton *no;
    id<ClearCacheAlertDelegate>delegate;
}
@property(nonatomic,strong)UILabel *intro;
@property(nonatomic,strong)UIButton *yes;
@property(nonatomic,strong)UIButton *no;
@property(nonatomic,strong)id<ClearCacheAlertDelegate>delegate;

-(void)showToast:(NSString *)contents;

@end
