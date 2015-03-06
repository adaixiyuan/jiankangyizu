//
//  geRenXinXi.m
//  ViewDeckExample
//
//  Created by apple on 14-5-13.
//  Copyright (c) 2014年 Adriaenssen BVBA. All rights reserved.
//

#import "geRenXinXi.h"

@interface geRenXinXi ()

@end

#import "SubmitViewCell.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "CommonStr.h"
#import "commonAction.h"
#import "commonJudgeMent.h"
#import "Wcm_Common_Region.h"
#import "ChangeData.h"
#import "commentity.h"
#import "SDImageView+SDWebCache.h"
#import "imageEntity.h"
#import "RDVTabBarController.h"

#define SEX 1
#define BLOD 2
#define BIRTHDAY 3
#define HOMEPHONE 4
#define BIRTHPALACE 5
#define LIVEDPALACE 6

@implementation geRenXinXi


@synthesize listView,positionPicker,jobPicker,classPicker,provinces,cities,readData,classArray,jobArray,singleInfo,resultArray,districts;
@synthesize isfirtview;
@synthesize youxiaoqiPiker;
@synthesize youxiaoqiArray;
@synthesize productArray;
@synthesize productPicker;
@synthesize jingyanArray;
@synthesize jingyanPicker;
@synthesize xinjinArray;
@synthesize xinjinPicker;
@synthesize connection3;
@synthesize receiveData3;
@synthesize connection1;
@synthesize receiveData1;
@synthesize datePicker;
@synthesize positionPicker2;
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

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
     [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    // 键盘高度变化通知，ios5.0新增的
#ifdef __IPHONE_5_0
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 5.0) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
#endif
    
}


//图片压缩
-(UIImage*)imageWithImageSimple:(UIImage *)image scaledToSize:(CGSize)newSize{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - View lifecycle
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNav];
    [self initPickerView];
    self.resultArray=[[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"",@"",@"",@"",@"",@"", nil];
    NSData *userData=[[NSUserDefaults standardUserDefaults]objectForKey:@"user"];
    singleInfo= [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    listView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, [[UIScreen mainScreen] bounds].size.height-64) style:UITableViewStyleGrouped];
    listView.delegate=self;
    listView.dataSource=self;
    UIView *backView1=[[UIView alloc]initWithFrame:listView.frame];
    backView1.backgroundColor=BACK_COLOR;
    [listView setBackgroundView:backView1];
    [self setExtraCellLineHidden:listView];
    [self.view addSubview:listView];
    
    
}
-(void)initNav{
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"tb_navbar.png"] forBarMetrics:UIBarMetricsDefault];
    }
    
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"comm_top_button_left.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    
    backBtn.frame=CGRectMake(0, 0,52, 42);//52, 42
   

    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    
    
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(52, 0, 300, 42)];
    titleLabel.backgroundColor=[UIColor clearColor];
    titleLabel.textColor=[UIColor blackColor];
    titleLabel.textAlignment=NSTextAlignmentLeft;
    titleLabel.font=[UIFont systemFontOfSize:23];
    titleLabel.textColor = YINGYONG_COLOR;
    titleLabel.text=@"个人信息";
    self.navigationItem.titleView = titleLabel;
    
    
    UIButton *refreshButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [refreshButton setImage:[UIImage imageNamed:@"button_zhuce.png"] forState:UIControlStateNormal];
    [refreshButton addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    refreshButton.frame=CGRectMake(19, 0, 51, 32);
    UILabel *refreshLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 51, 31)];
    refreshLabel.backgroundColor=[UIColor clearColor];
    refreshLabel.font=[UIFont systemFontOfSize:14];
    refreshLabel.text=@"保存";
    refreshLabel.textAlignment=NSTextAlignmentCenter;
    refreshLabel.textColor= YINGYONG_COLOR;
    [refreshButton addSubview:refreshLabel];
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:refreshButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}
-(void)goBack{
//    if (isDone==1) {
        [self.navigationController popViewControllerAnimated:YES];
//    }else{
//        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:STOP_BACK message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
//        alertView.tag=1;
//        [alertView show];
//    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==1) {
        switch (buttonIndex) {
            case 0:
                [self.navigationController popViewControllerAnimated:YES];
                break;
                
            default:
                break;
        }
    }
}

