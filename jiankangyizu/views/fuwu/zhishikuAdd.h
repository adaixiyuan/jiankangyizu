//
//  zhishikuAdd.h
//  jiankangyizu
//
//  Created by apple on 15/2/12.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RDVTabBarController.h"
#import "JkDepartment.h"
#import "CommonUser.h"
@interface zhishikuAdd : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIPickerViewDelegate,UITextViewDelegate>
{
    UITableView *listView;
    int addTag;
    NSString *imageFile1;
    NSString *imageFile2;
    CommonUser *user;
    
}
@property(nonatomic,strong)UIPickerView *classPicker;
@property(nonatomic,strong)NSMutableArray *classArray;
@property(nonatomic,strong)NSMutableArray *classArray1;
@property(nonatomic,strong)NSMutableArray *resultArray;
@property(nonatomic,strong)UIDatePicker *datePicker1;
@property(nonatomic,strong)NSURLConnection *connection1;
@property(nonatomic,strong)NSMutableData *receiveData1;
@property(nonatomic,strong)NSURLConnection *connection2;
@property(nonatomic,strong)NSMutableData *receiveData2;
@property(nonatomic,strong)NSURLConnection *connection3;
@property(nonatomic,strong)NSMutableData *receiveData3;
@end
