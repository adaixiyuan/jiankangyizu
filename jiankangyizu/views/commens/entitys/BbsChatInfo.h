/*
 sure
 */

#import <Foundation/Foundation.h>
#import "ZUOYLDAOBase.h"
@interface BbsChatInfoDAO : ZUOYLDAOBase

@end
@interface BbsChatInfo : ZUOYLModelBase{
    NSString *chatId;//TODO 聊天室编
	int sendUserId;//TODO 发送人的编号
	NSString *sendUserName;//TODO 发送人的姓名
	NSString *sendUserFace;//TODO 发送人的头像
	int receiveUserId;//TODO 接受人的编号
	NSString *receiveUserName;//TODO 接受人的姓名
	NSString *receiveUserFace;//TODO 接受人的头像
	NSDate * sendDate;//TODO 发送日期
	NSDate * receiveDate;//TODO 接收日期
	NSString *infoCatalogText;//TODO 标题
	NSString *messageTitle;//TODO 标题
	NSString *messageContent;//TODO 内容
	NSString *resourceFileAddress;//TODO 最后一次发送的文件地址（语音，视频，图片）
	int resourceFileType;//TODO 内容分类  1:动态   2:个人对个人
	int sendStatus;//TODO 发送状态
    double    shareLog ;
    double    shareLat ;
    NSString *   shareAddress ;
    int newMsgCount;//TODO 未查看消息数
}
@property(nonatomic,strong)NSString *chatId;//TODO 聊天室编
@property(nonatomic,assign)int sendUserId;//TODO 发送人的编号
@property(nonatomic,strong)NSString *sendUserName;//TODO 发送人的姓名
@property(nonatomic,strong)NSString *sendUserFace;//TODO 发送人的头像
@property(nonatomic,assign)int receiveUserId;//TODO 接受人的编号
@property(nonatomic,strong)NSString *receiveUserName;//TODO 接受人的姓名
@property(nonatomic,strong)NSString *receiveUserFace;//TODO 接受人的头像
@property(nonatomic,strong)NSDate * sendDate;//TODO 发送日期
@property(nonatomic,strong)NSDate * receiveDate;//TODO 发送日期
@property(nonatomic,strong)NSString *infoCatalogText;//TODO 标题
@property(nonatomic,strong)NSString *messageTitle;//TODO 标题
@property(nonatomic,strong)NSString *messageContent;//TODO 内容
@property(nonatomic,strong)NSString *resourceFileAddress;//TODO 最后一次发送的文件地址（语音，视频，图片）
@property(nonatomic,assign)int resourceFileType;//TODO 内容分类  1:动态   2:个人对个人
@property(nonatomic,assign)int sendStatus;//TODO 发送状态
@property(nonatomic,assign)double    shareLog ;
@property(nonatomic,assign)double    shareLat ;
@property(nonatomic,strong)NSString *   shareAddress ;
@property(nonatomic,assign)int newMsgCount;//TODO 未查看消息数

@end
