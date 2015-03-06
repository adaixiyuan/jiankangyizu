//
//  GuijijianceController.m
//  jiankangyizu
//
//  Created by JEREI on 15-2-26.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "GuijijianceController.h"
#import "RDVTabBarController.h"
#import "SDImageView+SDWebCache.h"
#import "PMCalendar.h"
#import "CustomAnnotation.h"
#import "JkLocus.h"
#import "CommonStr.h"
@interface GuijijianceController ()
{
   
    int page;
    NSMutableArray *postArray;
}
@end

@implementation GuijijianceController

@synthesize userMessage;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav];
    [self initView];
    page = 1;
    postArray = [[NSMutableArray alloc] init];
}


- (void)initView
{
    self.view.backgroundColor = BACK_COLOR;
    UIView *userMessageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 50)];
//    userMessageView.userInteractionEnabled  = YES;
    userMessageView.backgroundColor = [UIColor whiteColor];
    UIImageView *userHeadImg = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
    UILabel *userName = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, kDeviceWidth/3, 20)];
    UILabel *ageAndSex = [[UILabel alloc] initWithFrame:CGRectMake(50, 30, kDeviceWidth/3, 20)];
    [userHeadImg setImageWithURL:[NSURL URLWithString:userMessage.headImg] refreshCache:NO placeholderImage:[UIImage imageNamed:@"icon.png"]];
    userName.text = userMessage.name;
    if(userMessage.sex == 0)
    {
        ageAndSex.text = [NSString stringWithFormat:@"女/%d岁",userMessage.age];
    }
    else if(userMessage.sex == 1)
    {
       ageAndSex.text = [NSString stringWithFormat:@"男/%d岁",userMessage.age];
    
    }
    UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/3+50, 5, 1, 40)];
    line1.backgroundColor = YINGYONG_COLOR;
    dateBtn = [[UITextField alloc] initWithFrame:CGRectMake(kDeviceWidth/3+51, 5, kDeviceWidth/3, 50)];
    dateBtn.textAlignment = NSTextAlignmentCenter;
        //获取系统当前日期
    NSDate *senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *locationString=[dateformatter stringFromDate:senddate];
    dateBtn.textColor  = YINGYONG_COLOR;
    dateBtn.text = locationString;
    
    datePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 216)];
    datePicker.datePickerMode=UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];
    dateBtn.inputView = datePicker;
    
    UIToolbar * keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 38.0f)];
    keyboardToolbar.barStyle = UIBarStyleBlackTranslucent;
    UIBarButtonItem *spaceBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                  target:nil
                                                                                  action:nil];
    
    UIBarButtonItem *doneBarItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"完成", @"")
                                                                    style:UIBarButtonItemStyleDone
                                                                   target:dateBtn
                                                                   action:@selector(resignFirstResponder)];
    
    [keyboardToolbar setItems:[NSArray arrayWithObjects:spaceBarItem, doneBarItem, nil]];
    dateBtn.inputAccessoryView = keyboardToolbar;

    
    UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake((kDeviceWidth/3)*2+50, 5, 1, 40)];
    line2.backgroundColor = YINGYONG_COLOR;
    
    UIButton *searchBtn = [[UIButton alloc] initWithFrame:CGRectMake((kDeviceWidth/3)*2+51, 5, kDeviceWidth/3-50, 50)];
    [searchBtn setTitleColor:YINGYONG_COLOR forState:UIControlStateNormal];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
     searchBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [searchBtn addTarget:self action:@selector(searchAll) forControlEvents:UIControlEventTouchUpInside];
    [userMessageView addSubview:userHeadImg];
    [userMessageView addSubview:userName];
    [userMessageView addSubview:ageAndSex];
    [userMessageView addSubview:line1];
    [userMessageView addSubview:dateBtn];
    [userMessageView addSubview:line2];
    [userMessageView addSubview:searchBtn];

    [self.view addSubview:userMessageView];
    
    mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 51, kDeviceWidth, KDeviceHeight-51)];
    mapView.delegate = self;
    mapView.mapType = MKMapTypeStandard;
    mapView.showsUserLocation = YES;
    [mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    [self.view addSubview:mapView];
    
    if([CLLocationManager locationServicesEnabled])
    {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        if([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [self.locationManager requestWhenInUseAuthorization];
        }
        [self.locationManager startUpdatingLocation];
    }
    else
    {
        NSLog(@"Location services are not enabled");
    }
    self.myGeocoder = [[CLGeocoder alloc] init];
}
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    if (
        ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)] && status != kCLAuthorizationStatusNotDetermined && status != kCLAuthorizationStatusAuthorizedWhenInUse) ||
        (![self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)] && status != kCLAuthorizationStatusNotDetermined && status != kCLAuthorizationStatusAuthorized)
        ) {
        
        NSString *message = @"您的手机目前未开启定位服务，如欲开启定位服务，请至设定开启定位服务功能";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"无法定位" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        
    }else {
        
        [self.locationManager startUpdatingLocation];
    }
}
-(void)initNav{
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"tb_navbar.png"] forBarMetrics:UIBarMetricsDefault];
    }
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"comm_top_button_left.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame=CGRectMake(0, 0,52, 42);//52, 42
    UILabel *backLabel=[[UILabel alloc]initWithFrame:CGRectMake(52, 0, 300, 42)];
    backLabel.backgroundColor=[UIColor clearColor];
    backLabel.textColor=YINGYONG_COLOR;
    backLabel.textAlignment=NSTextAlignmentLeft;
    backLabel.font=[UIFont boldSystemFontOfSize:23];
    backLabel.text=@" 安全监护";
    UIView *backView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 330, 42)];
    backView1.backgroundColor=[UIColor clearColor];
    [backView1 addSubview:backBtn];
    [backView1 addSubview:backLabel];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backView1];
    self.navigationItem.leftBarButtonItem = backButtonItem;
}
- (void)goback
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)dateChanged:(id)sender{
    UIDatePicker* control = (UIDatePicker*)sender;
    NSDate* _date = control.date;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy-MM-dd";
    NSString *dateString=[df stringFromDate:_date];
    dateBtn.text = dateString;
}
- (void)searchAll
{
    
    [self getLocation];
         
}

