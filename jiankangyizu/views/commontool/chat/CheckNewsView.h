//
//  CheckNewsView.h
//  ViewDeckExample
//
//  Created by apple on 13-4-7.
//  Copyright (c) 2013年 Adriaenssen BVBA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckNewsView : UIViewController<UIWebViewDelegate,UIGestureRecognizerDelegate>{
    UIWebView *detailView;
    NSString *urlStr;
}
@property(nonatomic,strong)UIWebView *detailView;
@property(nonatomic,strong)NSString *urlStr;

-(void)showToast:(NSString *)contents;

@end
