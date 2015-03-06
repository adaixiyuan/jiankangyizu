//
//  JKWarnNumber.h
//  jiankangyizu
//
//  Created by JEREI on 15-2-3.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "ZUOYLDAOBase.h"

@interface JKWarnNumber : ZUOYLDAOBase
{
    int bpCount;
    int earCount;
    int gluCount;
}
@property(nonatomic,assign) int bpCount;
@property(nonatomic,assign) int earCount;
@property(nonatomic,assign) int gluCount;
@end
