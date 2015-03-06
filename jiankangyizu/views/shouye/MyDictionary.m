
//
//  MyDictionary.m
//  jiankangyizu
//
//  Created by JEREI on 15-2-6.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "MyDictionary.h"

@implementation MyDictionary
@synthesize name;
@synthesize value;
- (MyDictionary *)initWithName:(NSString *)kname Andvale:(NSString *)kvalue
{
  if(self = [super init])
  {
      self.name = kname;
      self.value = kvalue;
  }
    return self;
}
@end
