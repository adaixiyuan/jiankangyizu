//
//  YuJingDetailController.m
//  jiankangyizu
//
//  Created by JEREI on 15-2-14.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "YuJingDetailController.h"
#import "RDVTabBarController.h"
@interface YuJingDetailController ()
#define XUEYAYUJING 1
#define XUETANGYUJING 2
#define ERWENYUJING 3
@end

@implementation YuJingDetailController
@synthesize viewTitle;
@synthesize Flag;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav];
    NSData *userData=[[NSUserDefaults standardUserDefaults]objectForKey:@"user"];
    user= [NSKeyedUnarchiver unarchiveObjectWithData:userData];
//    FMDatabaseQueue *queue = [[FMDatabaseQueue alloc]initWithPath:[ZUOYLTempHelper getPathForDocuments:@"asiastarbus.db" inDir:@"db"]];
//    dao = [[CommonUserDAO alloc]initWithDbqueue:queue];
//    [dao searchWhere:[NSString stringWithFormat:@"identity=%d",user.identity] callback:^(NSArray *array) {
//        user = array[0];
//    }];
//    @property(nonatomic,assign)int pcpMax;//高压最高
//    @property(nonatomic,assign)int pcpMin;//高压最低
//    @property(nonatomic,assign)int pdpMax;//低压最高
//    @property(nonatomic,assign)int pdpMin;//低压最高
//    @property(nonatomic,assign)double gluMax;//血糖最高
//    @property(nonatomic,assign)double gluMin;//血糖最低
//    @property(nonatomic,assign)double earMax;//耳温最高
//    @property(nonatomic,assign)double earMin;//耳温最低

    dataArray = [[NSMutableArray alloc] init];
   
    switch (Flag) {
        case XUEYAYUJING:
        {
            int i;
            for(i = 0; i < 1000; i++)
            {
                dataArray[i] = [NSString stringWithFormat:@"%d",i+1];
                
            }
//      if(user.pcpMax > 0 && user.pcpMin > 0 && user.pdpMax > 0 && user.pdpMin > 0)
//         {
//             value1 = [NSString stringWithFormat:@"%d",user.pcpMax];
//             value2 = [NSString stringWithFormat:@"%d",user.pcpMin];
//             value3 = [NSString stringWithFormat:@"%d",user.pdpMax];
//             value4 = [NSString stringWithFormat:@"%d",user.pdpMin];
//         }
//      else{
            value1 = @"139";
            value2 = @"90";
            value3 = @"89";
            value4 = @"60";
//      }
            [self initViewByBp];
        }
            break;
            
        case XUETANGYUJING:
        {
            int i;
            for(i = 0; i < 101; i++)
            {
                dataArray[i] = [NSString stringWithFormat:@"%d",i+1];
                
            }
//            if(user.gluMax > 0 && user.gluMin > 0)
//            {
//                value1 = [self getIntValue:user.gluMax];
//                value2 = [self getAfterpointValue:user.gluMax];
//                value3 = [self getIntValue:user.gluMin];
//                value4 = [self getAfterpointValue:user.gluMin];
//            }else
//            {
            value1 = @"6";
            value2 = @"1";
            value3 = @"3";
            value4 = @"9";
//            }
            [self initViewByEarAndGlu];
            
        }
            break;
        case ERWENYUJING:
        {
            int i;
            for(i = 0; i < 101; i++)
            {
                dataArray[i] = [NSString stringWithFormat:@"%d",i+1];
                
            }
//            if(user.earMax > 0 && user.earMin > 0)
//            {
//                value1 = [self getIntValue:user.earMax];
//                value2 = [self getAfterpointValue:user.earMax];
//                value3 = [self getIntValue:user.earMin];
//                value4 = [self getAfterpointValue:user.earMin];
//            }
//            else
//            {
            value1 = @"37";
            value2 = @"6";
            value3 = @"35";
            value4 = @"8";
//            }
           [self initViewByEarAndGlu];
        }
            break;
    }
    [self initValue];
}
- (NSString *)getIntValue:(double)intValue
{
    double a = intValue;
    int b = (int)a;
    
     return [NSString stringWithFormat:@"%d",b];
}
- (NSString *)getAfterpointValue:(double)intValue
{
    double a = intValue;
    int b = (int)a;
    a = (a-b)*100;
    
    
    return [NSString stringWithFormat:@"%f",a];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

-(void)initNav{
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"tb_navbar.png"] forBarMetrics:UIBarMetricsDefault];
    }
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"comm_top_button_left.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    
    backBtn.frame=CGRectMake(0, 0,52, 42);//52, 42
    UILabel *backLabel=[[UILabel alloc]initWithFrame:CGRectMake(52, 0, 300, 42)];
    
    UIButton *saveBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:YINGYONG_COLOR forState:UIControlStateNormal];
    saveBtn.frame=CGRectMake(0, 0,70.5, 42);//52, 42
    [saveBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    backLabel.backgroundColor=[UIColor clearColor];
    backLabel.textColor=YINGYONG_COLOR;
    backLabel.textAlignment=NSTextAlignmentLeft;
    backLabel.font=[UIFont boldSystemFontOfSize:23];
    backLabel.text=viewTitle;
    UIView *backView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth-71, 42)];
    backView1.backgroundColor=[UIColor clearColor];
    [backView1 addSubview:backBtn];
    [backView1 addSubview:backLabel];
    
    UIView *backView2=[[UIView alloc]initWithFrame:CGRectMake(kDeviceWidth-71, 0, 71, 42)];
    backView2.backgroundColor=[UIColor clearColor];
    [backView2 addSubview:saveBtn];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backView1];
    UIBarButtonItem *saveButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backView2];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    self.navigationItem.rightBarButtonItem = saveButtonItem;
    self.view.backgroundColor = BACK_COLOR;
}

