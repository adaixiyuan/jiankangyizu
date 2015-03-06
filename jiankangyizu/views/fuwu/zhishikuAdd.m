//
//  zhishikuAdd.m
//  jiankangyizu
//
//  Created by apple on 15/2/12.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "zhishikuAdd.h"

@interface zhishikuAdd ()

@end


#import "SubmitViewCell.h"
#import "CommonStr.h"
#import "ChangeData.h"
#import "imageEntity.h"
#import "SDImageView+SDWebCache.h"


@implementation zhishikuAdd
@synthesize resultArray;
@synthesize datePicker1;
@synthesize receiveData1;
@synthesize connection1;
@synthesize receiveData2;
@synthesize connection2;
@synthesize receiveData3;
@synthesize connection3;
@synthesize classPicker;
@synthesize classArray;
@synthesize classArray1;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initNav];
    [self initPicker];
    [self initTable];
    // Do any additional setup after loading the view.
}

-(void)initData{
    self.resultArray=[[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"", nil];
    NSData *userData=[[NSUserDefaults standardUserDefaults]objectForKey:@"user"];
    user= [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    NSNumber *userId= [[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    user.identity = userId.intValue;
    imageFile1 = [[NSString alloc]init];
    imageFile2 = [[NSString alloc]init];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
        [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
        [super viewWillDisappear:animated];
}

-(void)initNav{
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"tb_navbar.png"] forBarMetrics:UIBarMetricsDefault];
    }
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"comm_top_button_left.png"] forState:UIControlStateNormal];
    backBtn.frame=CGRectMake(0, 0,56, 31);//52, 42
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UILabel *backLabel=[[UILabel alloc]initWithFrame:CGRectMake(57, 0, 100, 31)];
    backLabel.backgroundColor=[UIColor clearColor];
    backLabel.textColor=YINGYONG_COLOR;
    backLabel.textAlignment=NSTextAlignmentLeft;
    backLabel.font=[UIFont boldSystemFontOfSize:23];
    backLabel.text=@"添加";
    UIView *backView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 160, 31)];
    backView1.backgroundColor=[UIColor clearColor];
    [backView1 addSubview:backBtn];
    [backView1 addSubview:backLabel];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backView1];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    
    UIButton *rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitle:@"保存" forState:UIControlStateNormal];
    [rightButton setTitleColor:YINGYONG_COLOR forState:UIControlStateNormal];
    rightButton.titleLabel.font=[UIFont systemFontOfSize:20];
    [rightButton addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    rightButton.frame=CGRectMake(0, 0,100, 29);//52, 42
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    
}
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightAction{
    
    if ([commonJudgeMent ifConnectNet]) {
        BOOL isSuccess=YES;
        NSMutableString *tiaojian = [[NSMutableString alloc]initWithString:@""];
        [tiaojian appendString:[NSString stringWithFormat:@"table_name=%@",@"jk_news"]];
        [tiaojian appendString:[NSString stringWithFormat:@"&obj.add_user=%@",user.usern]];
        [tiaojian appendString:[NSString stringWithFormat:@"&obj.user_id=%d",user.identity]];
        
        for (int i=0; i<=5; i++) {
            if (isSuccess) {
                switch (i) {
                    case 0:{
                        NSString *title=[self.resultArray objectAtIndex:0] ;
                        if (title == nil || [title isEqualToString:@""]) {
                            isSuccess=NO;
                            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"请填写标题" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
                            [alertView show];
                            
                        }else{
                            [tiaojian appendString:[NSString stringWithFormat:@"&obj.title=%@",title]];
                        }
                        break;
                    }
                    case 1:{
                        NSString *title=[self.resultArray objectAtIndex:1] ;
                        if (title == nil || [title isEqualToString:@""]) {
                            isSuccess=NO;
                            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"请填写简介" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
                            [alertView show];
                            
                        }else{
                            [tiaojian appendString:[NSString stringWithFormat:@"&obj.summary=%@",title]];
                        }
                        break;
                    }
                    case 2:{
                        NSString *title=[self.resultArray objectAtIndex:2] ;
                        if (title == nil || [title isEqualToString:@""]) {
                            isSuccess=NO;
                            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"请选择科室" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
                            [alertView show];
                            
                        }else{
                            [tiaojian appendString:[NSString stringWithFormat:@"&obj.department_no=%@",title]];
                        }
                        break;
                    }
                    case 3:{
                        NSString *title=[self.resultArray objectAtIndex:3] ;
                        if (title == nil || [title isEqualToString:@""]) {
                            isSuccess=NO;
                            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"请填写内容" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
                            [alertView show];
                            
                        }else{
                            [tiaojian appendString:[NSString stringWithFormat:@"&obj.content=%@",title]];
                        }
                        break;
                    }
                    case 4:{
                        NSString *title=[self.resultArray objectAtIndex:4] ;
                        if (title == nil || [title isEqualToString:@""]) {
                        }else{
                            [tiaojian appendString:[NSString stringWithFormat:@"&obj.img=%@",title]];
                        }
                        break;
                    }
                        
                        
                        
                        
                        
                    default:
                        break;
                }
            }
        }
        
        if (isSuccess) {
            
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,SUBMIT_URL]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
            [request setHTTPMethod:@"POST"];
            NSData *data = [tiaojian dataUsingEncoding:NSUTF8StringEncoding];
            [request setHTTPBody:data];
            //第二步，连接服务器
            connection3 = [[NSURLConnection alloc]initWithRequest:request delegate:self];
        }
        
        
    }else{
       [commonAction showToast:NONETWORK WhithNavigationController:self];
    }
    
    
    
}

