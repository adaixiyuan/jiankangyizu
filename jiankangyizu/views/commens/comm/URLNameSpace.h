//
//  URLNameSpace.h
//  asiastarbus
//
//  Created by jerei on 14-8-5.
//  Copyright (c) 2014年 jerei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLNameSpace : NSObject
//基础url
//#define BASE_URL @"http://product.21-sun.com/Sync.jsp"
#define IMAGE_URL @"http://xxldata.jerei.com"
//#define BASE_URL @"http://119.254.90.233:1114"
#define BASE_URL @"http://192.168.50.157:9998"


//登录
#define DENGLU_URL @"/appbackend/login/login.jsp"
//注册
#define REGISTER_URL @"/webadmin/action.jsp"

#define GETWARNNUMBER_URL @"/appbackend/warning/warning_info.jsp"

//获取预警详情
#define GETWARNNUMBERDETAIL_URL @"/appbackend/warning/warning_list.jsp"

//获取用户管理列表
#define GETUSERMANAGELIST_URL @"/appbackend/jk_company_user/user_list.jsp"

//通用数据获取
#define COMMONINDEX_URL  @"/appbackend/common/index.jsp"

//获取咨询问题列表
#define GETZIXUNWENTILIST @"/appbackend/jk_consulation/list.jsp"

//通用数据提交
#define SUBMIT_URL @"/appbackend/submit/insert.jsp"


#define SETTINGUPDATE_URL @"/appbackend/setting/update.jsp"

//健康授权
#define JIANKANGSHOUQUAN_URL @"/appbackend/jk_company_user/action.jsp"

//获取消息发送人名单
#define MESSAGEUSER_URL @"/appbackend/jk_message/user_message_list.jsp"

//获取消息数量
#define MESSAGECOUNT_URL @"/appbackend/jk_message/message_count.jsp"

//更新消息为已读
#define MESSAGEUPDATEISREAD_URL @"/appbackend/jk_message/message_update.jsp"
@end
