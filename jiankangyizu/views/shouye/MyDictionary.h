//
//  MyDictionary.h
//  jiankangyizu
//
//  Created by JEREI on 15-2-6.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyDictionary : NSObject
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *value;

- (MyDictionary *)initWithName:(NSString *)kname Andvale:(NSString *)kvalue;
@end
