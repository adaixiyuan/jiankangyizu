//
//  KnowledgeAddView.m
//  jiankangyizu
//
//  Created by JEREI on 15-2-11.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "KnowledgeAddView.h"
#import "MyDictionary.h"
#import "CommonUser.h"
#import "MLTableAlert.h"
#import "JkDepartment.h"
#import "commonAction.h"
#import "ChangeData.h"
#import "imageEntity.h"
#import "RDVTabBarController.h"
@interface KnowledgeAddView ()
{
    UITableView *myTableView;
    UILabel *lable ;
    UITextField *textfield ;
    UITextField *jianjietextfield ;
    UITextView *detailTextView;
    UIButton *fujianbtn;
    CommonUser *user;
    UIButton *departmentBtn;
    MLTableAlert *alert;
    NSMutableArray *departmentList;
    UIImageView *fujianimage;

}
@end

@implementation KnowledgeAddView
@synthesize connection1;
@synthesize receiveData1;


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav];
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    user = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight-100)];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.scrollEnabled = NO;
    dataList = [[NSMutableArray alloc] init];
    NSMutableArray *array1 = [[NSMutableArray alloc] init];
    [array1 addObject:[[MyDictionary alloc] initWithName:@"标题" Andvale:@"未填写"]];
    [array1 addObject:[[MyDictionary alloc] initWithName:@"简介" Andvale:@"未填写"]];
    [array1 addObject:[[MyDictionary alloc] initWithName:@"科室" Andvale:@"未填写"]];
    [array1 addObject:[[MyDictionary alloc] initWithName:@"详情" Andvale:@"未填写"]];
    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc] init];
    [dic1 setObject:array1 forKey:@"q1"];
    
    NSMutableArray *array2 = [[NSMutableArray alloc] init];
    [array2 addObject:[[MyDictionary alloc] initWithName:@"附件" Andvale:@"未填写"]];
    NSMutableDictionary *dic2 = [[NSMutableDictionary alloc] init];
    [dic2 setObject:array2 forKey:@"q2"];
    [dataList addObject:dic1];
    [dataList addObject:dic2];
    [self.view addSubview:myTableView];

    FMDatabaseQueue *queue = [[FMDatabaseQueue alloc]initWithPath:[ZUOYLTempHelper getPathForDocuments:@"asiastarbus.db" inDir:@"db"]];

    departmentList = [[NSMutableArray alloc] init];
    JkDepartmentDAO *departmentdao = [[JkDepartmentDAO alloc] initWithDbqueue:queue];
    [departmentdao searchAll:^(NSArray *array){
        int i;
        for (i = 0; i < [array count]; i++) {
            JkDepartment *department = array[i];
            [departmentList addObject:[NSDictionary dictionaryWithObject:department.name forKey:department.no]];
            
        }
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initNav{
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"tb_navbar.png"] forBarMetrics:UIBarMetricsDefault];
    }
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"common_top_back_icon.png"] forState:UIControlStateNormal];
    backBtn.frame=CGRectMake(0, 0,30.5, 42);//52, 42
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
   
    UIButton *saveBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:YINGYONG_COLOR forState:UIControlStateNormal];
    saveBtn.frame=CGRectMake(0, 0,70.5, 42);//52, 42
    [saveBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];

    
    UILabel *backLabel=[[UILabel alloc]initWithFrame:CGRectMake(32, 0, kDeviceWidth-41, 42)];
    backLabel.backgroundColor=[UIColor clearColor];
    backLabel.textColor=YINGYONG_COLOR;
    backLabel.textAlignment=NSTextAlignmentLeft;
    backLabel.font=[UIFont boldSystemFontOfSize:23];
    backLabel.text=@"知识库添加";
    UIView *backView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth-71, 42)];
    backView1.backgroundColor=[UIColor clearColor];
    [backView1 addSubview:backBtn];
    [backView1 addSubview:backLabel];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backView1];
    UIBarButtonItem *saveButtonItem = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    self.navigationItem.rightBarButtonItem = saveButtonItem;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataList.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *diction = [dataList objectAtIndex:section];
    NSArray *keys = [diction allKeys];
    NSArray *array = [diction objectForKey:[keys objectAtIndex:0]];
    return array.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSString *text;
    NSDictionary *diction = [dataList objectAtIndex:indexPath.section];
    NSArray *keys = [diction allKeys];
    NSArray *array = [diction objectForKey:[keys objectAtIndex:0]];
    MyDictionary *dictionary = [array objectAtIndex:indexPath.row];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        lable = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kDeviceWidth/3, 20)];
        lable.textColor = [UIColor blackColor];
        if(indexPath.section == 1)    //处于附件那一列
        {
            fujianbtn = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth/3+10, 10, kDeviceWidth-(kDeviceWidth/3-10), 70)];
            [fujianbtn addTarget:self action:@selector(selectfujian) forControlEvents:UIControlEventTouchUpInside];
            fujianimage = [[UIImageView alloc] initWithFrame:CGRectMake(70, 5, 50, 50)];
            fujianimage.image = [UIImage imageNamed:@"icon_chat_photo_normal.png"];
            [fujianbtn addSubview:fujianimage];
            [cell.contentView addSubview:fujianbtn];
        }
        else if(indexPath.section == 0 && indexPath.row == 2) //处于科室那一列
        {
            departmentBtn = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth/3+10, 10, kDeviceWidth-(kDeviceWidth/3-10), 20)];
            [departmentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [departmentBtn addTarget:self action:@selector(queryBySelected) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:departmentBtn];
            
        }
        else if(indexPath.row == 0)
        {
            textfield = [[UITextField alloc] initWithFrame:CGRectMake(kDeviceWidth/3+10, 10, kDeviceWidth-(kDeviceWidth/3-10), 20)];
            textfield.tintColor = BACK_COLOR;
            textfield.placeholder =  dictionary.value;
            textfield.delegate = self;
            textfield.tag = 0;
           
            
            UIToolbar * keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 38.0f)];
            keyboardToolbar.barStyle = UIBarStyleBlackTranslucent;
            keyboardToolbar.tag = 100+indexPath.row;
            UIBarButtonItem *spaceBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                          target:nil
                                                                                          action:nil];
            
            UIBarButtonItem *doneBarItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"完成", @"")
                                                                            style:UIBarButtonItemStyleDone
                                                                           target:textfield
                                                                           action:@selector(resignFirstResponder)];
            
            [keyboardToolbar setItems:[NSArray arrayWithObjects:spaceBarItem, doneBarItem, nil]];
            textfield.inputAccessoryView = keyboardToolbar;

            [cell.contentView addSubview:textfield];

        }
        else if(indexPath.row == 1)
        {
            jianjietextfield = [[UITextField alloc] initWithFrame:CGRectMake(kDeviceWidth/3+10, 10, kDeviceWidth-(kDeviceWidth/3-10), 20)];
            jianjietextfield.tintColor = BACK_COLOR;
            jianjietextfield.placeholder =  dictionary.value;
            jianjietextfield.delegate = self;
            jianjietextfield.tag = 1;
            [cell.contentView addSubview:jianjietextfield];

            
            UIToolbar * keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 38.0f)];
            keyboardToolbar.barStyle = UIBarStyleBlackTranslucent;
            keyboardToolbar.tag = 100+indexPath.row;
            UIBarButtonItem *spaceBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                          target:nil
                                                                                          action:nil];
            
            UIBarButtonItem *doneBarItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"完成", @"")
                                                                            style:UIBarButtonItemStyleDone
                                                                           target:jianjietextfield
                                                                           action:@selector(resignFirstResponder)];
            
            [keyboardToolbar setItems:[NSArray arrayWithObjects:spaceBarItem, doneBarItem, nil]];
            jianjietextfield.inputAccessoryView = keyboardToolbar;
            
            
        }

       
         else if(indexPath.row == 3)
   //处于详情那一列
        {
         detailTextView = [[UITextView alloc] initWithFrame:CGRectMake(kDeviceWidth/3+10, 10, kDeviceWidth-(kDeviceWidth/3-10), 200)];
         detailTextView.tintColor = BACK_COLOR;
            detailTextView.delegate = self;
            detailTextView.tag = 4;
        [cell.contentView addSubview:detailTextView];
        
            UIToolbar * keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 38.0f)];
            keyboardToolbar.barStyle = UIBarStyleBlackTranslucent;
            keyboardToolbar.tag = 100+indexPath.row;
            UIBarButtonItem *spaceBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                          target:nil
                                                                                          action:nil];
            
            UIBarButtonItem *doneBarItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"完成", @"")
                                                                            style:UIBarButtonItemStyleDone
                                                                           target:detailTextView
                                                                           action:@selector(resignFirstResponder)];
            
            [keyboardToolbar setItems:[NSArray arrayWithObjects:spaceBarItem, doneBarItem, nil]];
            detailTextView.inputAccessoryView = keyboardToolbar;
            
        }
        [cell.contentView addSubview:lable];
        
}
    if(indexPath.section == 1)
    {
       lable.frame =  CGRectMake(10, 30, kDeviceWidth/3, 20);
    }
    text = dictionary.value;
    lable.text = dictionary.name;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 3)
    {
        return 200;
    }
    else if(indexPath.section == 1)
    {
        return 80;
    }
    else
    {
       return 50;
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 20)];
    [view setBackgroundColor:BACK_COLOR];
    
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
   if(section == 0)
   {
       return 0;
   }
   else
   {
       return 20;
   }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (void)goBack
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textfield resignFirstResponder];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
//    NSLog(@"texttag:%ld",textfield.tag);
//     switch((int)textfield.tag)
//    {
//        case 0:  //标题
//        {
//          title = textfield.text;
//        }
//        break;
//            
//        case 1://简介
//        {
//            summary = textfield.text;
//        }
//            break;
//    }
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
//    switch(textfield.tag)
//    {
//        case 0:  //标题
//        {
//            title = textfield.text;
//        }
//            break; //简介
//        case 1:
//        {
//            summary = textfield.text;
//        }
//            break;
//}
   
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
     detail = textView.text;
        return YES;
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    
    detail = textView.text;
    
}



