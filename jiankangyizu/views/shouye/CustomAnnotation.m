//
//  CustomAnnotation.m
//  jiankangyizu
//
//  Created by JEREI on 15-2-26.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "CustomAnnotation.h"

@implementation CustomAnnotation
- (id) initWithCoordinates:(CLLocationCoordinate2D)paramCoordinates
                     title:(NSString *)paramTitle
                  subTitle:(NSString *)paramSubTitle
{
    if (self = [super init]) {
        _coordinate = paramCoordinates;
        _title = [paramTitle copy];
        _subtitle = [paramSubTitle copy];
    }
    
    return self;
    
}
@end