-(void)initViewByEarAndGlu
{
    UILabel *titles = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, kDeviceWidth, 44)];
    titles.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
    titles.textAlignment = NSTextAlignmentCenter;
    switch (Flag) {
        case XUETANGYUJING:
        {
            titles.text = @"国际标准 血糖：3.9～6.1";
        }
            break;
            
        case ERWENYUJING:
        {
            titles.text = @"国际标准 耳温：35.8～37.6";
        }
            break;
    }
    UILabel *zuigaozhi = [[UILabel alloc] initWithFrame:CGRectMake(0, 54, kDeviceWidth/2, 44)];
    zuigaozhi.textAlignment = NSTextAlignmentCenter;
    zuigaozhi.text = @"最高值";
    
    UILabel *zuidizhi = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/2+1,54 , kDeviceWidth/2, 44)];
    zuidizhi.textAlignment = NSTextAlignmentCenter;
    zuidizhi.text = @"最低值";
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 98, kDeviceWidth, 1)];
    line.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
    
    zuigaoPickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 100, kDeviceWidth/2, 44)];
    
    zuigaoPickView.delegate = self;
    zuigaoPickView.dataSource = self;
    zuigaoPickView.tag = 1;
    
    
    
    zuidiPickView = [[UIPickerView alloc] initWithFrame:CGRectMake(kDeviceWidth/2, 100, kDeviceWidth/2, 88)];
    zuidiPickView.delegate = self;
    zuidiPickView.dataSource = self;
    zuidiPickView.tag = 2;
    
    
    UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/2,54, 1,209)];
    line1.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];;
    UILabel *line3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 262, kDeviceWidth, 1)];
    line3.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
    
    UIButton *tongbubtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [tongbubtn setBackgroundColor:[UIColor whiteColor]];
    [tongbubtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    tongbubtn.frame = CGRectMake(kDeviceWidth/2-50, 262+30, 100, 40);
    [tongbubtn setTitle:@"恢复默认值" forState:UIControlStateNormal];
    [tongbubtn.layer setMasksToBounds:YES];
    [tongbubtn.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
    [tongbubtn addTarget:self action:@selector(setUp) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:titles];
    [self.view addSubview:zuigaozhi];
    [self.view addSubview:zuidizhi];
    [self.view addSubview:line];
    [self.view addSubview:zuidiPickView];
    [self.view addSubview:line1];
    [self.view addSubview:line3];
    [self.view addSubview:zuigaoPickView];
    [self.view addSubview:tongbubtn];
   
}


-(void)initViewByBp
{
    UILabel *titles = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, kDeviceWidth, 44)];
    titles.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
    titles.textAlignment = NSTextAlignmentCenter;
    titles.text = @"国际标准 高压:90~139 低压:60~89";
    UILabel *zuigaozhi = [[UILabel alloc] initWithFrame:CGRectMake(0, 54, kDeviceWidth/2, 44)];
    zuigaozhi.textAlignment = NSTextAlignmentCenter;
    zuigaozhi.text = @"高压";
    
    UILabel *zuidizhi = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/2+1,54 , kDeviceWidth/2, 44)];
    zuidizhi.textAlignment = NSTextAlignmentCenter;
    zuidizhi.text = @"低压";
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 98, kDeviceWidth, 1)];
    line.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
    
    
    UILabel *zuigaozhiValue = [[UILabel alloc] initWithFrame:CGRectMake(0, 99, kDeviceWidth/2, 44)];
    zuigaozhiValue.textAlignment = NSTextAlignmentCenter;
    zuigaozhiValue.text = @"最高值    最低值";
    
    UILabel *zuidizhiValue = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/2+1,99 , kDeviceWidth/2, 44)];
    zuidizhiValue.textAlignment = NSTextAlignmentCenter;
    zuidizhiValue.text = @"最高值     最低值";
    
    UILabel *line0 = [[UILabel alloc] initWithFrame:CGRectMake(0, 142, kDeviceWidth, 1)];
    line.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
    
    
    zuigaoPickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 150, kDeviceWidth/2, 44)];
    
    zuigaoPickView.delegate = self;
    zuigaoPickView.dataSource = self;
    zuigaoPickView.tag = 1;
    
    
    
    zuidiPickView = [[UIPickerView alloc] initWithFrame:CGRectMake(kDeviceWidth/2, 150, kDeviceWidth/2, 88)];
    zuidiPickView.delegate = self;
    zuidiPickView.dataSource = self;
    zuidiPickView.tag = 2;
    
    
    UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/2,54, 1,259)];
    line1.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];;
    UILabel *line3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 312, kDeviceWidth, 1)];
    line3.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
    
    UIButton *tongbubtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [tongbubtn setBackgroundColor:[UIColor whiteColor]];
    [tongbubtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    tongbubtn.frame = CGRectMake(kDeviceWidth/2-50, 306+30, 100, 40);
    [tongbubtn setTitle:@"恢复默认值" forState:UIControlStateNormal];
    [tongbubtn.layer setMasksToBounds:YES];
    [tongbubtn.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
    [tongbubtn addTarget:self action:@selector(setUp) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:titles];
    [self.view addSubview:zuigaozhi];
    [self.view addSubview:zuidizhi];
    [self.view addSubview:line];
    [self.view addSubview:zuidiPickView];
    [self.view addSubview:line1];
    [self.view addSubview:line3];
    [self.view addSubview:zuigaoPickView];
    [self.view addSubview:tongbubtn];
    [self.view addSubview:zuidizhiValue];
    [self.view addSubview:zuigaozhiValue];
    [self.view addSubview:line0];
  
}

//恢复默认值
- (void)setUp
{
    switch (Flag) {
            
        case XUEYAYUJING:
            
            [zuigaoPickView selectRow:139 inComponent:0 animated:YES];
            [zuigaoPickView selectRow:90 inComponent:1 animated:YES];
            [zuidiPickView selectRow:89 inComponent:0 animated:YES];
            [zuidiPickView selectRow:60 inComponent:1 animated:YES];
            break;
            
        case ERWENYUJING:
            [zuigaoPickView selectRow:37 inComponent:0 animated:YES];
            [zuigaoPickView selectRow:6 inComponent:1 animated:YES];
            [zuidiPickView selectRow:35 inComponent:0 animated:YES];
            [zuidiPickView selectRow:8 inComponent:1 animated:YES];
            
            break;
        case XUETANGYUJING:
        {
            [zuigaoPickView selectRow:6 inComponent:0 animated:YES];
            [zuigaoPickView selectRow:1 inComponent:1 animated:YES];
            [zuidiPickView selectRow:3 inComponent:0 animated:YES];
            [zuidiPickView selectRow:9 inComponent:1 animated:YES];
        }
            break;
    }
    
}

//恢复默认值
- (void)initValue
{

            [zuigaoPickView selectRow:[value1 intValue] inComponent:0 animated:YES];
            [zuigaoPickView selectRow:[value2 intValue] inComponent:1 animated:YES];
            [zuidiPickView selectRow:[value3 intValue] inComponent:0 animated:YES];
            [zuidiPickView selectRow:[value4 intValue] inComponent:1 animated:YES];
}

#pragma mark 保存
- (void)save
{
    switch (Flag) {
        case XUEYAYUJING:
        {
            user.pcpMax = [value1 intValue];
            user.pcpMin = [value2 intValue];
            user.pdpMax = [value3 intValue];
            user.pdpMin = [value4 intValue];
        }
            break;
            
        case XUETANGYUJING:
        {
            NSString *glueMax = [NSString stringWithFormat:@"%@.%@",value1,value2];
            user.gluMax = [glueMax doubleValue];
            
            NSString *gluMin = [NSString stringWithFormat:@"%@.%@",value3,value4];
            user.gluMin = [gluMin doubleValue];
            
        }
            break;
        case ERWENYUJING:
        {
            NSString *earMax = [NSString stringWithFormat:@"%@.%@",value1,value2];
            user.earMax = [earMax doubleValue];
            
            
            
            NSString *earMin = [NSString stringWithFormat:@"%@.%@",value3,value4];
            user.earMin = [earMin doubleValue];
            
        }
            break;
    }
    
    [dao replaceArrayToDB:[NSMutableArray arrayWithObject:user] callback:^(BOOL block){
    }];
    NSData *userData=[NSKeyedArchiver archivedDataWithRootObject:user];
    [[NSUserDefaults standardUserDefaults] setObject:userData forKey:@"user"];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component == 0)
    {
        return [dataArray count];
    }
    else
    {
     return [dataArray count];
    }
   
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component == 0)
    {
     return [dataArray objectAtIndex:row];
    }
