//
//  ChatDetailView.h
//  ViewDeckExample
//
//  Created by apple on 13-2-20.
//  Copyright (c) 2013年 Adriaenssen BVBA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "RecordHUD2.h"
#import "iToast.h"
#import "BbsChatInfo.h"
#import "CommonUser.h"
#import "BbsMemberFriend.h"
#import "BbsMember.h"
#import "BbsMemberAttention.h"
#import "XMPPFramework.h"
#import "BubbleView.h"
#import "WcmCmsMemberMessage.h"
#import "CreateChatObject.h"
#import "ChatData.h"
#import "JkMessage.h"
#import "PullingRefreshTableView.h"
#import "ChatFaceView.h"

@class XMPPMessage;

@interface ChatDetailView : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UIGestureRecognizerDelegate,AVAudioPlayerDelegate,AVAudioRecorderDelegate,PullingRefreshTableViewDelegate,ChatFaceViewDelegate>{
    __strong XMPPMessage *oneMessage;
    BOOL isMySpeaking;
    PullingRefreshTableView *listView;
    NSMutableArray *listArray;
    NSString *navTitle;
    UIToolbar *toolBar;
    UITextField *input;
    UIButton *voice;
    UIButton *yuyin;
    UIButton *tool;
    UIButton *send;
    UIButton *wenzi;
    UIImageView *voiceImage;
    UILabel *voiceLabel;
    UIImageView *voiceLogo;
    UIView *toolView;
    UIButton *face;
    UIButton *pic;
    UIButton *position;
    UIButton *video;
    RecordHUD2 *recordHUD;
    BOOL toolHide;
    int keyHeight;
    ChatFaceView *faceView;
//    UIScrollView *faceScroll;
    AVAudioRecorder *_avRecorder;
    AVAudioPlayer *_avPlayer;
    NSString *_strMp3Path;
    NSString *_lastRecordFileName;
    NSDate *beginRcd;
    NSDate *endRcd;
    BbsChatInfo *chatInfo2;
    CommonUser *singleInfo;
    BbsMemberFriend *memberFriend;
    BbsMember *member;
    BbsMemberAttention *attention;
    int flag;
    int userId;
    CreateChatObject *createChatObject;
    ChatData *chatData;
    NSMutableData *readData;
    BOOL sendState;
    BOOL selectSendSuccess;
    int selectRow;
    int sendRow;
    int playRow;
    int sendType;
    NSInteger page;
    BOOL refreshing;
    //其他方式进入聊天
    int qitaId;
    NSString *qitaFace;
    JkMessage *jkMessage;
    JkMessageDAO* dao;
    
    
}
@property(nonatomic,assign)int sendMessageFlag;
@property(nonatomic,assign)int toMemberId;
@property(nonatomic,strong)NSString *toMemberHeadImg;
@property(nonatomic,strong)NSMutableArray *localArray;
@property(nonatomic,strong)XMPPMessage *oneMessage;
@property(nonatomic,strong)PullingRefreshTableView *listView;
@property(nonatomic,strong)NSMutableArray *listArray;
@property(nonatomic,strong)NSString *navTitle;
@property(nonatomic,strong)UIToolbar *toolBar;
@property(nonatomic,strong)UIView *toolView;
@property(nonatomic,strong)UITextField *input;
@property(nonatomic,strong)UILabel *voiceLabel;
@property(nonatomic,strong)UIImageView *voiceImage;
@property(nonatomic,strong)UIImageView *voiceLogo;
@property(nonatomic,strong)RecordHUD2 *recordHUD;
@property(nonatomic,strong)ChatFaceView *faceView;
@property(nonatomic,strong)NSString *_lastRecordFileName;
@property(nonatomic,strong)BbsChatInfo *chatInfo2;
@property(nonatomic,strong)CommonUser *singleInfo;
@property(nonatomic,strong)BbsMemberFriend *memberFriend;
@property(nonatomic,strong)BbsMember *member;
@property(nonatomic,strong)BbsMemberAttention *attention;
@property(nonatomic,assign)int flag;
@property(nonatomic,assign)int backflag;
@property(nonatomic,assign)int userId;
@property(nonatomic,strong)CreateChatObject *createChatObject;
@property(nonatomic,strong)ChatData *chatData;
@property(nonatomic,strong)NSMutableData *readData;
@property(nonatomic,assign)int selectRow;
@property(nonatomic,assign)int sendRow;
@property(nonatomic,assign)int playRow;
@property(nonatomic,assign)int sendType;
@property(nonatomic,strong)NSDate *beginRcd;
@property(nonatomic,strong)NSDate *endRcd;
@property(nonatomic,assign) NSInteger page;
@property(nonatomic,assign) BOOL refreshing;
@property(nonatomic,assign)int qitaId;
@property(nonatomic,strong)NSString *qitaFace;
@property(nonatomic,strong)NSURLConnection *connection1;
@property(nonatomic,strong)NSMutableData *receiveData1;
@property(nonatomic,strong)UIView *overlay;
-(void)initToolView;
-(void)showToast:(NSString *)contents;
-(void)initFaceView;
-(NSString *)getDateWithString:(NSDate *)_date;

//1文字 2音频 3照片 4视频 5位置 6联系人
//对获得的数据进行打包处理，绘制成一个UIView，以便在TableView上显示
-(BubbleView *)bubbleView:(NSString *)text from:(BOOL)fromSelf date:(NSDate *)now success:(BOOL)success;
-(BubbleView *)bubbleView2:(UIImage *)image from:(BOOL)fromSelf date:(NSDate *)now success:(BOOL)success;
-(BubbleView *)bubbleView3:(NSString *)text from:(BOOL)fromSelf date:(NSDate *)now isNew:(BOOL)isNew success:(BOOL)success;
-(BubbleView *)bubbleView4:(UIImage *)image from:(BOOL)fromSelf date:(NSDate *)now isNew:(BOOL)isNew success:(BOOL)success time:(int)second;
-(BubbleView *)bubbleView5:(NSString *)text from:(BOOL)fromSelf date:(NSDate *)now success:(BOOL)success;
//图文信息 & 动态
-(BubbleView *)bubbleView6:(WcmCmsMemberMessage *)_message;

//增加消息
-(void)addNewMessageView:(WcmCmsMemberMessage *)_message;

//-(void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message;

-(void)toMp3:(NSString*)cafFileName;

//数据处理
-(void)sendMessage:(WcmCmsMemberMessage *)message uuid:(NSString *)_uuid;
-(void)connectServer:(NSString *)hostIP port:(int)hostPort;
-(BOOL)connectedToNetWork;
-(NSString *)uuid;
-(void)deleteAction:(int)type;

-(void)saveMessage:(WcmCmsMemberMessage *)_message;

//根据视频url播放视频
- (void) playVideo:(NSURL *) movieURL;

//音频播放布局
-(void)stopAvplayer:(int)row;

@end