-(void)rightAction{
    id first=[self getFirstResponder];
    [first resignFirstResponder];
    if ([commonJudgeMent ifConnectNet]) {
        BOOL isSuccess=YES;
        NSMutableString *tiaojian = [[NSMutableString alloc]initWithString:@""];
        [tiaojian appendString:@"table_name=common_user"];
        NSData *userData=[[NSUserDefaults standardUserDefaults]objectForKey:@"user"];
        CommonUser *user= [NSKeyedUnarchiver unarchiveObjectWithData:userData];
        [tiaojian appendString:[NSString stringWithFormat:@"&obj.id=%d",user.identity]];
        if (headImage != nil) {
            [tiaojian appendString:[NSString stringWithFormat:@"&obj.head_img=%@",headImage]];
        }
       
        for (int i=0; i<=8; i++) {
        
            if (isSuccess) {
                switch (i) {
                    case 1:{
                        NSString *title=[self.resultArray objectAtIndex:1] ;
                        if (title == nil || [title isEqualToString:@""]) {
                            isSuccess=NO;
                            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"请输入姓名" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
                            [alertView show];
                            
                        }else{
                            [tiaojian appendString:[NSString stringWithFormat:@"&obj.name=%@",title]];
                        }
                        break;
                    }
                    case 6:{
                        NSString *title=[self.resultArray objectAtIndex:6] ;
                        if (title == nil || [title isEqualToString:@""]) {
                            isSuccess=NO;
                            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"请输入电话" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
                            [alertView show];
                            
                        }else{
                           [tiaojian appendString:[NSString stringWithFormat:@"&obj.home_tel='%@'",title]];
                        }
                        break;
                    }
                    case 2:{
                        
                        NSString *title=[self.resultArray objectAtIndex:3] ;
                        if (title == nil || [title isEqualToString:@""]) {
                        
                            [tiaojian appendString:[NSString stringWithFormat:@"&obj.sex=1"]];
                            
                        }else{
                            if ([title isEqualToString:@"男"]) {
                               [tiaojian appendString:[NSString stringWithFormat:@"&obj.sex=1"]];
                            }else if ([title isEqualToString:@"女"]){
                                [tiaojian appendString:[NSString stringWithFormat:@"&obj.sex=0"]];
                            }
                        }
                        break;
                        
                    }
                    case 7:{
                        NSString *bornPalace =[self.resultArray objectAtIndex:7];
                        if ([bornPalace isEqualToString:@""]) {
                            isSuccess=NO;
                            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"请选择出生地址" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
                            [alertView show];
                            
                        }else{
                            NSArray *array = [bornPalace componentsSeparatedByString:@","];
                            [tiaojian appendString:[NSString stringWithFormat:@"&obj.born_province=%@",array[0]]];
                            [tiaojian appendString:[NSString stringWithFormat:@"&obj.born_city=%@",array[1]]];
                            [tiaojian appendString:[NSString stringWithFormat:@"&obj.born_area=%@",array[2]]];
                            
                        }
                        
                        break;
                    }
                    case 8:{
                        NSString *livedPalace =[self.resultArray objectAtIndex:8];
                        if ([livedPalace isEqualToString:@""]) {
                            isSuccess=NO;
                            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"请选择居住地址" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
                            [alertView show];
                            
                        }else{
                            NSArray *livearray = [livedPalace componentsSeparatedByString:@","];
                            [tiaojian appendString:[NSString stringWithFormat:@"&obj.live_province=%@",livearray[0]]];
                            [tiaojian appendString:[NSString stringWithFormat:@"&obj.live_city=%@",livearray[1]]];
                            [tiaojian appendString:[NSString stringWithFormat:@"&obj.live_area=%@",livearray[2]]];
                        }
                        
                        break;
                    }
                        
                    case 5:
                    {
                         [tiaojian appendString:[NSString stringWithFormat:@"&obj.email=%@",resultArray[5]]];
                    }
                        break;
                    case 3:
                    {
                         [tiaojian appendString:[NSString stringWithFormat:@"&obj.blood=%@",resultArray[3]]];
                    }
                        break;
                    case 4:
                    {
                        [tiaojian appendString:[NSString stringWithFormat:@"&obj.birthdays=%@",resultArray[4]]];
                    }
                        break;
                }
            }
        }

        if (isSuccess) {
            
//            NSLog(@"条件：%@",tiaojian);
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,SUBMIT_URL]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
            [request setHTTPMethod:@"POST"];
            NSData *data = [tiaojian dataUsingEncoding:NSUTF8StringEncoding];
            [request setHTTPBody:data];
            //第二步，连接服务器
            NSLog(@"条件：%@",tiaojian);
            connection3 = [[NSURLConnection alloc]initWithRequest:request delegate:self];
        }
        
        
    }else{
        [commonAction showToast:NONETWORK WhithNavigationController:self];
        
    }

        
    
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response

{
    if(connection==connection3){
        NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
        NSLog(@"%@",[res allHeaderFields]);
        self.receiveData3 = [NSMutableData data];
    }else if(connection==connection1){
        NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
        NSLog(@"%@",[res allHeaderFields]);
        self.receiveData1 = [NSMutableData data];
    }
}

//接收到服务器传输数据的时候调用，此方法根据数据大小执行若干次

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (connection==connection3) {
        [self.receiveData3 appendData:data];
    }else if (connection==connection1) {
        [self.receiveData1 appendData:data];
    }
}
//数据传完之后调用此方法
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (connection==connection3) {
        
        NSString *receiveStr = [[NSString alloc]initWithData:self.receiveData3 encoding:NSUTF8StringEncoding];
        NSLog(@"%@",receiveStr);
 
        if ([JsonToModel ifSuccessFromDictionaryData:receiveData3]) {
//            [commonAction showToast:@"保存成功" WhithNavigationController: self.navigationController];
            
//            NSArray *array=[JsonToModel objectsFromDictionaryData:receiveData3 className:@"CommonUser"];
//            CommonUser *user=(CommonUser *)[array objectAtIndex:0];
            singleInfo.headImg=headImage;
            singleInfo.name=resultArray[1];
            singleInfo.blood=resultArray[3];
            if([resultArray[2] isEqualToString:@"男"])
            {
              singleInfo.sex=1;
            }
            else if([resultArray[2] isEqualToString:@"女"])
            {
              singleInfo.sex=0;
            }
            singleInfo.birthdays=resultArray[4];
            singleInfo.email = resultArray[5];
            
            NSArray *array = [resultArray[7] componentsSeparatedByString:@","];
            singleInfo.bornProvince = array[0];
            singleInfo.bornCity = array[1];
            singleInfo.bornArea = array[2];
            NSArray *livedarray = [resultArray[8] componentsSeparatedByString:@","];
            singleInfo.liveProvince = livedarray[0];
            singleInfo.liveCity = livedarray[1];
            singleInfo.liveArea = livedarray[2];
            singleInfo.tel = resultArray[6];
            
            NSData *userData=[NSKeyedArchiver archivedDataWithRootObject:singleInfo];
            
            NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
            [userDefaults setObject:userData forKey:@"user"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loginNote" object:nil];
            isDone=1;
            [self goBack];
//            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [commonAction showToast:[JsonToModel getMessageFromDictionaryData:receiveData3] WhithNavigationController:self.navigationController];
        }
        //        [NSThread detachNewThreadSelector:@selector(saveData) toTarget:self withObject:nil];
    }else if (connection==connection1) {
        
        NSString *receiveStr = [[NSString alloc]initWithData:self.receiveData1 encoding:NSUTF8StringEncoding];
        NSLog(@"%@",receiveStr);
       imageEntity *entity= [JsonToModel objectFromDictionary:[JsonToModel getDictionaryFromDictionaryData:self.receiveData1] className:@"imageEntity"];
        if (entity != nil) {
            headImage = entity.img_center;
           
            
        }
    }
    
}


