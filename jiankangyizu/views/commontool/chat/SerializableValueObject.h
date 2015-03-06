//
//  SerializableValueObject.h
//  ViewDeckExample
//
//  Created by apple on 13-1-18.
//  Copyright (c) 2013年 Adriaenssen BVBA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SerializableValueObject : NSObject{
    int userId;
    int pageSize;
    int pageIndex;
    NSString *keyWord;
    int deviceId;
    int publicAccoubtId;
    NSString *deviceNo;
    double latitude;
    double longitude;
    NSString *address;
    NSDate *lastUpdateDate;
    int redundancy1;//冗余1
    int redundancy2;//冗余2
    int redundancy3;//冗余3
    int redundancy4;//冗余4
    int redundancy5;//冗余5
    double redundancyDouble1;//冗余1
    double redundancyDouble2;//冗余2
    double redundancyDouble3;//冗余3
    double redundancyDouble4;//冗余4
    double redundancyDouble5;//冗余5
    NSString *redundancyStr1;//冗余1
    NSString *redundancyStr2;//冗余1
    NSString *redundancyStr3;//冗余1
    NSString *redundancyStr4;//冗余1
    NSString *redundancyStr5;//冗余1
    NSString *redundancyStr6;//冗余1
    NSString *redundancyByte;
    NSString *serialObject;
    
}
@property(nonatomic,assign)int publicAccoubtId;
@property(nonatomic,assign)int userId;
@property(nonatomic,assign)int pageSize;
@property(nonatomic,assign)int pageIndex;
@property(nonatomic,strong)NSString *keyWord;
@property(nonatomic,assign)int deviceId;
@property(nonatomic,strong)NSString *deviceNo;
@property(nonatomic,assign)double latitude;
@property(nonatomic,assign)double longitude;
@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSDate *lastUpdateDate;
@property(nonatomic,assign)int redundancy1;//冗余1
@property(nonatomic,assign)int redundancy2;//冗余2
@property(nonatomic,assign)int redundancy3;//冗余3
@property(nonatomic,assign)int redundancy4;//冗余4
@property(nonatomic,assign)int redundancy5;//冗余5
@property(nonatomic,assign)double redundancyDouble1;//冗余1
@property(nonatomic,assign)double redundancyDouble2;//冗余2
@property(nonatomic,assign)double redundancyDouble3;//冗余3
@property(nonatomic,assign)double redundancyDouble4;//冗余4
@property(nonatomic,assign)double redundancyDouble5;//冗余5
@property(nonatomic,strong)NSString *redundancyStr1;//冗余1
@property(nonatomic,strong)NSString *redundancyStr2;//冗余1
@property(nonatomic,strong)NSString *redundancyStr3;//冗余1
@property(nonatomic,strong)NSString *redundancyStr4;//冗余1
@property(nonatomic,strong)NSString *redundancyStr5;//冗余1
@property(nonatomic,strong)NSString *redundancyStr6;//冗余1

@property(nonatomic,strong)NSString *redundancyByte;
@property(nonatomic,strong)NSString *serialObject;

@end
