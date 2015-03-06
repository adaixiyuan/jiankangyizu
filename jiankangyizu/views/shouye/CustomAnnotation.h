//
//  CustomAnnotation.h
//  jiankangyizu
//
//  Created by JEREI on 15-2-26.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface CustomAnnotation : NSObject <MKAnnotation>

@property (nonatomic,assign,readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic,copy,readonly) NSString *title;
@property (nonatomic,copy,readonly) NSString *subtitle;

- (id) initWithCoordinates:(CLLocationCoordinate2D)paramCoordinates
                     title:(NSString *)paramTitle
                  subTitle:(NSString *)paramSubTitle;

@end