-(void)initTable{
    
    listView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KDeviceHeight, [[UIScreen mainScreen]bounds].size.height-64) style:UITableViewStyleGrouped];
    
    listView.delegate=self;
    listView.dataSource=self;
    [listView.layer setBorderColor:[[UIColor colorWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1.0]CGColor]];
    [listView.layer setBorderWidth:0.5];
    [self.view addSubview:listView];
    UIView *backView1=[[UIView alloc]initWithFrame:listView.frame];
    backView1.backgroundColor=[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
    [listView setBackgroundView:backView1];
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 0)];
    footerView.backgroundColor = [UIColor clearColor];
    UIButton *dengluButton = [UIButton buttonWithType:UIButtonTypeCustom];
    dengluButton.frame=CGRectMake(10, 20, kDeviceWidth-20, 34);
    [dengluButton setBackgroundImage:[[UIImage imageNamed:@"button_blue.png"]
                                      stretchableImageWithLeftCapWidth:15 topCapHeight:10] forState:UIControlStateNormal];
    [dengluButton setTitle:@"查找" forState:UIControlStateNormal];
    [dengluButton addTarget:self action:@selector(chazhao) forControlEvents:UIControlEventTouchUpInside];
    [dengluButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    dengluButton.titleLabel.font = [UIFont systemFontOfSize:12];
//    [footerView addSubview:dengluButton];
    listView.tableFooterView = footerView;
}
-(void)chazhao{
    /* if ([[resultArray objectAtIndex:0] isEqualToString:@""] &&[[resultArray objectAtIndex:1] isEqualToString:@""] &&[[resultArray objectAtIndex:2] isEqualToString:@""] &&[[resultArray objectAtIndex:3] isEqualToString:@""] &&[[resultArray objectAtIndex:4] isEqualToString:@""] ) {
     [commonAction showToast:@"请至少填写一项，谢谢！"];
     }else{
     chazhaoyisheng *chazhao = [[chazhaoyisheng alloc]init];
     chazhao.resultArray  = resultArray;
     [self.navigationController pushViewController:chazhao animated:YES];
     }*/
}
#pragma mark - Table view data source


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 4;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==1 && indexPath.row==0) {
        return 64;
    }else if(indexPath.row==3){
        return 100;
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row=indexPath.row;
    if ((indexPath.section==1 && indexPath.row==0)) {
        NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%d",row+indexPath.section*10];
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.backgroundColor=[UIColor whiteColor];
        
        
        UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(40, 2, 85, 39)];
        title.textAlignment=NSTextAlignmentLeft;
        
        title.backgroundColor=[UIColor clearColor];
        title.textColor=[UIColor darkTextColor];
        title.font=[UIFont systemFontOfSize:12];
        [cell addSubview:title];
        
        UIImageView *addImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth-54, 10, 44, 44)];
        addImageView.image = [UIImage imageNamed:@"icon_chat_photo_normal.png"];
        addImageView.tag = 10;
        [cell addSubview:addImageView];
        UIButton *addImageViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addImageViewButton.backgroundColor = [UIColor clearColor];
        [addImageViewButton addTarget:self action:@selector(picAction:) forControlEvents:UIControlEventTouchUpInside];
        addImageViewButton.frame = addImageView.frame;
        [cell addSubview:addImageViewButton];
        if (indexPath.section==1) {
            title.text = @"图片";
            if (![[resultArray objectAtIndex:3] isEqualToString:@""]) {
                [addImageView setImageWithURL:[NSURL URLWithString:[resultArray objectAtIndex:3]] refreshCache:NO placeholderImage:[UIImage imageNamed:@"icon_chat_photo.normal.png" ]];
            }
            addImageViewButton.tag=1111;
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%d",row+indexPath.section*10];
    SubmitViewCell *cell = (SubmitViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[SubmitViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.backgroundColor=[UIColor whiteColor];
    cell.detail.delegate=self;
    cell.title.font=[UIFont systemFontOfSize:12];\
    cell.detail.font=[UIFont systemFontOfSize:12];
    cell.detail2.font=[UIFont systemFontOfSize:12];
    if(indexPath.section==0){
        cell.detail.frame=CGRectMake(65, 12.5, 225, 18);
        switch (row) {
            case 0:{
                cell.title.text=@"标题";
                cell.title.hidden=NO;
//                cell.detail.inputView = datePicker1;
                cell.detail.placeholder=@"未填写";
                cell.detail.text = [resultArray objectAtIndex:0];
                cell.detail.tag=1;
                
                
                break;
            }
            case 1:{
                cell.title.text=@"简介";
                cell.detail.placeholder=@"未填写";
                cell.detail.tag=2;
                cell.detail.text = [resultArray objectAtIndex:1];
                
                break;
            }
            case 2:{
                cell.title.text=@"科室";
                cell.detail.placeholder=@"未填写";
                cell.detail.inputView = classPicker;
                cell.detail.tag=3;
                cell.detail.text = [resultArray objectAtIndex:2];
                
                break;
            }case 3:{
                cell.title.text=@"内容";
                cell.detail.hidden = YES;
                cell.detail2.delegate = self;
                cell.detail2.frame=CGRectMake(125, 12.5, kDeviceWidth-30-125, 85);
                cell.detail2.placeholder=@"未填写";
                
                break;
            }
                
                
            default:
                break;
        }
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField.tag==3) {
        NSIndexPath *index=[NSIndexPath indexPathForRow:2 inSection:0];
        SubmitViewCell *cell=(SubmitViewCell *)[listView cellForRowAtIndexPath:index];
        if ([classArray1 count]>0) {
            JkDepartment *depart = [self.classArray objectAtIndex:0];
            JkDepartment *depart1 = [self.classArray1 objectAtIndex:0];
            cell.detail.text= [NSString stringWithFormat:@"%@%@",depart.name,depart1.name];
            [resultArray replaceObjectAtIndex:2 withObject:depart1.no];
        }else if ([self.classArray count]>0){
            JkDepartment *depart1 = [self.classArray objectAtIndex:0];
            cell.detail.text= [NSString stringWithFormat:@"%@",depart1.name];
            [resultArray replaceObjectAtIndex:2 withObject:depart1.no];
        }
        
    }
  
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField.tag==1 || textField.tag==2 ) {
        [self.resultArray replaceObjectAtIndex:textField.tag-1 withObject:textField.text];
    }
    
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField.tag==1 || textField.tag==2 ) {
        [self.resultArray replaceObjectAtIndex:textField.tag-1 withObject:textField.text];
    }
    
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    [self.resultArray replaceObjectAtIndex:3 withObject:textView.text];
}