else
    {
     return [dataArray objectAtIndex:row];
    }
 
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UIView *myPickView =[[UIView alloc] initWithFrame:CGRectMake(0,0,44,20)];
    pickerView.backgroundColor = [UIColor whiteColor];
    [myPickView setOpaque:TRUE];
//    [myPickView setBackgroundColor:[UIColor whiteColor]];
    UILabel *lbl=nil;
    lbl= [[UILabel alloc]
          initWithFrame:CGRectMake(8,0,
                                   66,
                                   30)];
    lbl.textAlignment = NSTextAlignmentCenter;
//    [lbl setBackgroundColor:[UIColor whiteColor]];
    UILabel *pointlable = [[UILabel alloc] initWithFrame:CGRectMake(74, 0, 10, 30)];
    pointlable.textAlignment = NSTextAlignmentCenter;
    pointlable.text = @".";
    pointlable.font = [UIFont boldSystemFontOfSize:18];
    pointlable.backgroundColor = [UIColor whiteColor];
   
    [lbl setText:[NSString stringWithFormat:@"%d",row]];
    [lbl setTextColor:YINGYONG_COLOR];
    [lbl setFont:[UIFont boldSystemFontOfSize:18]];
    [myPickView addSubview:lbl];
    [myPickView addSubview:pointlable];
    return myPickView;

}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 30;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(pickerView.tag)
        switch (pickerView.tag) {
            case 1:
            {
                if(component == 0)
                {
                    NSInteger selectedProvinceIndex = [pickerView selectedRowInComponent:0];
                    if(selectedProvinceIndex-1>= 0)
                    {
                     NSString *selectArray = [dataArray objectAtIndex:selectedProvinceIndex-1];
                     value1 = selectArray;
                    }
                }
                else
                {
                    NSInteger selectedProvinceIndex = [pickerView selectedRowInComponent:1];
                    if(selectedProvinceIndex-1 >= 0)
                    {
                      NSString *selectcityArray = [dataArray objectAtIndex:selectedProvinceIndex-1];
                      value2 = selectcityArray;
                    }
                }
            }
                break;
                
            case 2:
            {
                if(component == 0)
                {
                    NSInteger selectedProvinceIndex = [pickerView selectedRowInComponent:0];
                    if(selectedProvinceIndex-1 >= 0)
                    {
                     NSString *selectArray = [dataArray objectAtIndex:selectedProvinceIndex-1];
                     value3 = selectArray;
                    }
                }
                else
                {
                    NSInteger selectedProvinceIndex = [pickerView selectedRowInComponent:1];
                    if(selectedProvinceIndex -1>= 0)
                    {
                     NSString *selectcityArray = [dataArray objectAtIndex:selectedProvinceIndex-1];
                     value4 = selectcityArray;
                    }
                }
            }
                break;
        }
   
  }

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
}

- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
