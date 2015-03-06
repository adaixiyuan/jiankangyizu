//
//  JianKangJianHuDetailView.h
//  jiankangyizu
//
//  Created by JEREI on 15-2-13.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZUOYLDAOBase.h"
#import "JkBp.h"
#import "JkEar.h"
#import "JkGlu.h"
#import "JkEcg.h"
#import "JkOximeter.h"
#import "JkBong.h"
@interface JianKangJianHuDetailView : UIViewController
{
    JkBp *jkbp;
    JkEar *jkEar;
    JkGlu *jkGlu;
    JkEcg *jkEcg;
    JkOximeter *jkOximeter;
    JkBong *jkBong;

}
@property(nonatomic,assign) int DetailFlag;
@property(nonatomic,strong) ZUOYLModelBase *modeObject;
@end
