//
//  RecordHUD.m
//  ViewDeckExample
//
//  Created by apple on 13-2-21.
//  Copyright (c) 2013年 Adriaenssen BVBA. All rights reserved.
//

#import "RecordHUD2.h"
#import <QuartzCore/QuartzCore.h>

@implementation RecordHUD2
@synthesize seconds,voice;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor clearColor];
    UIView *bg1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight)];
    bg1.backgroundColor=[UIColor blackColor];
    bg1.alpha=0.5;
    [self.view addSubview:bg1];
    UIView *bg=[[UIView alloc]initWithFrame:CGRectMake((kDeviceWidth-170)/2, (KDeviceHeight-160)/2, 170, 160)];
    bg.backgroundColor=[UIColor blackColor];
    bg.alpha=0.5;
    [bg.layer setMasksToBounds:YES];
    [bg.layer setCornerRadius:3.0];
    [self.view addSubview:bg];
    seconds=[[UILabel alloc]initWithFrame:CGRectMake((kDeviceWidth-170)/2, (KDeviceHeight-160)/2+5, 160, 20)];
    seconds.backgroundColor=[UIColor clearColor];
    seconds.font=[UIFont systemFontOfSize:14];
    seconds.text=@"";
    seconds.textAlignment=NSTextAlignmentRight;
    seconds.textColor=[UIColor whiteColor];
    [self.view addSubview:seconds];
    voice=[[UIImageView alloc]initWithFrame:CGRectMake((kDeviceWidth-75)/2, (KDeviceHeight-160)/2+15, 75, 114)];
    voice.contentMode=UIViewContentModeBottom;
    UIImage *img1=[UIImage imageNamed:@"record_animate_1.png"];
    UIImage *img2=[UIImage imageNamed:@"record_animate_2.png"];
    UIImage *img3=[UIImage imageNamed:@"record_animate_3.png"];
    UIImage *img4=[UIImage imageNamed:@"record_animate_4.png"];
    UIImage *img5=[UIImage imageNamed:@"record_animate_5.png"];
    UIImage *img6=[UIImage imageNamed:@"record_animate_6.png"];
    UIImage *img7=[UIImage imageNamed:@"record_animate_7.png"];
    UIImage *img8=[UIImage imageNamed:@"record_animate_8.png"];
    UIImage *img9=[UIImage imageNamed:@"record_animate_9.png"];
    UIImage *img10=[UIImage imageNamed:@"record_animate_10.png"];
    UIImage *img11=[UIImage imageNamed:@"record_animate_11.png"];
    UIImage *img12=[UIImage imageNamed:@"record_animate_12.png"];
    UIImage *img13=[UIImage imageNamed:@"record_animate_13.png"];
    UIImage *img14=[UIImage imageNamed:@"record_animate_14.png"];
    voice.animationImages = [NSArray arrayWithObjects:img1,img2,img3,img4,img5,img6,img7,img8,img9,img10,img11,img12,img13,img14, nil];  
    voice.animationDuration = 2;  
    [voice startAnimating]; 
    [self.view addSubview:voice];
    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake((kDeviceWidth-150)/2, (kDeviceWidth-170)/2+129, 150, 20)];
    title.text=@"正在录音";
    title.backgroundColor=[UIColor clearColor];
    title.font=[UIFont boldSystemFontOfSize:14];
    title.textAlignment=NSTextAlignmentCenter;
    title.textColor=[UIColor whiteColor];
    [self.view addSubview:title];
}

-(void)startVoice{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                              target:self
                                            selector:@selector(repeatAnimation)
                                            userInfo:nil
                                             repeats:YES];
    seconds.text=@"";
}

-(void)stopVoice{
    num=0;
    if (_timer)
    {
        [_timer invalidate];
        _timer = nil;
    }
    
}

-(void)repeatAnimation{
    num++;
    seconds.text=[NSString stringWithFormat:@"%d's",num];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



@end