//网络请求过程中，出现任何错误（断网，连接超时等）会进入此方法
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@",[error localizedDescription]);
}
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

-(void)initPickerView{
//    self.xinjinArray=(NSMutableArray *)[BbsCommBaseCodeDetail findByCriteria:@"where type_no='CD20005'"];
//    self.jingyanArray=(NSMutableArray *)[BbsCommBaseCodeDetail findByCriteria:@"where type_no='CD10002'"];
    
//    self.productArray=(NSMutableArray *)[BbsCommBaseCodeDetail findByCriteria:@"where type_no='CD00004'"];
    self.classArray=[[NSMutableArray alloc]initWithObjects:@"男",@"女", nil];
    self.jobArray = [[NSMutableArray alloc]init];
    for (int i=0; i<4; i++) {
        commentity *entity = [[commentity alloc]init];
        entity.identity = i;
        if (i==0) {
            entity.title = @"A";
        }else if(i==1){
            entity.title = @"B";
        }else if(i==2){
            entity.title = @"AB";
        }else if(i==3){
            entity.title = @"O";
        }
        [self.jobArray addObject:entity];
    }
    FMDatabaseQueue *queue = [[FMDatabaseQueue alloc]initWithPath:[[NSBundle mainBundle] pathForResource:@"BaseCode" ofType:@"db"]];
    Wcm_Common_RegionDao* dao = [[Wcm_Common_RegionDao alloc]initWithDbqueue:queue];
    [dao searchWhere:@"level_id=1" orderBy:@"" offset:0 count:100 callback:^(NSArray *array){
        self.provinces=(NSMutableArray *)array;
    }];
    Wcm_Common_Region *area1=[self.provinces objectAtIndex:0];
    FMDatabaseQueue *queue1 = [[FMDatabaseQueue alloc]initWithPath:[[NSBundle mainBundle] pathForResource:@"BaseCode" ofType:@"db"]];
    Wcm_Common_RegionDao* dao1 = [[Wcm_Common_RegionDao alloc]initWithDbqueue:queue1];
    [dao1 searchWhere:[NSString stringWithFormat:@"level_id=2 and parent_area_id = %d",area1.identity] orderBy:@"" offset:0 count:100 callback:^(NSArray *array){
        self.cities=(NSMutableArray *)array;
    }];
    
    Wcm_Common_Region *area2=[self.cities objectAtIndex:0];
    FMDatabaseQueue *queue2 = [[FMDatabaseQueue alloc]initWithPath:[[NSBundle mainBundle] pathForResource:@"BaseCode" ofType:@"db"]];
    Wcm_Common_RegionDao* dao2 = [[Wcm_Common_RegionDao alloc]initWithDbqueue:queue2];
    [dao2 searchWhere:[NSString stringWithFormat:@"level_id=3 and parent_area_id = %d",area2.identity] orderBy:@"" offset:0 count:100 callback:^(NSArray *array){
        self.districts=(NSMutableArray *)array;
    }];

    if (datePicker==nil) {
        datePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 216)];
        datePicker.datePickerMode=UIDatePickerModeDate;
        [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];
    }
    if (self.positionPicker == nil) {
        positionPicker =[[UIPickerView alloc]init];
        positionPicker.delegate = self;
        positionPicker.showsSelectionIndicator = YES;
        positionPicker.tag=1;
    }
    if(self.positionPicker2 == nil)
    {
        positionPicker2 =[[UIPickerView alloc]init];
        positionPicker2.delegate = self;
        positionPicker2.showsSelectionIndicator = YES;
        positionPicker2.tag=0;
    }
    if (self.classPicker == nil) {
        classPicker=[[UIPickerView alloc]init];
        classPicker.delegate=self;
        classPicker.showsSelectionIndicator=YES;
        classPicker.tag=2;
    }
    if (self.jobPicker == nil) {
        jobPicker=[[UIPickerView alloc]init];
        jobPicker.delegate=self;
        jobPicker.showsSelectionIndicator=YES;
        jobPicker.tag=3;
    }
    if (self.youxiaoqiPiker==nil) {
        youxiaoqiPiker=[[UIPickerView alloc]init];
        youxiaoqiPiker.delegate=self;
        youxiaoqiPiker.showsSelectionIndicator=YES;
        youxiaoqiPiker.tag=4;
    }
    if (productPicker==nil) {
        productPicker=[[UIPickerView alloc]init];
        productPicker.delegate=self;
        productPicker.showsSelectionIndicator=YES;
        productPicker.tag=5;
    }
    if (jingyanPicker==nil) {
        jingyanPicker=[[UIPickerView alloc]init];
        jingyanPicker.delegate=self;
        jingyanPicker.showsSelectionIndicator=YES;
        jingyanPicker.tag=6;
        
    }
    if (xinjinPicker==nil) {
        xinjinPicker=[[UIPickerView alloc]init];
        xinjinPicker.delegate=self;
        xinjinPicker.showsSelectionIndicator=YES;
        xinjinPicker.tag=7;
    }
}
-(void)dateChanged:(id)sender{
    UIDatePicker* control = (UIDatePicker*)sender;
    NSDate* _date = control.date;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy-MM-dd";
    NSString *dateString=[df stringFromDate:_date];
    NSIndexPath *index=[NSIndexPath indexPathForRow:4 inSection:0];
    SubmitViewCell *cell=(SubmitViewCell *)[listView cellForRowAtIndexPath:index];
    cell.detail.text=dateString;
    [self.resultArray replaceObjectAtIndex:4 withObject:dateString];
}
- (id)getFirstResponder
{
    NSUInteger index = 0;
    while (index <= 7) {
        UITextField *textField = (UITextField *)[self.view viewWithTag:index];
        if ([textField isFirstResponder]) {
            return textField;
        }
        index++;
    }
    
    return NO;
}

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    if (keyboardRect.size.height == 252){
        listView.frame=CGRectMake(0, 0, kDeviceWidth, [[UIScreen mainScreen] bounds].size.height-316);
    }
    else if(keyboardRect.size.height == 216){
        listView.frame=CGRectMake(0, 0, kDeviceWidth, [[UIScreen mainScreen] bounds].size.height-280);
    }
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    listView.frame=CGRectMake(0, 0, kDeviceWidth, [[UIScreen mainScreen] bounds].size.height-64);
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;
}

