//
//  EcgDetailController.m
//  jiankangyizu
//
//  Created by JEREI on 15-2-26.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "EcgDetailController.h"
#import "RDVTabBarController.h"
#import "HeartLive.h"
@interface EcgDetailController ()

{
    NSTimer *timer;
}
@property (nonatomic , strong) NSArray *dataSource;
@property (nonatomic , strong) HeartLive *refreshMoniterView;
@property (nonatomic , strong) HeartLive *translationMoniterView;

@end

@implementation EcgDetailController

@synthesize jkecg;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav];
    self.edgesForExtendedLayout = UIRectEdgeNone;
   
    
   
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
//    // 状态栏动画持续时间
//    CGFloat duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
//    // 基础动画
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:duration];
//    // 修改状态栏的方向及view的方向进而强制旋转屏幕
//    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
//    self.navigationController.view.transform = CGAffineTransformIdentity;
//    self.navigationController.view.transform = CGAffineTransformMakeRotation(M_PI / 2);
//    self.navigationController.view.bounds = CGRectMake(self.navigationController.view.bounds.origin.x, self.navigationController.view.bounds.origin.y, KDeviceHeight+44, kDeviceWidth+44);
//    
//    [UIView commitAnimations];
   
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    void (^createData)(void) = ^{
        NSString *tempString = jkecg.data;
        tempString = [tempString substringWithRange:NSMakeRange(1, tempString.length-2)];
        
        NSMutableArray *tempData = [[tempString componentsSeparatedByString:@","] mutableCopy];
        
        [tempData enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSNumber *tempDataa = @(-[obj integerValue] + 2048);
            [tempData replaceObjectAtIndex:idx withObject:tempDataa];
        }];
         self.dataSource = tempData;
        [self createWorkDataSourceWithTimeInterval:0.01];
        
    };
      createData();
     [self.view addSubview:self.refreshMoniterView];
    
    UILabel *detaillable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KDeviceHeight, 20)];
    detaillable.textColor = [UIColor whiteColor];
    detaillable.textAlignment = NSTextAlignmentCenter;
    detaillable.text = self.jkecg.catResult;
    [self.view addSubview:detaillable];
    
}

- (HeartLive *)refreshMoniterView
{
    if (!_refreshMoniterView) {
        CGFloat xOffset = 10;
        _refreshMoniterView = [[HeartLive alloc] initWithFrame:CGRectMake(xOffset, 20, CGRectGetWidth(self.view.frame) - 2 * xOffset, 200)];
        _refreshMoniterView.backgroundColor = [UIColor blackColor];
    }
    return _refreshMoniterView;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    // 状态栏动画持续时间
//    CGFloat duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
//    // 基础动画
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:duration];
//    // 修改状态栏的方向及view的方向进而强制旋转屏幕
//    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
//    self.navigationController.view.transform = CGAffineTransformIdentity;
//    self.navigationController.view.transform = CGAffineTransformMakeRotation(M_PI / 2);
//    self.navigationController.view.bounds = CGRectMake(self.navigationController.view.bounds.origin.y, self.navigationController.view.bounds.origin.x, kDeviceWidth, KDeviceHeight);
//    self.navigationController.view.frame = CGRectMake(0, 0, kDeviceWidth, KDeviceHeight);
    

    [super viewWillDisappear:animated];
    [timer invalidate];
    
}
- (void)createWorkDataSourceWithTimeInterval:(NSTimeInterval )timeInterval
{
       timer  =  [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(timerRefresnFun) userInfo:nil repeats:YES];

}

//刷新方式绘制
- (void)timerRefresnFun
{
    [[PointContainer sharedContainer] addPointAsRefreshChangeform:[self bubbleRefreshPoint]];
    
   
    [self.refreshMoniterView fireDrawingWithPoints:[PointContainer sharedContainer].refreshPointContainer pointsCount:[PointContainer sharedContainer].numberOfRefreshElements];
}

- (CGPoint)bubbleRefreshPoint
{
    static NSInteger dataSourceCounterIndex = -1;
    dataSourceCounterIndex ++;
    dataSourceCounterIndex %= [self.dataSource count];
    
    
    NSInteger pixelPerPoint = 1;
    static NSInteger xCoordinateInMoniter = 0;
    
    CGPoint targetPointToAdd = (CGPoint){xCoordinateInMoniter,[self.dataSource[dataSourceCounterIndex] integerValue] * 0.5 + 120};
    xCoordinateInMoniter += pixelPerPoint;
    xCoordinateInMoniter %= (int)(CGRectGetWidth(self.refreshMoniterView.frame));
    
    //    NSLog(@"吐出来的点:%@",NSStringFromCGPoint(targetPointToAdd));
    return targetPointToAdd;
}

-(void)initNav{
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"tb_navbar.png"] forBarMetrics:UIBarMetricsDefault];
    }
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"comm_top_button_left.png"] forState:UIControlStateNormal];
    backBtn.frame=CGRectMake(0, 0,52, 42);//52, 42
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    UILabel *backLabel=[[UILabel alloc]initWithFrame:CGRectMake(52, 0, 300, 42)];
    backLabel.backgroundColor=[UIColor clearColor];
    backLabel.textColor=YINGYONG_COLOR;
    backLabel.textAlignment=NSTextAlignmentLeft;
    backLabel.font=[UIFont boldSystemFontOfSize:23];
    backLabel.text=@"心电详细";
    UIView *backView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 330, 42)];
    backView1.backgroundColor=[UIColor clearColor];
    [backView1 addSubview:backBtn];
    [backView1 addSubview:backLabel];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backView1];
    self.navigationItem.leftBarButtonItem = backButtonItem;
}

- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return   UIInterfaceOrientationMaskLandscapeLeft;
}

- (NSUInteger)supportedInterfaceOrientations
{
        return UIInterfaceOrientationMaskLandscapeLeft;
//    return UIInterfaceOrientationMaskLandscapeRight;
}
@end
