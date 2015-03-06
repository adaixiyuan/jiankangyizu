//
//  GuijijianceController.h
//  jiankangyizu
//
//  Created by JEREI on 15-2-26.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JkUserManage.h"
#import "PMCalendar.h"
#import <MapKit/MapKit.h>
@interface GuijijianceController : UIViewController <PMCalendarControllerDelegate,MKMapViewDelegate,CLLocationManagerDelegate>
{
    UIDatePicker *datePicker;
    MKMapView *mapView;
    PMCalendarController *datacontroller;
    int flag  ;
    UITextField *dateBtn;
}
@property (nonatomic,strong) JkUserManage *userMessage;
@property (nonatomic,retain) CLLocationManager *locationManager;
@property (nonatomic,retain) CLLocation *location;
@property (nonatomic,retain) CLGeocoder *myGeocoder;
@end