#pragma mark 地图加载失败时调用
- (void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error
{
    NSLog(@"error:%@",[error description]);
}

#pragma mark 获取预警人次
-(void)getLocation
{
    //1.确定地址nsurl
    NSString *urlString = [NSString stringWithFormat:@"%@%@?table_name=jk_locus&start_page=%d&page_size=%d&is_page=1&user_id=%d&condition=convert(varchar(10),add_date,120)='%@'",BASE_URL,COMMONINDEX_URL,page,20,userMessage.identity,dateBtn.text];
    
   
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];   //get请求方式
    /*
     同步请求
     */
    @autoreleasepool {
        [postArray removeAllObjects];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSURLResponse *respons = nil;
            NSError *error = nil;
            NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&respons error:&error];
           
            dispatch_async(dispatch_get_main_queue(), ^{
                if(data != nil)
                {
//                    NSString *str=  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                    NSLog(@"str:%@",str);
                    NSArray *objects=[JsonToModel objectsFromDictionaryData:data className:@"JkLocus"];
                    
                    FMDatabaseQueue *queue = [[FMDatabaseQueue alloc]initWithPath:[ZUOYLTempHelper getPathForDocuments:@"asiastarbus.db" inDir:@"db"]];
                    JkLocusDAO* dao = [[JkLocusDAO alloc]initWithDbqueue:queue];
                    @autoreleasepool {
                        [dao replaceArrayToDB:objects callback:^(BOOL block){
                            
                        }];
                    }
                    if ([objects count]>0)
                    {
                        [postArray addObjectsFromArray:objects];
                        for (JkLocus *jklocus in postArray) {
                                                       CLLocationCoordinate2D location =
                            CLLocationCoordinate2DMake([jklocus.latitude doubleValue],[jklocus.longitude doubleValue]);
                            /* Create the annotation using the location */
                            
                            CustomAnnotation *annotation =[[CustomAnnotation alloc] initWithCoordinates:location title:[CommonStr getDetailDateFormLongSince1970:jklocus.addDate] subTitle:jklocus.posAddress];
                            
                            [mapView addAnnotation:annotation];
                        }
                        page++;
                    }
                    else
                    {
                        page = 1;
                        [commonAction showToast:@"未获取到数据" WhithNavigationController:self.navigationController];
                    }
                    
                }
                else if(data == nil && error == nil)
                {
                    NSLog(@"接收到空数据");
                }
                else
                {
                    NSLog(@"%@",error.localizedDescription);
                }
            });});
    }
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapViews viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKAnnotationView *result = nil;
    if([annotation isKindOfClass:[CustomAnnotation class]] == NO)
    {
        return result;
    }
    CustomAnnotation *senderAnnotation = (CustomAnnotation *)annotation;
    NSString *pinResuableIndentifier = @"cn.live@hello";
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pinResuableIndentifier];
  
    if (annotationView == nil){
        /* If we fail to reuse a pin, then we will create one */
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:senderAnnotation reuseIdentifier:pinResuableIndentifier];
        /* Make sure we can see the callouts on top of
         each pin in case we have assigned title and/or
         subtitle to each pin */
        [annotationView setCanShowCallout:YES];
        annotationView.draggable = YES;
        //        annotationView.enabled = YES;
    }
    //自定义图片时，不能用drop
    annotationView.animatesDrop = YES;
//        UIImage *img =  [UIImage imageNamed:@"color_3.png"];
//        annotationView.image = img;
    result = annotationView;
    return result;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}
@end
