//
//  CheckImage.m
//  ViewDeckExample
//
//  Created by apple on 13-2-25.
//  Copyright (c) 2013年 Adriaenssen BVBA. All rights reserved.
//

#import "CheckImage.h"

@implementation CheckImage
@synthesize image,image2;

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
    self.view.backgroundColor=[UIColor blackColor];
    
    image=[[UIImageView alloc]initWithImage:image2];
    image.contentMode=UIViewContentModeScaleAspectFit;
    image.frame=CGRectMake(0, 0, kDeviceWidth, [[UIScreen mainScreen] bounds].size.height-20);
    [self.view addSubview:image];
    
    UIButton *back=[UIButton buttonWithType:UIButtonTypeCustom];
    back.frame=CGRectMake(0, 0, kDeviceWidth, [[UIScreen mainScreen] bounds].size.height);
    [back addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
}

-(void)backAction{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



@end
