//
//  userCaseTableViewCell.h
//  jiankangyizu
//
//  Created by JEREI on 15-2-5.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface userCaseTableViewCell : UITableViewCell
{
    UILabel *CaseDetail;
    UILabel *caseDate;
    UIImageView *indicator;
}
@property UILabel *CaseDetail;
@property UILabel *caseDate;
@property UIImageView *indicator;
@end
