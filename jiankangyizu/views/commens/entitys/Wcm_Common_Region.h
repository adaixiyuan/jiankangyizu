//
//  Wcm_Common_Region.h
//  asiastarbus
//
//  Created by apple on 14-8-29.
//  Copyright (c) 2014年 jerei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZUOYLDAOBase.h"
@interface Wcm_Common_RegionDao : ZUOYLDAOBase

@end
@interface Wcm_Common_Region : ZUOYLModelBase
{
    int identity;
    NSString *uuid;
    NSString *first_letter;
    NSString *area_name;
    int parent_area_id;
    NSString *node_path;
    NSString *node_full_name;
    int level_id;
    int show_order;
    int is_use;
    NSString *remark;
}
@property(nonatomic,assign)int identity;
@property(nonatomic,strong)NSString *uuid;
@property(nonatomic,strong)NSString *first_letter;
@property(nonatomic,strong)NSString *area_name;
@property(nonatomic,assign)int parent_area_id;
@property(nonatomic,strong)NSString *node_path;
@property(nonatomic,strong)NSString *node_full_name;
@property(nonatomic,assign)int level_id;
@property(nonatomic,assign)int show_order;
@property(nonatomic,assign)int is_use;
@property(nonatomic,strong)NSString *remark;
@end