//保存
-(void)save
{
    if([title isEqualToString:@""])
    {
        [commonAction showToast:@"请填写标题"];
    }
    else if([summary isEqualToString:@""])
    {
     [commonAction showToast:@"请填写简介"];
    }
    else if([fujian  isEqualToString:@""])
    {
     [commonAction showToast:@"请选择附件"];
    }
    else if([department isEqualToString:@""])
    {
       [commonAction showToast:@"请填写科室"];
    }
    else if([detailTextView.text isEqualToString:@""])
    {
      [commonAction showToast:@"请填写详情"];
    }
    else
    {
      UIAlertView  *alertview = [[UIAlertView alloc]initWithTitle:@"提示！" message:@"确定保存？" delegate:self
                                                              cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
               [alertview show];
   
     }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 1:
        {
            title = textfield.text;
            summary = jianjietextfield.text;
            //1.确定地址nsurl
            NSString *urlString = [NSString stringWithFormat:@"%@%@?table_name=jk_news&obj.add_user=%@&obj.title=%@&obj.img=%@&obj.summary=%@&obj.content=%@&obj.department_no=%@&obj.user_id=%d",BASE_URL,SUBMIT_URL,user.name,title,fujian,summary,detail,department,user.identity];
            
            NSURL *url = [NSURL URLWithString:urlString];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];   //get请求方式
            /*
             同步请求
             */
            @autoreleasepool {
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSURLResponse *respons = nil;
                    NSError *error = nil;
                    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&respons error:&error];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if(data != nil)
                        {
                            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                            //                    jkWarnNumber  = [JsonToModel objectFromDictionaryData:data className:@"JKWarnNumber"];
                            
                            [self.navigationController popToRootViewControllerAnimated:YES];
                            
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
        
        break;
            
        default:
            break;
    }
}
//选择附件
- (void)selectfujian
{
    [self picAction];
    
}
#pragma mark 添加照片
-(void)picAction{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"拍照",@"相册",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}
#pragma mark    actionsheet 处理事件
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            [self takePhoto];
        }
            break;
            
        case 1:
        {
            [self addPhoto];
        }
            
            break;
    }
}
#pragma mark 添加照片
- (void)addPhoto
{
    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.navigationBar.tintColor = [UIColor colorWithRed:50.0/255.0 green:150.0/255.0 blue:28.0/255.0 alpha:1.0];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = NO;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

#pragma mark 照相
- (void)takePhoto
{
    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = NO;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}


#pragma mark  图片选择后处理结果
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage * image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    fujianimage.image=image;
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
#pragma mark 图片上传
-(void)sendpic:(UIImage *)image2{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,@"/file/upload.jsp"]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:111111];
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

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response

