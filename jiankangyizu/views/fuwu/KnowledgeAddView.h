//
//  KnowledgeAddView.h
//  jiankangyizu
//
//  Created by JEREI on 15-2-11.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KnowledgeAddView : UIViewController <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate,UIAlertViewDelegate,UIPickerViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSString *title;
    NSString *summary;
    NSString *department;
    NSString *detail;
    NSString *fujian;
    NSMutableArray *dataList;
}
@property(nonatomic,strong)NSURLConnection *connection1;
@property(nonatomic,strong)NSMutableData *receiveData1;
@end
