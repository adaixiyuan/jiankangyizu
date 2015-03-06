//
//  geRenXinXi.h
//  ViewDeckExample
//
//  Created by apple on 14-5-13.
//  Copyright (c) 2014年 Adriaenssen BVBA. All rights reserved.
//



#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

#import "CommonUser.h"

@interface geRenXinXi : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate,UIActionSheetDelegate,UIPickerViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    UITableView *listView;
    
    UIPickerView *positionPicker;
    UIPickerView *positionPicker2;
    
    UIPickerView *classPicker;
    UIPickerView *jobPicker;

    NSMutableData *readData;

    
    NSMutableArray *classArray;
    NSMutableArray *jobArray;
    CommonUser *singleInfo;
    NSMutableArray *provinces;
    NSMutableArray *cities;
    NSMutableArray *districts;
    
    NSMutableArray *resultArray;
    UIPickerView *youxiaoqiPiker;
    NSMutableArray *youxiaoqiArray;
    UIPickerView *productPicker;
    NSMutableArray *productArray;
    
    UIPickerView *jingyanPicker;
    NSMutableArray *jingyanArray;
    
    UIPickerView *xinjinPicker;
    NSMutableArray *xinjinArray;
    int isDone;
    int  isSanyi;
     NSString *headImage;
    
   }
@property(nonatomic,strong)UIDatePicker *datePicker;
@property(nonatomic,strong)NSURLConnection *connection3;
@property(nonatomic,strong)NSMutableData *receiveData3;
@property(nonatomic,strong)NSURLConnection *connection1;
@property(nonatomic,strong)NSMutableData *receiveData1;
@property(nonatomic,strong)UITableView *listView;
@property(nonatomic,strong)UIPickerView *positionPicker;
@property(nonatomic,strong)UIPickerView *positionPicker2;
@property(nonatomic,strong)UIPickerView *classPicker;
@property(nonatomic,strong)UIPickerView *jobPicker;
@property(nonatomic,strong)UIPickerView *youxiaoqiPiker;
@property(nonatomic,strong)UIPickerView *productPicker;
@property(nonatomic,strong)NSMutableArray *productArray;
@property(nonatomic,strong)UIPickerView *jingyanPicker;
@property(nonatomic,strong)NSMutableArray *jingyanArray;

@property(nonatomic,strong)UIPickerView *xinjinPicker;
@property(nonatomic,strong)NSMutableArray *xinjinArray;

@property(nonatomic,strong)NSMutableData *readData;

@property(nonatomic,strong)NSMutableArray *classArray;
@property(nonatomic,strong)NSMutableArray *jobArray;
@property(nonatomic,strong)CommonUser *singleInfo;
@property(nonatomic,strong)NSMutableArray *resultArray;
@property(nonatomic,strong)NSMutableArray *provinces;
@property(nonatomic,strong)NSMutableArray *cities;
@property(nonatomic,strong)NSMutableArray *districts;
@property(nonatomic,strong)NSMutableArray *youxiaoqiArray;
@property(nonatomic,assign)int isfirtview;
-(void)initPickerView;
-(id)getFirstResponder;
-(void)setExtraCellLineHidden: (UITableView *)tableView;
- (BOOL)valueIsPhone:(NSString*)str;

@end