{
    
        NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
        NSLog(@"%@",[res allHeaderFields]);
        self.receiveData1 = [NSMutableData data];
    
}

//接收到服务器传输数据的时候调用，此方法根据数据大小执行若干次

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
        [self.receiveData1 appendData:data];
    
}
//数据传完之后调用此方法
#pragma mark 照片上传完后结果
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
            NSString *receiveStr = [[NSString alloc]initWithData:self.receiveData1 encoding:NSUTF8StringEncoding];
        NSLog(@"%@",receiveStr);
        imageEntity *entity= [JsonToModel objectFromDictionary:[JsonToModel getDictionaryFromDictionaryData:receiveData1] className:@"imageEntity"];
        if (entity != nil) {
            fujian = entity.img_center;
        }
    
    
}


//网络请求过程中，出现任何错误（断网，连接超时等）会进入此方法
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@",[error localizedDescription]);
}




//图片压缩
-(UIImage*)imageWithImageSimple:(UIImage *)image scaledToSize:(CGSize)newSize{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//科室选择
- (void)queryBySelected
{
    
    alert = [MLTableAlert tableAlertWithTitle:@"Choose an option..." cancelButtonTitle:@"关闭" numberOfRows:^NSInteger (NSInteger section)
             {
                 if ([departmentList count] == 0)
                     return 1;
                 else
                     return [departmentList count];
             }
                                     andCells:^UITableViewCell* (MLTableAlert *anAlert, NSIndexPath *indexPath)
             {
                 static NSString *CellIdentifier = @"CellIdentifier";
                 UITableViewCell *cell = [anAlert.table dequeueReusableCellWithIdentifier:CellIdentifier];
                 NSDictionary *diction = departmentList[indexPath.row];
                 NSString *key = [diction allKeys][0];
                 NSString *value = [diction objectForKey:key];
                 if (cell == nil)
                     cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                 //输入值
                 cell.textLabel.text = value;
                 
                 return cell;
             }];
    
    // Setting custom alert height
    
    if (44 *[departmentList count] > 350)
    {
        alert.height = 350;
    }
    else
    {
        alert.height = 44 *[departmentList count];
    }
    
    
    // 返回值
    [alert configureSelectionBlock:^(NSIndexPath *selectedIndex){
        NSDictionary *diction = departmentList[selectedIndex.row];
        NSString *key = [diction allKeys][0];
        NSString *value = [diction objectForKey:key];
        [departmentBtn setTitle:value forState:UIControlStateNormal];
        department = key;
    } andCompletionBlock:^{
        
    }];
    [alert show];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
}
@end