-(void)initPicker{
    FMDatabaseQueue *queue = [[FMDatabaseQueue alloc]initWithPath:[ZUOYLTempHelper getPathForDocuments:@"asiastarbus.db" inDir:@"db"]];
    JkDepartmentDAO* dao = [[JkDepartmentDAO alloc]initWithDbqueue:queue];
    [dao searchWhere:[NSString stringWithFormat:@"parentNo=%d",0] orderBy:@"identity desc" offset:0 count:PAGESIZE callback:^(NSArray *array){
        self.classArray=(NSMutableArray *)array;
    }];
    if ([self.classArray count]>0) {
        JkDepartment *departMent = [self.classArray objectAtIndex:0];
        [dao searchWhere:[NSString stringWithFormat:@"parentNo=%@",departMent.no] orderBy:@"identity desc" offset:0 count:PAGESIZE callback:^(NSArray *array){
            self.classArray1=(NSMutableArray *)array;
        }];
    }
    if (self.classPicker == nil) {
        classPicker=[[UIPickerView alloc]init];
        classPicker.delegate=self;
        classPicker.showsSelectionIndicator=YES;
        classPicker.tag=1;
    }
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    switch (pickerView.tag) {
        case 1:
            return 2;
            break;
        
        default:
            return 1;
            break;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    switch (pickerView.tag) {
        case 1:{
            switch (component) {
                case 0:
                    return [self.classArray count];
                    break;
                case 1:
                    return [self.classArray1 count];
                    break;
                default:
                    return nil;
                    break;
            }
            break;
        }
       
        default:
            return 0;
            break;
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (pickerView.tag) {
        case 1:{
            switch (component) {
                case 0:{
                    JkDepartment *area2=[self.classArray objectAtIndex:row];
                    return area2.name;
                    break;
                }
                default:{
                    JkDepartment *area2=[self.classArray1 objectAtIndex:row];
                    return area2.name;
                    break;
                }
                
            }
            
            break;
        }
        case 2:{
            return [self.classArray objectAtIndex:row];
            break;
        }
        default:
            return nil;
            break;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (pickerView.tag) {
        case 1:{
            NSString *areaFullName=@"";
            switch (component) {
                case 0:{
                    
                    JkDepartment *area1=[self.classArray objectAtIndex:row];
                    FMDatabaseQueue *queue1 = [[FMDatabaseQueue alloc]initWithPath:[ZUOYLTempHelper getPathForDocuments:@"asiastarbus.db" inDir:@"db"]];
                    JkDepartmentDAO* dao1 = [[JkDepartmentDAO alloc]initWithDbqueue:queue1];
                    [dao1 searchWhere:[NSString stringWithFormat:@"parentNo=%@",area1.no] orderBy:@"" offset:0 count:100 callback:^(NSArray *array){
                        self.classArray1=(NSMutableArray *)array;
                    }];
                    if ([self.classArray1 count]>0) {
                        JkDepartment *depart=[self.classArray1 objectAtIndex:0];
                        areaFullName = [NSString stringWithFormat:@"%@%@",area1.name,depart.name];
                        [self.classPicker selectRow:0 inComponent:1 animated:YES];
                        [self.resultArray replaceObjectAtIndex:2 withObject:depart.no];
                       
                    }else{
                        areaFullName= area1.name;
                         [self.resultArray replaceObjectAtIndex:2 withObject:area1.no];
                    }
                    [self.classPicker reloadComponent:1];
                    
                    break;
                }
                
                default:{
                    JkDepartment *area3=[self.classArray1 objectAtIndex:row];
                    areaFullName=area3.name;
                    JkDepartment *depart = [self.classArray objectAtIndex:[pickerView selectedRowInComponent:0]];
                    areaFullName=[NSString stringWithFormat:@"%@%@",area3.name,depart.name];
                    [self.resultArray replaceObjectAtIndex:2 withObject:area3.no];
                    
                    break;
                }
            }
            NSIndexPath *index=[NSIndexPath indexPathForRow:2 inSection:0];
            SubmitViewCell *cell=(SubmitViewCell *)[listView cellForRowAtIndexPath:index];
            cell.detail.text= areaFullName;
            break;
        }
        
        case 7:{
            break;
        }
        default:
            break;
    }
}




-(void)picAction:(id)sender{

        addTag =1;
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"拍照",@"相册",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        
        [self addPhoto];
        
    }else if (buttonIndex==0){
        [self takePhoto];
    }
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
    if (addTag==1) {
        [self sendpic:image];
        UITableViewCell *cell = [listView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
        UIImageView *imageview = (UIImageView *)[cell viewWithTag:10];
        imageview.image = image;
    }
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
//图片压缩
-(UIImage*)imageWithImageSimple:(UIImage *)image scaledToSize:(CGSize)newSize{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
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
    }else if(connection==connection2){
        NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
        NSLog(@"%@",[res allHeaderFields]);
        self.receiveData2 = [NSMutableData data];
    }
}

//接收到服务器传输数据的时候调用，此方法根据数据大小执行若干次

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (connection==connection3) {
        [self.receiveData3 appendData:data];
    }else if (connection==connection1) {
        [self.receiveData1 appendData:data];
    }else if (connection==connection2) {
        [self.receiveData2 appendData:data];
    }
}
//数据传完之后调用此方法
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (connection==connection3) {
        
        NSString *receiveStr = [[NSString alloc]initWithData:self.receiveData3 encoding:NSUTF8StringEncoding];
        NSLog(@"%@",receiveStr);
        
        if ([JsonToModel ifSuccessFromDictionaryData:receiveData3]) {
            [commonAction showToast:@"发布成功" WhithNavigationController:self.navigationController];
            
            
            [self backAction];
            //            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
             [commonAction showToast:[JsonToModel getMessageFromDictionaryData:receiveData3] WhithNavigationController:self.navigationController];
        }
        //        [NSThread detachNewThreadSelector:@selector(saveData) toTarget:self withObject:nil];
    }else if (connection==connection1) {
        
        NSString *receiveStr = [[NSString alloc]initWithData:self.receiveData1 encoding:NSUTF8StringEncoding];
        NSLog(@"%@",receiveStr);
        imageEntity *entity= [JsonToModel objectFromDictionary:[JsonToModel getDictionaryFromDictionaryData:receiveData1] className:@"imageEntity"];
        if (entity != nil) {
            //            headImage = entity.img_center;
            [resultArray replaceObjectAtIndex:4 withObject:entity.img_face];
        }
    }

    
}
//网络请求过程中，出现任何错误（断网，连接超时等）会进入此方法
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@",[error localizedDescription]);
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