// 文本编辑监听事件
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag==1||textField.tag==5 || textField.tag == 6) {
        [self.resultArray replaceObjectAtIndex:textField.tag withObject:textField.text];
    }
    
    
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
     if (textField.tag==1||textField.tag==5 || textField.tag == 6) {
        [self.resultArray replaceObjectAtIndex:textField.tag withObject:textField.text];
    }
    return YES;
}

-(void)textViewDidEndEditing:(UITextView *)textView{
//     if (textField.tag==1||textField.tag==5 || textField.tag == 6) {
//    [self.resultArray replaceObjectAtIndex:te withObject:textView.text];
//     }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        
        return NO;
    }else{
//        [self.resultArray replaceObjectAtIndex:11 withObject:textView.text];
    }
    return YES;
}

- (BOOL)valueIsPhone:(NSString*)str{
    NSString * phone = @"^1[3458]\\d{9}$";
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phone];
    BOOL isMatchPhone = [pred evaluateWithObject:str];
    return isMatchPhone;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    switch (pickerView.tag) {
        case 0:
            return 3;
            break;
        case 1:
            return 3;
            break;
        case 2:
            return 1;
            break;
        case 3:
            return 1;
            break;
        case 4:
            return 1;
        case 5:
            return 1;
        case 6:
            return 1;
        case 7:
            return 1;
        default:
            return 1;
            break;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    switch (pickerView.tag) {
        case 0:
        {
            switch (component) {
                case 0:
                    return [self.provinces count];
                    break;
                case 1:
                    return [self.cities count];
                    break;
                default:
                    return [self.districts count];
                    break;
            }
            break;
        
        }
        case 1:{
            switch (component) {
                case 0:
                    return [self.provinces count];
                    break;
                case 1:
                    return [self.cities count];
                    break;
                default:
                    return [self.districts count];
                    break;
            }
            break;
        }
        case 2:{
            return [self.classArray count];
            break;
        }
        case 3:{
        
            return [self.jobArray count];
            break;
        }
        case 4:{
            return [self.youxiaoqiArray count];
            break;
        }
        case 5:{
            return  [self.productArray count];
        }
        case 6:{
            return  [self.jingyanArray count];
        }
        case 7:{
            return  [self.xinjinArray count];
        }
        default:
            return 0;
            break;
    }
    
    
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (pickerView.tag) {
        case 0:
        {
            switch (component) {
                case 0:{
                    Wcm_Common_Region *area2=[self.provinces objectAtIndex:row];
                    return area2.area_name;
                    break;
                }
                case 1:{
                    Wcm_Common_Region *area2=[self.cities objectAtIndex:row];
                    return area2.area_name;
                    break;
                }
                default:{
                    Wcm_Common_Region *area2=[self.districts objectAtIndex:row];
                    return area2.area_name;
                    break;
                }
            }
            
            break;
        }

        case 1:{
            switch (component) {
                case 0:{
                    Wcm_Common_Region *area2=[self.provinces objectAtIndex:row];
                    return area2.area_name;
                    break;
                }
                case 1:{
                    Wcm_Common_Region *area2=[self.cities objectAtIndex:row];
                    return area2.area_name;
                    break;
                }
                default:{
                    Wcm_Common_Region *area2=[self.districts objectAtIndex:row];
                    return area2.area_name;
                    break;
                }
            }

            break;
        }
        case 2:{
            return [self.classArray objectAtIndex:row];
            break;
        }
        case 3:{
            commentity *detail2=[self.jobArray objectAtIndex:row];
            return detail2.title;
       
            break;
        }
        case 4:{
            commentity *detail2= [self.youxiaoqiArray objectAtIndex:row];
            return detail2.title;
            break;
        }
        case 5:{
            commentity *detail2 = [self.productArray objectAtIndex:row];
            return detail2.title;
            break;
        }
        case 6:{
            commentity *detail2 = [self.jingyanArray objectAtIndex:row];
            return detail2.title;
            break;
        }
        case 7:{
            commentity *detail2= [self.xinjinArray objectAtIndex:row];
            return detail2.title;
            break;
        }
        default:
            return nil;
            break;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (pickerView.tag) {
        case 0:{
            NSString *areaFullName=@"";
            
            
            switch (component) {
                case 0:{
                    Wcm_Common_Region *area1=[self.provinces objectAtIndex:row];
                    FMDatabaseQueue *queue1 = [[FMDatabaseQueue alloc]initWithPath:[[NSBundle mainBundle] pathForResource:@"BaseCode" ofType:@"db"]];
                    Wcm_Common_RegionDao* dao1 = [[Wcm_Common_RegionDao alloc]initWithDbqueue:queue1];
                    [dao1 searchWhere:[NSString stringWithFormat:@"level_id=2 and parent_area_id = %d",area1.identity] orderBy:@"" offset:0 count:100 callback:^(NSArray *array){
                        self.cities=(NSMutableArray *)array;
                    }];
                    if ([self.cities count]>0) {
                        Wcm_Common_Region *area2=[self.cities objectAtIndex:0];
                        FMDatabaseQueue *queue2 = [[FMDatabaseQueue alloc]initWithPath:[[NSBundle mainBundle] pathForResource:@"BaseCode" ofType:@"db"]];
                        Wcm_Common_RegionDao* dao2 = [[Wcm_Common_RegionDao alloc]initWithDbqueue:queue2];
                        [dao2 searchWhere:[NSString stringWithFormat:@"level_id=3 and parent_area_id = %d",area2.identity] orderBy:@"" offset:0 count:100 callback:^(NSArray *array){
                            self.districts=(NSMutableArray *)array;
                        }];
                        if ([self.districts count]>0) {
                            Wcm_Common_Region *area3=[self.districts objectAtIndex:0];
                            //                            [self.resultArray replaceObjectAtIndex:2 withObject:[NSNumber numberWithInt:area3.identity]];
                            
                            areaFullName=area3.node_full_name;
                        }else{
                            areaFullName=area2.node_full_name;
                        }
                    }else{
                        self.districts=[[NSMutableArray alloc]initWithCapacity:0];
                        //                        [self.resultArray replaceObjectAtIndex:2 withObject:[NSNumber numberWithInt:area1.identity]];
                        //                        [self.resultArray replaceObjectAtIndex:9 withObject:area1.node_full_name];
                       
                        areaFullName=area1.node_full_name;
                        
                    }
                    [self.positionPicker2 selectRow:0 inComponent:1 animated:NO];
                    [self.positionPicker2 reloadComponent:1];
                    [self.positionPicker2 selectRow:0 inComponent:2 animated:NO];
                    [self.positionPicker2 reloadComponent:2];
                    break;
                }
                case 1:{
                    Wcm_Common_Region *area2=[self.cities objectAtIndex:row];
                    FMDatabaseQueue *queue2 = [[FMDatabaseQueue alloc]initWithPath:[[NSBundle mainBundle] pathForResource:@"BaseCode" ofType:@"db"]];
                    Wcm_Common_RegionDao* dao2 = [[Wcm_Common_RegionDao alloc]initWithDbqueue:queue2];
                    [dao2 searchWhere:[NSString stringWithFormat:@"level_id=3 and parent_area_id = %d",area2.identity] orderBy:@"" offset:0 count:100 callback:^(NSArray *array){
                        self.districts=(NSMutableArray *)array;
                    }];
                    
                    if ([self.districts count]>0) {
                        Wcm_Common_Region *area3=[self.districts objectAtIndex:0];
                        
                        //                        [self.resultArray replaceObjectAtIndex:2 withObject:[NSNumber numberWithInt:area3.identity]];
                      
                        
                        areaFullName=area3.node_full_name;
                    }else{
                        //                        [self.resultArray replaceObjectAtIndex:2 withObject:[NSNumber numberWithInt:area2.identity]];
                        
                        areaFullName=area2.node_full_name;
                       
                    }
                    [self.positionPicker2 selectRow:0 inComponent:2 animated:NO];
                    [self.positionPicker2 reloadComponent:2];
                    break;
                }
                default:{
                    Wcm_Common_Region *area3=[self.districts objectAtIndex:row];
                    
                    //                    [self.resultArray replaceObjectAtIndex:2 withObject:[NSNumber numberWithInt:area3.identity]];
                    
                    areaFullName=area3.node_full_name;
                  
                    break;
                }
            }
            NSIndexPath *index=[NSIndexPath indexPathForRow:3 inSection:1];
            SubmitViewCell *cell=(SubmitViewCell *)[listView cellForRowAtIndexPath:index];
            [self.resultArray replaceObjectAtIndex:8 withObject:areaFullName];
            cell.detail.text= areaFullName;
            
            break;
        }

        case 1:{
            NSString *areaFullName=@"";

            
            switch (component) {
                case 0:{
                    Wcm_Common_Region *area1=[self.provinces objectAtIndex:row];
                    FMDatabaseQueue *queue1 = [[FMDatabaseQueue alloc]initWithPath:[[NSBundle mainBundle] pathForResource:@"BaseCode" ofType:@"db"]];
                    Wcm_Common_RegionDao* dao1 = [[Wcm_Common_RegionDao alloc]initWithDbqueue:queue1];
                    [dao1 searchWhere:[NSString stringWithFormat:@"level_id=2 and parent_area_id = %d",area1.identity] orderBy:@"" offset:0 count:100 callback:^(NSArray *array){
                        self.cities=(NSMutableArray *)array;
                    }];
                    if ([self.cities count]>0) {
                        Wcm_Common_Region *area2=[self.cities objectAtIndex:0];
                        FMDatabaseQueue *queue2 = [[FMDatabaseQueue alloc]initWithPath:[[NSBundle mainBundle] pathForResource:@"BaseCode" ofType:@"db"]];
                        Wcm_Common_RegionDao* dao2 = [[Wcm_Common_RegionDao alloc]initWithDbqueue:queue2];
                        [dao2 searchWhere:[NSString stringWithFormat:@"level_id=3 and parent_area_id = %d",area2.identity] orderBy:@"" offset:0 count:100 callback:^(NSArray *array){
                            self.districts=(NSMutableArray *)array;
                        }];
                        if ([self.districts count]>0) {
                            Wcm_Common_Region *area3=[self.districts objectAtIndex:0];
                            //                            [self.resultArray replaceObjectAtIndex:2 withObject:[NSNumber numberWithInt:area3.identity]];
                            
                            areaFullName=area3.node_full_name;
                        }else{
                            
                            areaFullName=area2.node_full_name;
                        }
                    }else{
                        self.districts=[[NSMutableArray alloc]initWithCapacity:0];
                        //                        [self.resultArray replaceObjectAtIndex:2 withObject:[NSNumber numberWithInt:area1.identity]];
                        //                        [self.resultArray replaceObjectAtIndex:9 withObject:area1.node_full_name];
                        
                        areaFullName=area1.node_full_name;
                
                    }
                    [self.positionPicker selectRow:0 inComponent:1 animated:NO];
                    [self.positionPicker reloadComponent:1];
                    [self.positionPicker selectRow:0 inComponent:2 animated:NO];
                    [self.positionPicker reloadComponent:2];
                    break;
                }
                case 1:{
                    Wcm_Common_Region *area2=[self.cities objectAtIndex:row];
                    FMDatabaseQueue *queue2 = [[FMDatabaseQueue alloc]initWithPath:[[NSBundle mainBundle] pathForResource:@"BaseCode" ofType:@"db"]];
                    Wcm_Common_RegionDao* dao2 = [[Wcm_Common_RegionDao alloc]initWithDbqueue:queue2];
                    [dao2 searchWhere:[NSString stringWithFormat:@"level_id=3 and parent_area_id = %d",area2.identity] orderBy:@"" offset:0 count:100 callback:^(NSArray *array){
                        self.districts=(NSMutableArray *)array;
                    }];
                    
                    if ([self.districts count]>0) {
                        Wcm_Common_Region *area3=[self.districts objectAtIndex:0];
                        
                        //                        [self.resultArray replaceObjectAtIndex:2 withObject:[NSNumber numberWithInt:area3.identity]];
                        
                   
                        areaFullName=area3.node_full_name;
                    }else{
                        //                        [self.resultArray replaceObjectAtIndex:2 withObject:[NSNumber numberWithInt:area2.identity]];
                        
                        areaFullName=area2.node_full_name;
                      
                    }
                    [self.positionPicker selectRow:0 inComponent:2 animated:NO];
                    [self.positionPicker reloadComponent:2];
                    break;
                }
                default:{
                    Wcm_Common_Region *area3=[self.districts objectAtIndex:row];
                    
                    //                    [self.resultArray replaceObjectAtIndex:2 withObject:[NSNumber numberWithInt:area3.identity]];
                    
                    areaFullName=area3.node_full_name;
                    
                    break;
                }
            }
            NSIndexPath *index=[NSIndexPath indexPathForRow:2 inSection:1];
            SubmitViewCell *cell=(SubmitViewCell *)[listView cellForRowAtIndexPath:index];
            [self.resultArray replaceObjectAtIndex:7 withObject:areaFullName];

            cell.detail.text= areaFullName;

            break;
        }
        case 2:{
            NSIndexPath *index=[NSIndexPath indexPathForRow:2 inSection:0];
            SubmitViewCell *cell=(SubmitViewCell *)[listView cellForRowAtIndexPath:index];
            [self.resultArray replaceObjectAtIndex:2 withObject:[classArray objectAtIndex:row]];
            cell.detail.text=[classArray objectAtIndex:row];
            break;
        }
        case 3:{
            NSIndexPath *index=[NSIndexPath indexPathForRow:3 inSection:0];
            SubmitViewCell *cell=(SubmitViewCell *)[listView cellForRowAtIndexPath:index];
            commentity *detail2=[self.jobArray objectAtIndex:row];
            cell.detail.text=detail2.title;
            [self.resultArray replaceObjectAtIndex:3 withObject:detail2.title];
            break;
        }
//        case 4:{
//            NSIndexPath *index=[NSIndexPath indexPathForRow:2 inSection:0];
//            SubmitViewCell *cell=(SubmitViewCell *)[listView cellForRowAtIndexPath:index];
//            commentity *detail2=[self.youxiaoqiArray objectAtIndex:row];
//            cell.detail.text=detail2.title;
//            [self.resultArray replaceObjectAtIndex:2 withObject:[NSNumber numberWithInt:detail2.identity]];
//            break;
//        }
        case 5:{
            NSIndexPath *index=[NSIndexPath indexPathForRow:4 inSection:0];
            SubmitViewCell *cell=(SubmitViewCell *)[listView cellForRowAtIndexPath:index];
            commentity *detail2=[self.productArray objectAtIndex:row];
            cell.detail.text=detail2.title;
            [self.resultArray replaceObjectAtIndex:4 withObject:[NSNumber numberWithInt:detail2.identity]];
            break;
        }
//        case 6:{
//            NSIndexPath *index=[NSIndexPath indexPathForRow:2 inSection:0];
//            SubmitViewCell *cell=(SubmitViewCell *)[listView cellForRowAtIndexPath:index];
//            commentity *detail2=[self.jingyanArray objectAtIndex:row];
//            cell.detail.text=detail2.title;
//            [self.resultArray replaceObjectAtIndex:7 withObject:[NSNumber numberWithInt:detail2.identity]];
//            break;
//        }
//        case 7:{
//            
//            
//            break;
//        }
        default:
            break;
    }
    
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0){
        return 5;
    }else{
        
        return 4;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0 && indexPath.row==0) {
        return 70;
    }else{
        return 44;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row=indexPath.row;
    NSString *CellIdentifier;
    CellIdentifier = [NSString stringWithFormat:@"Cell%d",row+indexPath.section*10];
    SubmitViewCell *cell = (SubmitViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [cell removeFromSuperview];
    if (cell == nil) {
        cell = [[SubmitViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.backgroundColor=[UIColor whiteColor];
    cell.detail.delegate=self;
    cell.title.font=[UIFont systemFontOfSize:12];
    cell.imageView.hidden=YES;
    cell.detail.font=[UIFont systemFontOfSize:12];
    cell.title.frame=CGRectMake(10, 2, 85, 39);
    cell.detail2.font=[UIFont systemFontOfSize:12];
    if (indexPath.section==0) {
        switch (row) {
            case 0:{
                cell.title.frame=CGRectMake(10, 2, 85, 66);
                cell.detail.hidden=YES;
                cell.detail2.hidden=YES;
                cell.imageView.hidden=NO;
                cell.title.text=@"头像";
                cell.detail.tag=0;
                UIImageView *touxiangimage=[[UIImageView alloc]initWithFrame:CGRectMake(250, 10, 50, 50)];
//                [self.resultArray replaceObjectAtIndex:0 withObject:singleInfo.headImg];
                headImage = singleInfo.headImg;
                touxiangimage.image=[UIImage imageNamed:@"touxiang.png"];
                touxiangimage.tag=100;
                [touxiangimage.layer setCornerRadius:25];
                [touxiangimage.layer setMasksToBounds:YES];
                if( singleInfo.headImg!=nil &&![singleInfo.headImg isEqualToString:@""]){
                    if ([singleInfo.headImg hasPrefix:@"http:"]) {
                        [touxiangimage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",singleInfo.headImg]] refreshCache:NO placeholderImage:[UIImage imageNamed:@"touxiang.png"]];
                    }else{
                        [touxiangimage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,singleInfo.headImg]] refreshCache:NO placeholderImage:[UIImage imageNamed:@"touxiang.png"]];
                    }
                }else{
                    touxiangimage.image = [UIImage imageNamed:@"touxiang.png"];
                }
//                [touxiangimage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",singleInfo.userFace]] refreshCache:NO placeholderImage:[UIImage imageNamed:@"touxiang.png"]];
//                touxiangimage.re
                [cell.contentView addSubview:touxiangimage];
                break;
            }
         
            case 1:{
                cell.title.text=@"真实姓名";
                cell.detail.placeholder=@"请输入您的真实姓名";
                cell.detail.tag=1;
                if ([cell.detail.text length]<=0) {
                    NSString *realName=singleInfo.name;
                    if (realName!=nil && ![realName isEqualToString:@"(null)"] && ![realName isEqualToString:@""]) {
                        cell.detail.text=realName;
                        [self.resultArray replaceObjectAtIndex:1 withObject:realName];
                    }else{
                        NSString *nickName=singleInfo.usern;
                        if (nickName!=nil && ![nickName isEqualToString:@"(null)"] && ![nickName isEqualToString:@""]) {
                            cell.detail.text=nickName;
                            [self.resultArray replaceObjectAtIndex:1 withObject:nickName];
                        }
                    }
                }
                break;
            }
            case 2:{
                cell.detail.placeholder=@"男";
                cell.detail.inputView=classPicker;
                if (singleInfo.sex==1) {
                    cell.detail.text=@"男";
                }else{
                    cell.detail.text=@"女";
                }
                @try {
                    [self.resultArray replaceObjectAtIndex:2 withObject: cell.detail.text];
                }
                @catch (NSException *exception) {
                    NSLog(@"error:%@",exception);
                }
               
                cell.title.text=@"性别";
                cell.detail.tag=2;
                break;
            }case 3:{
                cell.detail.placeholder=@"血型";
                cell.detail.inputView=jobPicker;
                
                    cell.detail.text=singleInfo.blood;
               
                @try {
                    [self.resultArray replaceObjectAtIndex:3 withObject:cell.detail.text];
                }
                @catch (NSException *exception) {
                    NSLog(@"error:%@",exception);
                }
               
                cell.title.text=@"血型";
                cell.detail.tag=3;
                break;
            }
            case 4:{
                cell.detail.placeholder=@"出生日期";
                cell.detail.inputView=datePicker;
                
                @try {
                    cell.detail.text= singleInfo.birthdays;
                 [self.resultArray replaceObjectAtIndex:4 withObject:cell.detail.text];
                }
                @catch (NSException *exception) {
                    NSLog(@"error:%@",exception);
                }
                cell.title.text=@"出生日期";
                cell.detail.tag=4;
                break;
                
                
            }
                
            default:
                break;
        }
    }else{
        switch (row) {
            case 0:{
                cell.detail.placeholder=@"未填写";
//                cell.detail.inputView=classPicker;
                cell.detail.text=singleInfo.email;
                [self.resultArray replaceObjectAtIndex:5 withObject:singleInfo.email];
                cell.title.text=@"邮箱";
                cell.detail.tag=5;
                break;
            }
            case 1:{
                cell.detail.placeholder=@"未填写";
//                cell.detail.inputView=classPicker;
                cell.detail.text=singleInfo.tel;
                 [self.resultArray replaceObjectAtIndex:6 withObject:singleInfo.tel];
                cell.title.text=@"家人电话";
                cell.detail.tag=6;
                break;
            }
            case 2:{
                cell.imageView.image=[UIImage imageNamed:@"position1.png"];
                cell.title.text=@"出生地址";
                cell.detail.inputView=positionPicker;
                
                cell.detail.tag=7;
                cell.detail.placeholder=@"请填写出生地址";
                if (singleInfo!=nil) {
                    cell.detail.text = [NSString stringWithFormat:@"%@,%@,%@",singleInfo.bornProvince,singleInfo.bornCity,singleInfo.bornArea];
                    [self.resultArray replaceObjectAtIndex:7 withObject:cell.detail.text];
                }
                break;
            }
            case 3:{
                cell.imageView.image=[UIImage imageNamed:@"position1.png"];
                cell.title.text=@"居住地址";
                cell.detail.inputView=positionPicker2;
                cell.detail.tag=8;
                
                cell.detail.placeholder=@"请填写居住地址";
                                if (singleInfo!=nil) {
                                     cell.detail.text = [NSString stringWithFormat:@"%@,%@,%@",singleInfo.liveProvince,singleInfo.liveCity,singleInfo.liveArea];
                    [self.resultArray replaceObjectAtIndex:8 withObject:cell.detail.text ];
                                }
                break;
            }

            default:
                break;
        }
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)buttonTouch{
    NSIndexPath *index=[NSIndexPath indexPathForRow:4 inSection:0];
    SubmitViewCell *cell=(SubmitViewCell *)[listView cellForRowAtIndexPath:index];
    UIImageView *imageview=(UIImageView *)[cell viewWithTag:101];
    if (isSanyi==0) {
        isSanyi=1;
        imageview.image=[UIImage imageNamed:@"select_cell.png"];
    }
    else if (isSanyi==1) {
        isSanyi=0;
        imageview.image=[UIImage imageNamed:@"duanxinxuanze_back.png"];
    }
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0 && indexPath.section==0) {
        [self addPhoto];
    }
    if (indexPath.row==3 && indexPath.section==0) {
        [self inshouhuo];
    }
}




- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
/*
 photo
 */
-(void)picAction{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@""
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"拍照",@"相册",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}

- (void)addPhoto
{
    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.navigationBar.tintColor = [UIColor colorWithRed:50.0/255.0 green:150.0/255.0 blue:28.0/255.0 alpha:1.0];
	imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	imagePickerController.delegate = self;
	imagePickerController.allowsEditing = NO;
	[self presentViewController:imagePickerController animated:YES completion:nil];
}
- (void)takePhoto
{
    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = NO;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage * image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    NSIndexPath *index=[NSIndexPath indexPathForRow:0 inSection:0];
    SubmitViewCell *cell=(SubmitViewCell *)[listView cellForRowAtIndexPath:index];
    UIImageView *imageview=(UIImageView *)[cell viewWithTag:100];
    imageview.image=image;
    [self sendpic:image];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)inshouhuo{
//    shouhuoxinxi *shouhuo=[[shouhuoxinxi alloc]init];
//    shouhuo.delegate=self;
//    [self.navigationController pushViewController:shouhuo animated:YES];
}

-(void)sendpic:(UIImage *)image2{
     NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,@"/file/upload.jsp"]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:111111];
    [request setHTTPMethod:@"POST"];
        if (image2.size.width<=120) {
            if (image2.size.height>200) {
                image2 = [self imageWithImageSimple:image2 scaledToSize:CGSizeMake(image2.size.width/image2.size.height*200, 200)];
            }
        }else  {
            image2 = [self imageWithImageSimple:image2 scaledToSize:CGSizeMake(120, image2.size.height/image2.size.width*120)];
            if (image2.size.height>200) {
                image2 = [self imageWithImageSimple:image2 scaledToSize:CGSizeMake(image2.size.width/image2.size.height*200, 200)];
            }
        }
    NSData *imageData= UIImageJPEGRepresentation(image2,0.9);
     NSString *str=[NSString stringWithFormat:@"fileType=1&fileString=%@",[ChangeData data2String:imageData]];
    NSLog(@"%@",str);
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    //第二步，连接服务器
    connection1 = [[NSURLConnection alloc]initWithRequest:request delegate:self];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
}

-(void)getNewMember{
    
}
@end