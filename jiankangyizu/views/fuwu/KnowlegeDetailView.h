//
//  KnowlegeDetailView.h
//  jiankangyizu
//
//  Created by JEREI on 15-2-11.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JkNews.h"
@interface KnowlegeDetailView : UIViewController <UIScrollViewDelegate>
{
    JkNews *jknews;
}
@property(nonatomic,strong)JkNews *jknews;
@end
