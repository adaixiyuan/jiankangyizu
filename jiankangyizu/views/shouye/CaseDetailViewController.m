//
//  CaseDetailViewController.m
//  jiankangyizu
//
//  Created by JEREI on 15-2-5.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "CaseDetailViewController.h"
#import "MyDictionary.h"
#import "CommonStr.h"
#import  "FormDetailCell.h"
#import "SDImageView+SDWebCache.h"
#import "RDVTabBarController.h"
@interface CaseDetailViewController ()

@end

@implementation CaseDetailViewController
@synthesize jkcase;
@synthesize jkUserManage;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav];
     myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight-70)];
     myTableView.delegate = self;
     myTableView.dataSource = self;
    arrayData = [[NSMutableArray alloc] init];
     NSMutableArray *array1 = [[NSMutableArray alloc] init];
    [array1 addObject:[[MyDictionary alloc] initWithName:@"就诊人" Andvale:jkUserManage.name]];
    [array1 addObject:[[MyDictionary alloc] initWithName:@"年龄" Andvale:[NSString stringWithFormat:@"%d",jkUserManage.age]]];
    if(jkUserManage.sex == 0)
    {
       [array1 addObject:[[MyDictionary alloc] initWithName:@"性别" Andvale:@"女"]];
    }
    else if(jkUserManage.sex == 1)
    {
       [array1 addObject:[[MyDictionary alloc] initWithName:@"性别" Andvale:@"男"]];
    }
   
    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc] init];
    [dic1 setObject:array1 forKey:@"病人信息"];
    
    NSMutableArray *array2 = [[NSMutableArray alloc] init];
    [array2 addObject:[[MyDictionary alloc] initWithName:@"时间" Andvale:[CommonStr getDateFormLongSince1970:jkcase.caseDate]]];
    [array2 addObject:[[MyDictionary alloc] initWithName:@"医院" Andvale:jkcase.hospital]];
    [array2 addObject:[[MyDictionary alloc] initWithName:@"科室" Andvale:jkcase.departmentNo]];
    [array2 addObject:[[MyDictionary alloc] initWithName:@"病症" Andvale:jkcase.resultContent]];
    NSMutableDictionary *dic2 = [[NSMutableDictionary alloc] init];
    [dic2 setObject:array2 forKey:@"就诊信息"];
    
    NSMutableArray *array3 = [[NSMutableArray alloc] init];
    [array3 addObject:[[MyDictionary alloc] initWithName:@"" Andvale:jkcase.resultImg]];
    NSMutableDictionary *dic3 = [[NSMutableDictionary alloc] init];
    [dic3 setObject:array3 forKey:@"检查报告"];
    
    NSMutableArray *array4 = [[NSMutableArray alloc] init];
    [array4 addObject:[[MyDictionary alloc] initWithName:@"医生处方内容" Andvale:jkcase.prescriptionContent]];
    NSMutableDictionary *dic4 = [[NSMutableDictionary alloc] init];
    [dic4 setObject:array4 forKey:@"处方内容"];
    
    [arrayData addObject:dic1];
    [arrayData addObject:dic2];
    [arrayData addObject:dic3];
    [arrayData addObject:dic4];
    
    [self.view addSubview:myTableView];
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
    [backBtn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame=CGRectMake(0, 0,52, 42);//52, 42
    UILabel *backLabel=[[UILabel alloc]initWithFrame:CGRectMake(52, 0, 300, 42)];
    backLabel.backgroundColor=[UIColor clearColor];
    backLabel.textColor=YINGYONG_COLOR;
    backLabel.textAlignment=NSTextAlignmentLeft;
    backLabel.font=[UIFont boldSystemFontOfSize:23];
    backLabel.text=@"用户病例详情";
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     return arrayData.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *diction = [arrayData objectAtIndex:section];
    NSArray *keys = [diction allKeys];
    NSArray *array = [diction objectForKey:[keys objectAtIndex:0]];
    
    return array.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    FormDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSString *text;
    NSDictionary *diction = [arrayData objectAtIndex:indexPath.section];
    NSArray *keys = [diction allKeys];
    NSArray *array = [diction objectForKey:[keys objectAtIndex:0]];
    MyDictionary *dictionary = [array objectAtIndex:indexPath.row];
    if (cell == nil) {
         cell = [[FormDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    if(indexPath.section == 2)
    {
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 200)];
         [imageview setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dictionary.value]]refreshCache:NO placeholderImage:[UIImage imageNamed:@"icon.png"]];
        cell.lablevalue.hidden=YES;
        cell.lablename.hidden=YES;
        [cell.contentView addSubview:imageview];
    }
    else
    {
    
    text = dictionary.value;
    cell.lablevalue.text = text;
    cell.lablename.text = dictionary.name;
    }
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 2)
    {
        return 200;
    }
    else{
      return 50;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 44)];
    [view setBackgroundColor:[UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:1]];
   
    UILabel *titlelable = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, kDeviceWidth, 44)];
    titlelable.textAlignment = NSTextAlignmentLeft;
   
    titlelable.textColor = LIGHTBLUECOLOR;
    NSDictionary *diction = [arrayData objectAtIndex:section];
    NSArray *keys = [diction allKeys];
    titlelable.text = [keys objectAtIndex:0];
    [view addSubview:titlelable];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
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
