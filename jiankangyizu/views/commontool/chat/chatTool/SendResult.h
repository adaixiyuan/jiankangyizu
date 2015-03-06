//
//  SendResult.h
//  ViewDeckExample
//
//  Created by apple on 13-2-27.
//  Copyright (c) 2013年 Adriaenssen BVBA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SendResult : NSObject{
    NSString *resultCode;
    NSString *resultMessage;
    NSDate *lastDate;
}
@property(nonatomic,strong)NSString *resultCode;
@property(nonatomic,strong)NSString *resultMessage;
@property(nonatomic,strong)NSDate *lastDate;

@end
