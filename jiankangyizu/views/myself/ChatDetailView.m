//
//  ChatDetailView.m
//  ViewDeckExample
//
//  Created by apple on 13-2-20.
//  Copyright (c) 2013年 Adriaenssen BVBA. All rights reserved.
//

#import "ChatDetailView.h"
#import <QuartzCore/QuartzCore.h>
//#import "lame.h"
#import "CheckImage.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <netdb.h>
#import "SDImageView+SDWebCache.h"
#import "SerializableValueObject.h"
#import "ChangeData.h"
#import "CreateImage.h"
#import "SendResult.h"

#import "ChatDetailCell.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "CheckNewsView.h"
#import "GetChatLabelSize.h"
#import "WcmCmsMemberMessage.h"
#import "commonAction.h"
#import "commonJudgeMent.h"
#import "NotificationMessageCell.h"
#import "notificationMessage.h"
#import "RDVTabBarController.h"
#import "MyDictionary.h"
#import "JkMessage.h"
@interface UIImagePickerController (LandScapeImagePicker)

- (BOOL)shouldAutorotate;

@end

@implementation UIImagePickerController (LandScapeImagePicker)

- (BOOL)shouldAutorotate {
    
    return NO;
}

@end
@implementation ChatDetailView
@synthesize oneMessage,listView,listArray,toolBar,toolView,input,voiceLabel,voiceImage,voiceLogo,recordHUD,faceView,_lastRecordFileName,navTitle,chatInfo2,singleInfo,memberFriend,member,attention,flag,userId,readData,createChatObject,chatData,sendRow,playRow,selectRow,sendType,beginRcd,endRcd,page,refreshing,qitaId,qitaFace;
@synthesize localArray;
@synthesize backflag;
@synthesize connection1;
@synthesize receiveData1;
@synthesize overlay;
@synthesize sendMessageFlag;
@synthesize toMemberId;
@synthesize toMemberHeadImg;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    // 键盘高度变化通知，ios5.0新增的  
#ifdef __IPHONE_5_0
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 5.0) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
#endif
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
}

#pragma mark - View lifecycle
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNav];
    jkMessage = [[JkMessage alloc] init];
    self.view.backgroundColor=BACK_COLOR;
    overlay = [[UIView alloc]init];;
    UIImageView *imageback=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight)];
    imageback.image=[UIImage imageNamed:@"first_back.png"];
    [self.view addSubview:imageback];
    
    page=0;
    
    listArray=[[NSMutableArray alloc]initWithCapacity:0];
    NSData *userData=[[NSUserDefaults standardUserDefaults]objectForKey:@"user"];
    singleInfo= [NSKeyedUnarchiver unarchiveObjectWithData:userData];
  
    userId=singleInfo.identity;

    
    int otherId=0;
    if (chatInfo2.chatId) {
        otherId=chatInfo2.sendUserId;
    }else if(memberFriend.identity){
        otherId=memberFriend.friendMemberId;
        if (chatData==nil) {
            chatData=[[ChatData alloc]init];
        }
        BbsChatInfo *chatInfo=[chatData getChat:otherId chatId:@""];
        if (chatInfo) {
            self.chatInfo2=chatInfo;
        }
    }else if(member.identity){
        otherId=member.identity;
        if (chatData==nil) {
            chatData=[[ChatData alloc]init];
        }
        BbsChatInfo *chatInfo=[chatData getChat:otherId chatId:@""];
        if (chatInfo) {
            self.chatInfo2=chatInfo;
        }
    }else if(attention.identity){
        otherId=attention.memberId;
        if (chatData==nil) {
            chatData=[[ChatData alloc]init];
        }
        BbsChatInfo *chatInfo=[chatData getChat:otherId  chatId:@""];
        if (chatInfo) {
            self.chatInfo2=chatInfo;
        }
    }else{
        otherId=qitaId;
        if (chatData==nil) {
            chatData=[[ChatData alloc]init];
        }
        BbsChatInfo *chatInfo=[chatData getChat:otherId chatId:@""];
        if (chatInfo) {
            self.chatInfo2=chatInfo;
        }
    }
    
   
    FMDatabaseQueue *queue = [[FMDatabaseQueue alloc]initWithPath:[ZUOYLTempHelper getPathForDocuments:@"asiastarbus.db" inDir:@"db"]];
    dao = [[JkMessageDAO alloc]initWithDbqueue:queue];
//    [dao searchWhere:[NSString stringWithFormat:@"toMemberId=%d and memberId=%d",toMemberId,singleInfo.identity] orderBy:@"identity desc" offset:0 count:PAGESIZE callback:^(NSArray *array){
//        self.localArray=(NSMutableArray *) [[array reverseObjectEnumerator] allObjects];
//        
//        
//    }];
    self.refreshing = YES;
    [self loadData];
    
//    JkMessage *message = [[JkMessage alloc]init];
//    message.messageTypeId=1;
//    message.textMessage = @"欢迎您，多多健康";
//    message.flag=1;
//    message.addDate = PROJECTSID;
//    message.sid = PROJECTSID;
//    if ([self.localArray count]>0) {
//        [self.localArray insertObject:message atIndex:0];
//    }else{
//        [self.localArray addObject:message];
//    }
//     self.localArray = (NSMutableArray *)[[self.localArray reverseObjectEnumerator]allObjects];
//    if ([self.localArray count]>0) {
//        NSArray *localArray2=[[self.localArray reverseObjectEnumerator] allObjects];
////        [NSThread detachNewThreadSelector:@selector(createLocalList:) toTarget:self withObject:localArray2];
//        [self createLocalList:localArray2];
//    }
    listView=[[PullingRefreshTableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight-44-60) pullingDelegate:self];
    listView.delegate=self;
    listView.dataSource=self;
    listView.backgroundColor = [UIColor clearColor];
    listView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:listView];
    
    [self initToolView];
    
    //创建语音和图片文件夹
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
    _strMp3Path = [[NSString alloc] initWithFormat:@"%@/%@",documentsDirectory,@"ChatFiles"];
	NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createDirectoryAtPath:_strMp3Path withIntermediateDirectories:YES attributes:nil error:nil];
    sendState=YES;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"refreshChatMessage" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshChatMessage:)
                                                 name: @"refreshChatMessage"
                                               object: nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ShareMyLocation" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(ShareMyLocation:)
                                                 name: @"ShareMyLocation"
                                               object: nil];
    playRow=-1;
    [self scrollTableToFoot:YES];
    UIButton *backButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    backButton.frame=CGRectMake(10, 10, 37, 35);
    [self.view addSubview:backButton];
}
- (void)scrollTableToFoot:(BOOL)animated {
    NSInteger s = [self.listView numberOfSections];
    if (s<1) return;
    NSInteger r = [self.listView numberOfRowsInSection:s-1];
    if (r<1) return;
    
    NSIndexPath *ip = [NSIndexPath indexPathForRow:r-1 inSection:s-1];
    
    [self.listView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionBottom animated:animated];
}


-(void)initNav{
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"tb_navbar.png"] forBarMetrics:UIBarMetricsDefault];
    }
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"comm_top_button_left.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    backBtn.frame=CGRectMake(0, 0,52, 42);//52, 42
    UILabel *backLabel=[[UILabel alloc]initWithFrame:CGRectMake(52, 0, 300, 42)];
    backLabel.backgroundColor=[UIColor clearColor];
    backLabel.textColor=YINGYONG_COLOR;
    backLabel.textAlignment=NSTextAlignmentLeft;
    backLabel.font=[UIFont boldSystemFontOfSize:23];
    backLabel.text=@"对话中.....";
    UIView *backView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 330, 42)];
    backView1.backgroundColor=[UIColor clearColor];
    [backView1 addSubview:backBtn];
    [backView1 addSubview:backLabel];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backView1];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    self.view.backgroundColor=BACK_COLOR;
}

-(void)refreshChatMessage:(NSNotification *)_notification{
    FMDatabaseQueue *queue = [[FMDatabaseQueue alloc]initWithPath:[ZUOYLTempHelper getPathForDocuments:@"asiastarbus.db" inDir:@"db"]];
    JkMessageDAO* dao = [[JkMessageDAO alloc]initWithDbqueue:queue];
    [dao searchWhere:[NSString stringWithFormat:@"to_member_id=%d and member_id=%d",toMemberId,singleInfo.identity] orderBy:@"identity desc" offset:page count:PAGESIZE callback:^(NSArray *array){
        self.localArray=(NSMutableArray *) [[array reverseObjectEnumerator] allObjects];
        
        
    }];
    WcmCmsMemberMessage *message = [[WcmCmsMemberMessage alloc]init];
    message.messageTypeId=1;
    message.textMessage = @"欢迎您，多多健康";
    message.flag=1;
    message.addUserId = PROJECTSID;
    message.sid = PROJECTSID;
    if ([self.localArray count]>0) {
        [self.localArray insertObject:message atIndex:0];
    }else{
        [self.localArray addObject:message];
    }

    if ([self.localArray count]>0) {
        NSArray *localArray2=[[self.localArray reverseObjectEnumerator] allObjects];
        [self.listArray removeAllObjects];
        //        [NSThread detachNewThreadSelector:@selector(createLocalList:) toTarget:self withObject:localArray2];
        [self createLocalList:localArray2];
    }
    
    /*
    BbsMemberNewMessage *message = [_notification object];
    if (chatInfo2.chatId) {
        if ([message.chatId isEqualToString:chatInfo2.chatId]) {
            [self addNewMessageView:message];
            
            if (chatData==nil) {
                chatData=[[ChatData alloc]init];
            }
            [chatData updateMessageIsNew:message.identity];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshChatInfoList" object:nil];
            
        }
    }else if(memberFriend) {
        if (message.createUserId==memberFriend.friendMemberId && message.memberId==memberFriend.memberId) {
            [self addNewMessageView:message];
        }
    }else{
        [self addNewMessageView:message];
    }*/
    
}

-(void)initToolView{
    
    
    toolHide=YES;
    keyHeight=0;
    
    toolView=[[UIView alloc]initWithFrame:CGRectMake(0, 351, kDeviceWidth, 65)];
    toolView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:toolView];
    
    toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, KDeviceHeight-44-64, kDeviceWidth, 44)];
    toolBar.tintColor=[UIColor blackColor];

    toolBar.backgroundColor = [UIColor clearColor];

    [self.view addSubview:toolBar];
    
    yuyin=[UIButton buttonWithType:UIButtonTypeCustom];
    [yuyin setBackgroundImage:[UIImage imageNamed:@"chat_tool_yuyin.png"] forState:UIControlStateNormal];
    yuyin.frame=CGRectMake(5, 9, 24, 24);
    [yuyin addTarget:self action:@selector(yuyinAction) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:yuyin];
    yuyin.hidden=YES;
    
    wenzi=[UIButton buttonWithType:UIButtonTypeCustom];
    [wenzi setBackgroundImage:[UIImage imageNamed:@"chat_tool_wenzi.png"] forState:UIControlStateNormal];
    wenzi.frame=CGRectMake(5, 9, 24, 24);
    [wenzi addTarget:self action:@selector(wenziAction) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:wenzi];
    wenzi.hidden=NO;
    
    tool=[UIButton buttonWithType:UIButtonTypeCustom];
    [tool setBackgroundImage:[UIImage imageNamed:@"chat_tool_btn.png"] forState:UIControlStateNormal];
    tool.frame=CGRectMake(kDeviceWidth-55, 9, 24, 24);
//    [tool addTarget:self action:@selector(toolAction) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:tool];
    tool.hidden=YES;
    
    /*
     * 输入框
     */
    int version;
    UIImageView *backimage=[[UIImageView alloc]initWithFrame:CGRectMake(45, 33, kDeviceWidth-110, 3)];
    [backimage setImage:[[UIImage imageNamed:@"xiaoxi_down.png"] stretchableImageWithLeftCapWidth:3  topCapHeight:1]];
//    UIImageView *inputBg=[[UIImageView alloc]initWithFrame:CGRectMake(85, 6, 175, 31)];
//    if ([[UIDevice currentDevice].systemVersion doubleValue] > 4.99) {
//        version=5;
//        UIEdgeInsets insets = UIEdgeInsetsMake(0, 25, 0, 25);
//        inputBg.image=[[UIImage imageNamed:@"chat_input_wenzi.png"] resizableImageWithCapInsets:insets];
//    } else {
//        version=4;
//        inputBg.image=[[UIImage imageNamed:@"chat_input_wenzi.png"] stretchableImageWithLeftCapWidth:25 topCapHeight:15];
//    }
    [toolBar addSubview:backimage];
//    [inputBg release];
    
    input=[[UITextField alloc]initWithFrame:CGRectMake(50, 6, kDeviceWidth-120, 31)];
    input.font=[UIFont systemFontOfSize:16];
    input.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    input.delegate=self;
    input.returnKeyType=UIReturnKeyDone;
    [toolBar addSubview:input];
    input.hidden=NO;
    
    send=[UIButton buttonWithType:UIButtonTypeCustom];
    [send setBackgroundImage:[UIImage imageNamed:@"send.png"] forState:UIControlStateNormal];//chat_tool_send
    send.frame=CGRectMake(kDeviceWidth-55, 9, 24, 24);
    send.hidden=NO;
    [send addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
//    UILabel *send2=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 51, 31)];
//    send2.backgroundColor=[UIColor clearColor];
//    send2.font=[UIFont systemFontOfSize:16];
//    send2.text=@"发送";
//    send2.textAlignment=NSTextAlignmentCenter;
//    send2.textColor=[UIColor whiteColor];
//    send2.shadowColor=[UIColor whiteColor];
//    send2.shadowOffset=CGSizeMake(0.0f, 0.0f);
//    [send addSubview:send2];
//    [send2 release];
    [toolBar addSubview:send];
//    send.hidden=YES;
    
    /*
     * 语音按钮
     */
    
    voice=[UIButton buttonWithType:UIButtonTypeCustom];
    voice.frame=CGRectMake(45, 6, kDeviceWidth-55, 31);
    [voice setBackgroundImage:[[UIImage imageNamed:@"chanpinzhongxin_cell_back.png"]stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [voice setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [voice setTitle:@"按住  说话" forState:UIControlStateNormal];
    voice.titleLabel.font=[UIFont systemFontOfSize:12];
    [voice addTarget:self action:@selector(voiceAction) forControlEvents:UIControlEventTouchUpInside];
    [voice addTarget:self action:@selector(voiceAction) forControlEvents:UIControlEventTouchUpOutside];
    [voice addTarget:self action:@selector(recordAction) forControlEvents:UIControlStateHighlighted];
//    [voice addTarget:self action:@selector(voiceAction) forControlEvents:UIControlEventTouchUpInside];
//    [voice addTarget:self action:@selector(voiceAction) forControlEvents:UIControlEventTouchUpOutside];
//    [voice addTarget:self action:@selector(voiceAction) forControlEvents:UIControlEventTouchDragExit];
//    [voice addTarget:self action:@selector(voiceAction) forControlEvents:UIControlEventTouchDragOutside];
//    [voice addTarget:self action:@selector(recordAction) forControlEvents:UIControlEventTouchDown];
     voice.hidden=YES;
    [toolBar addSubview:voice];
    
    face=[UIButton buttonWithType:UIButtonTypeCustom];
    face.frame=CGRectMake(36, 10, 35, 35);
    [face setBackgroundImage:[UIImage imageNamed:@"chat_tool_photo.png"] forState:UIControlStateNormal];
    [face addTarget:self action:@selector(addPhoto) forControlEvents:UIControlEventTouchUpInside];
    
        [toolView addSubview:face];
    

    
    pic=[UIButton buttonWithType:UIButtonTypeCustom];
    pic.frame=CGRectMake(142, 10, 35, 35);
    [pic setBackgroundImage:[UIImage imageNamed:@"chat_tool_camera.png"] forState:UIControlStateNormal];
    [pic addTarget:self action:@selector(takePhoto) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:pic];
    
   
    
    video=[UIButton buttonWithType:UIButtonTypeCustom];
    video.frame=CGRectMake(249, 10, 35, 35);
    [video setBackgroundImage:[UIImage imageNamed:@"chat_tool_video.png"] forState:UIControlStateNormal];
    [video addTarget:self action:@selector(videoAction) forControlEvents:UIControlEventTouchUpInside];
//    [toolView addSubview:video];
    
 
    
//    position=[UIButton buttonWithType:UIButtonTypeCustom];
//    position.frame=CGRectMake(262, 10, 35, 35);
//    [position setBackgroundImage:[UIImage imageNamed:@"chat_tool_weizhi.png"] forState:UIControlStateNormal];
//    [position addTarget:self action:@selector(positionAction) forControlEvents:UIControlEventTouchUpInside];
//    [toolView addSubview:position];
    
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(0, 45, 107, 20)];
    label1.text=@"照片";
    label1.backgroundColor=[UIColor clearColor];
    label1.textAlignment=NSTextAlignmentCenter;
    label1.textColor=[UIColor blackColor];
    label1.font=[UIFont systemFontOfSize:12];
    [toolView addSubview:label1];

    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(107, 45, 106, 20)];
    label2.text=@"拍照";
    label2.backgroundColor=[UIColor clearColor];
    label2.textAlignment=NSTextAlignmentCenter;
    label2.textColor=[UIColor blackColor];
    label2.font=[UIFont systemFontOfSize:12];
    [toolView addSubview:label2];

    UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(213, 45, 107, 20)];
    label3.text=@"视频";
    label3.backgroundColor=[UIColor clearColor];
    label3.textAlignment=NSTextAlignmentCenter;
    label3.textColor=[UIColor blackColor];
    label3.font=[UIFont systemFontOfSize:12];
//    [toolView addSubview:label3];


    toolView.hidden=YES;
}

-(void)createLocalList:(NSArray *)_messageArray{
    @autoreleasepool {
//        [listArray removeAllObjects];
        for (id obj in _messageArray) {
            JkMessage *_message=obj;
            BOOL isMySend=YES;
            if (_message.memberId!=userId) {
                isMySend=NO;
            }
            switch (_message.messageTypeId) {
                    //            case 2:{//图文信息（新闻）
                    //                BubbleView *chatView = [self bubbleView6:_message];
                    //
                    //                [self.listArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:_message, @"news", @"other", @"speaker", chatView, @"view", nil]];
                    //                break;
                    //            }
                case 7:{//动态
//                    BubbleView *chatView = [self bubbleView6:_message];
                    [listArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:_message, @"dynamic", @"other", @"speaker", nil, @"view", nil]];
                    break;
                }
                default:{//普通信息
                    switch (_message.messageType) {
                        case 5:{
                            
                            BubbleView *chatView = [self bubbleView:_message.textMessage from:isMySend date:[[[NSDateFormatter alloc] init] dateFromString:_message.addDate] success:YES];
                            [chatView.activityView stopAnimating];
                            chatView.isSuccess=YES;
                            if (_message.status==-1) {
                                chatView.state.hidden=NO;
                                chatView.isSuccess=NO;
                            }
                            [listArray insertObject:[NSDictionary dictionaryWithObjectsAndKeys:_message, @"text", isMySend?@"self":@"other", @"speaker", chatView, @"view", nil] atIndex:0];
                            
                            break;
                        }
                        case 1:{
                            
                            BubbleView *chatView = [self bubbleView:_message.textMessage from:isMySend date:[[[NSDateFormatter alloc] init] dateFromString:_message.addDate] success:YES];
                            [chatView.activityView stopAnimating];
                            chatView.isSuccess=YES;
                            if (_message.status==-1) {
                                chatView.state.hidden=NO;
                                chatView.isSuccess=NO;
                            }
                            [listArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:_message, @"text", isMySend?@"self":@"other", @"speaker", chatView, @"view", nil]];
                            
                            break;
                        }
                        case 2:{
                            int timeDuration=_message.addDate;
                            int hours=timeDuration/3600;
                            int minutes=timeDuration/60;
                            int seconds=timeDuration;
                            NSString *time=@"";
                            if (hours>0) {
                                int seconds2=timeDuration%3600;
                                if (seconds2>=60) {
                                    minutes=seconds/60;
                                    seconds=seconds2%60;
                                }else{
                                    minutes=0;
                                    seconds=seconds2;
                                }
                                time=[NSString stringWithFormat:@"%d %d'%d\"",hours,minutes,seconds];
                            }else if (minutes>0) {
                                seconds=timeDuration%60;
                                time=[NSString stringWithFormat:@"%d'%d\"",minutes,seconds];
                            }else{
                                time=[NSString stringWithFormat:@"%d\"",seconds];
                            }
                            if (_message.status==0) {
                                BubbleView *chatView = [self bubbleView3:time from:isMySend date:[[[NSDateFormatter alloc] init] dateFromString:_message.addDate] isNew:YES success:YES];
                                //[chatView repeatAnimation2];
                                [chatView.activityView stopAnimating];
                                chatView.isSuccess=YES;
                                if (_message.status==-1) {
                                    chatView.state.hidden=NO;
                                    chatView.isSuccess=NO;
                                }
                                [listArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:_message, @"voice", isMySend?@"self":@"other", @"speaker", chatView, @"view", [NSNumber numberWithInt:timeDuration], @"time", nil]];
                            }else{
                                BubbleView *chatView = [self bubbleView3:time from:isMySend date:[[[NSDateFormatter alloc] init] dateFromString:_message.addDate] isNew:NO success:YES];
                                //[chatView repeatAnimation2];
                                [chatView.activityView stopAnimating];
                                chatView.isSuccess=YES;
                                if (_message.status==-1) {
                                    chatView.state.hidden=NO;
                                    chatView.isSuccess=NO;
                                }
                                [listArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:_message, @"voice", isMySend?@"self":@"other", @"speaker", chatView, @"view", [NSNumber numberWithInt:timeDuration], @"time", nil]];
                            }
                            
                            break;
                        }
                        case 3:{
                            NSString *imagePath=[NSString stringWithFormat:@"%@/Documents/ChatFiles/%@",NSHomeDirectory(),@""];
                            UIImage *image=[UIImage imageWithContentsOfFile:imagePath];
                            BubbleView *chatView = [self bubbleView2:image from:isMySend date:[[[NSDateFormatter alloc] init] dateFromString:_message.addDate] success:YES message:_message];
                            [chatView.activityView stopAnimating];
                            chatView.isSuccess=YES;
                            if (_message.status==-1) {
                                chatView.state.hidden=NO;
                                chatView.isSuccess=NO;
                            }
                            [listArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:_message, @"image", isMySend?@"self":@"other", @"speaker", chatView, @"view", nil]];
                            
                            break;
                        }
                        case 4:{
                            NSString *imagePath=[NSString stringWithFormat:@"%@/Documents/ChatFiles/%@",NSHomeDirectory(),@""];
                            UIImage *image=[UIImage imageWithContentsOfFile:imagePath];
                            BOOL isRead;
                            if (_message.status==0) {
                                isRead=NO;
                            }else{
                                isRead=YES;
                            }
                           
                            BubbleView *chatView = [self bubbleView4:image from:isMySend date: [[[NSDateFormatter alloc] init] dateFromString:_message.addDate]isNew:isRead success:_message.status time:_message.addDate];
                            [chatView.activityView stopAnimating];
                            chatView.isSuccess=YES;
                            if (_message.status==-1) {
                                chatView.state.hidden=NO;
                                chatView.isSuccess=NO;
                            }
                            [listArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:_message, @"video", isMySend?@"self":@"other", @"speaker", chatView, @"view", nil]];
                            
                            break;
                        }
                
                        default:
                            break;
                    } 
                    
                    break;
                }
            }
        }
        [listView reloadData];
        if (listView) {
            [listView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[_messageArray count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        }
    }
    
    
}

-(void)createLocalList2:(NSArray *)_messageArray{
    @autoreleasepool {
        for (id obj in _messageArray) {
            JkMessage *_message=obj;
            BOOL isMySend=YES;
            if (_message.memberId!=userId) {
                isMySend=NO;
            }
            
            switch (_message.messageTypeId) {
                case 7:{//图文信息（新闻）
//                    BubbleView *chatView = [self bubbleView6:_message];
                    
                    [self.listArray insertObject:[NSDictionary dictionaryWithObjectsAndKeys:_message, @"news", @"other", @"speaker", nil, @"view", nil] atIndex:0];
                    break;
                }
                    
                default:{//普通信息
                    switch (_message.messageType) {
                        case 5:{
                            
                            BubbleView *chatView = [self bubbleView:_message.textMessage from:isMySend date:_message.addDate success:YES];
                            [chatView.activityView stopAnimating];
                            chatView.isSuccess=YES;
                            if (_message.status==-1) {
                                chatView.state.hidden=NO;
                                chatView.isSuccess=NO;
                            }
                            [listArray insertObject:[NSDictionary dictionaryWithObjectsAndKeys:_message, @"text", isMySend?@"self":@"other", @"speaker", chatView, @"view", nil] atIndex:0];
                            
                            break;
                        }
                        case 1:{
                            
                            BubbleView *chatView = [self bubbleView:_message.textMessage from:isMySend date:_message.addDate success:YES];
                            [chatView.activityView stopAnimating];
                            chatView.isSuccess=YES;
                            if (_message.status==-1) {
                                chatView.state.hidden=NO;
                                chatView.isSuccess=NO;
                            }
                            [listArray insertObject:[NSDictionary dictionaryWithObjectsAndKeys:_message, @"text", isMySend?@"self":@"other", @"speaker", chatView, @"view", nil] atIndex:0];
                            
                            break;
                        }
                        case 2:{
                            int timeDuration=_message.addDate;
                            int hours=timeDuration/3600;
                            int minutes=timeDuration/60;
                            int seconds=timeDuration;
                            NSString *time=@"";
                            if (hours>0) {
                                int seconds2=timeDuration%3600;
                                if (seconds2>=60) {
                                    minutes=seconds/60;
                                    seconds=seconds2%60;
                                }else{
                                    minutes=0;
                                    seconds=seconds2;
                                }
                                time=[NSString stringWithFormat:@"%d %d'%d\"",hours,minutes,seconds];
                            }else if (minutes>0) {
                                seconds=timeDuration%60;
                                time=[NSString stringWithFormat:@"%d'%d\"",minutes,seconds];
                            }else{
                                time=[NSString stringWithFormat:@"%d\"",seconds];
                            }
                            if (_message.status==0) {
                                BubbleView *chatView = [self bubbleView3:time from:isMySend date:_message.addDate isNew:YES success:YES];
                                //[chatView repeatAnimation2];
                                [chatView.activityView stopAnimating];
                                chatView.isSuccess=YES;
                                if (_message.status==-1) {
                                    chatView.state.hidden=NO;
                                    chatView.isSuccess=NO;
                                }
                                [listArray insertObject:[NSDictionary dictionaryWithObjectsAndKeys:_message, @"voice", isMySend?@"self":@"other", @"speaker", chatView, @"view", [NSNumber numberWithInt:timeDuration], @"time", nil] atIndex:0];
                            }else{
                                BubbleView *chatView = [self bubbleView3:time from:isMySend date:_message.addDate isNew:NO success:YES];
                                //[chatView repeatAnimation2];
                                [chatView.activityView stopAnimating];
                                chatView.isSuccess=YES;
                                if (_message.status==-1) {
                                    chatView.state.hidden=NO;
                                    chatView.isSuccess=NO;
                                }
                                [listArray insertObject:[NSDictionary dictionaryWithObjectsAndKeys:_message, @"voice", isMySend?@"self":@"other", @"speaker", chatView, @"view", [NSNumber numberWithInt:timeDuration], @"time", nil] atIndex:0];
                            }
                            break;
                        }
                        case 3:{
                            NSString *imagePath=[NSString stringWithFormat:@"%@/Documents/ChatFiles/%@",NSHomeDirectory(),@""];
                            UIImage *image=[UIImage imageWithContentsOfFile:imagePath];
                            BubbleView *chatView = [self bubbleView2:image from:isMySend date:_message.addDate success:YES message:_message];
                            [chatView.activityView stopAnimating];
                            chatView.isSuccess=YES;
                            if (_message.status==-1) {
                                chatView.state.hidden=NO;
                                chatView.isSuccess=NO;
                            }
                            [listArray insertObject:[NSDictionary dictionaryWithObjectsAndKeys:_message, @"image", isMySend?@"self":@"other", @"speaker", chatView, @"view", nil] atIndex:0];
                            break;
                        }
                        case 4:{
                            NSString *imagePath=[NSString stringWithFormat:@"%@/Documents/ChatFiles/%@",NSHomeDirectory(),@""];
                            UIImage *image=[UIImage imageWithContentsOfFile:imagePath];
                            BubbleView *chatView = [self bubbleView2:image from:isMySend date:_message.addDate success:YES message:_message];
                            [chatView.activityView stopAnimating];
                            chatView.isSuccess=YES;
                            if (_message.status==-1) {
                                chatView.state.hidden=NO;
                                chatView.isSuccess=NO;
                            }
                            [listArray insertObject:[NSDictionary dictionaryWithObjectsAndKeys:_message, @"video", isMySend?@"self":@"other", @"speaker", chatView, @"view", nil] atIndex:0];
                            break;
                        }
                       
                        default:
                            break;
                    } 
                    
                    break;
                }
            }
            
        }
        
        [listView reloadData];
        if (listView) {
            [listView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[_messageArray count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        }

    }
    
}

//增加消息
-(void)addNewMessageView:(WcmCmsMemberMessage *)_message{
    BOOL isMySend=NO;
    switch (_message.messageTypeId) {
        case 2:{//图文信息（新闻）
//            BubbleView *chatView = [self bubbleView6:_message];
            
            [self.listArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:_message, @"news", @"other", @"speaker", nil, @"view", nil]];
            break;
        }
        case 3:{//动态
            BubbleView *chatView = [self bubbleView6:_message];
            [listArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:_message, @"dynamic", @"other", @"speaker", chatView, @"view", nil]];
            break;
        }
        default:{//普通信息
            switch (_message.messageTypeId) {
                case 1:{
                    
                    BubbleView *chatView = [self bubbleView:_message.textMessage from:isMySend date:_message.addDate success:YES];
                    [chatView.activityView stopAnimating];
                    chatView.isSuccess=YES;
                    
                    [listArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:_message, @"text", isMySend?@"self":@"other", @"speaker", chatView, @"view", nil]];
                    
                    break;
                }
                case 2:{
                    int timeDuration=_message.fileTimeLength;
                    int hours=timeDuration/3600;
                    int minutes=timeDuration/60;
                    int seconds=timeDuration;
                    NSString *time=@"";
                    if (hours>0) {
                        int seconds2=timeDuration%3600;
                        if (seconds2>=60) {
                            minutes=seconds/60;
                            seconds=seconds2%60;
                        }else{
                            minutes=0;
                            seconds=seconds2;
                        }
                        time=[NSString stringWithFormat:@"%d %d'%d\"",hours,minutes,seconds];
                    }else if (minutes>0) {
                        seconds=timeDuration%60;
                        time=[NSString stringWithFormat:@"%d'%d\"",minutes,seconds];
                    }else{
                        time=[NSString stringWithFormat:@"%d\"",seconds];
                    }
                    if (_message.status==0) {
                        BubbleView *chatView = [self bubbleView3:time from:isMySend date:_message.addDate isNew:YES success:YES];
                        [chatView.activityView stopAnimating];
                        chatView.isSuccess=YES;
                        
                        [listArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:_message, @"voice", isMySend?@"self":@"other", @"speaker", chatView, @"view", [NSNumber numberWithInt:timeDuration], @"time", nil]];
                    }else{
                        BubbleView *chatView = [self bubbleView3:time from:isMySend date:_message.addDate isNew:NO success:YES];
                        [chatView.activityView stopAnimating];
                        chatView.isSuccess=YES;
                        
                        [listArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:_message, @"voice", isMySend?@"self":@"other", @"speaker", chatView, @"view", [NSNumber numberWithInt:timeDuration], @"time", nil]];
                    }
                    
                    break;
                }
                case 3:{
                    UIImage *image=[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/Documents/ChatFiles/%@",NSHomeDirectory(),_message.fileAddress]];
                    BubbleView *chatView = [self bubbleView2:image from:isMySend date:_message.addDate success:YES message:_message];
                    [chatView.activityView stopAnimating];
                    chatView.isSuccess=YES;
                    
                    [listArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:_message, @"image", isMySend?@"self":@"other", @"speaker", chatView, @"view", nil]];
                    
                    break;
                }
                case 4:{
                    NSString *imagePath=[NSString stringWithFormat:@"%@/Documents/ChatFiles/%@",NSHomeDirectory(),_message.fileAddress];
                    UIImage *image=[UIImage imageWithContentsOfFile:imagePath];
                    BubbleView *chatView = [self bubbleView2:image from:isMySend date:_message.addDate success:YES message:_message];
                    [chatView.activityView stopAnimating];
                    chatView.isSuccess=YES;
                    if (_message.status==-1) {
                        chatView.state.hidden=NO;
                        chatView.isSuccess=NO;
                    }
                    [listArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:_message, @"video", isMySend?@"self":@"other", @"speaker", chatView, @"view", nil]];
                    
                    break;
                }
         
                default:
                    break;
            }
            
            break;
            
        }
        
    }
    
    
    [listView reloadData];
    
    [listView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[listArray count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    
}

- (void)loadData{
    if (self.refreshing) {
        self.refreshing = NO;
        [self.listArray removeAllObjects];
        [self.listView reloadData];
        if([commonJudgeMent ifConnectNet] && page == 0)
        {
             page++;
            //1.确定地址nsurl
            NSString *urlString = @"";
            if(toMemberId != 0)
            {
               urlString = [NSString stringWithFormat:@"start_page=%ld&page_size=%d&is_page=1&table_name=jk_message&condition=(member_id =%d  and to_member_id=%d) or (member_id = %d and to_member_id=%d) and message_type=5 ",(long)page,10000,singleInfo.identity,toMemberId,toMemberId,singleInfo.identity];
            }
            else
            {
                  urlString = [NSString stringWithFormat:@"start_page=%ld&page_size=%d&is_page=1&table_name=jk_message&condition=(to_member_id=%d and message_type<>5)",(long)page,10000,singleInfo.identity];
            }
            
            
            NSURL *httpurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,COMMONINDEX_URL]];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:httpurl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
            
            [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
            
            NSData *data = [urlString dataUsingEncoding:NSUTF8StringEncoding];
            
            [request setHTTPBody:data];

            /*
             同步请求
             */
            @autoreleasepool {
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSURLResponse *respons = nil;
                    NSError *error = nil;
                    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&respons error:&error];

                            NSArray *objects=[JsonToModel objectsFromDictionaryData:data className:@"JkMessage"];
                          [dao replaceArrayToDB:objects callback:^(BOOL block){   }];
                         [self updataMessageIsRead];  //更新消息为已读

                    });
                }
             }
           }
    
    
        [dao searchWhere:[NSString stringWithFormat:@"(toMemberId=%d and memberId=%d) or (toMemberId=%d and memberId=%d)",toMemberId,singleInfo.identity,singleInfo.identity,toMemberId] orderBy:@"identity desc" offset:0 count:10000 callback:^(NSArray *array){
            self.localArray=(NSMutableArray *) [[array reverseObjectEnumerator] allObjects];
        }];

            self.localArray = (NSMutableArray *)[[self.localArray reverseObjectEnumerator]allObjects];
        if ([self.localArray count]>0) {
            //NSArray *localArray2=[[localArray reverseObjectEnumerator] allObjects];
            [NSThread detachNewThreadSelector:@selector(createLocalList2:) toTarget:self withObject:self.localArray];
        }else{
            page--;
        }
    
    [self.listView tableViewDidFinishedLoading];
}
#pragma mark 更新消息为已读
- (void)updataMessageIsRead
{
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@?user_id=%d&to_member_id=%d",BASE_URL,MESSAGEUPDATEISREAD_URL,userId,toMemberId];
    
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
//                    NSMutableDictionary *dir = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//                    NSString *string=[dir objectForKey:@"resultObject"];
//                    if([string intValue] > 0)
//                    {
//                     
//                    }
                    NSLog(@"更新消息为已读");
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
#pragma mark - PullingRefreshTableViewDelegate
-(void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView{
    self.refreshing = YES;
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.f];
}

- (NSDate *)pullingTableViewRefreshingFinishedDate{
    NSDate *date2=[NSDate date];
    return date2;
}

- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView{
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.f];    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.listView tableViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.listView tableViewDidEndDragging:scrollView];
}

//发表的工具栏点击事件
-(void)toolAction{
    if (keyHeight==0) {
        toolView.frame=CGRectMake(0, KDeviceHeight-65, kDeviceWidth, 65);
        
        if (toolHide) {
            toolBar.frame=CGRectMake(0, KDeviceHeight-44-65, kDeviceWidth, 44);
            toolView.hidden=NO;
            listView.frame=CGRectMake(0, 0, kDeviceWidth, KDeviceHeight-109);
            toolHide=NO;
            [tool setBackgroundImage:[UIImage imageNamed:@"chat_tool_btn.png"] forState:UIControlStateNormal];
            
        }else{
            toolBar.frame=CGRectMake(0, KDeviceHeight-64-44, kDeviceWidth, 44);
            toolView.hidden=YES;
            listView.frame=CGRectMake(0, 0, kDeviceWidth, KDeviceHeight-44);
            toolHide=YES;
            [tool setBackgroundImage:[UIImage imageNamed:@"chat_tool_btn.png"] forState:UIControlStateNormal];
        }
    }else if(keyHeight==252){
        toolView.frame=CGRectMake(0, KDeviceHeight-65-252, kDeviceWidth, 65);
        toolBar.frame=CGRectMake(0, KDeviceHeight-44-65-252, kDeviceWidth, 44);
        if (toolHide) {
            toolView.hidden=NO;
            listView.frame=CGRectMake(0, 0, kDeviceWidth, KDeviceHeight-65-252-44);
            toolHide=NO;
            [tool setBackgroundImage:[UIImage imageNamed:@"chat_tool_btn.png"] forState:UIControlStateNormal];
        }else{
            toolView.hidden=YES;
            listView.frame=CGRectMake(0, 0, kDeviceWidth, KDeviceHeight-44-252);
            toolHide=YES;
            [tool setBackgroundImage:[UIImage imageNamed:@"chat_tool_btn.png"] forState:UIControlStateNormal];
        }
        
    }else{
        toolView.frame=CGRectMake(0, KDeviceHeight-65-216, kDeviceWidth, 65);
        toolBar.frame=CGRectMake(0, KDeviceHeight-44-65-216, kDeviceWidth, 44);
        if (toolHide) { 
            toolView.hidden=NO;
            listView.frame=CGRectMake(0, 0, kDeviceWidth, KDeviceHeight-65-216-44);
            toolHide=NO;
            [tool setBackgroundImage:[UIImage imageNamed:@"chat_tool_btn.png"] forState:UIControlStateNormal];
        }else{
            toolView.hidden=YES;
            listView.frame=CGRectMake(0, 0, kDeviceWidth, KDeviceHeight-44-216);
            toolHide=YES;
            [tool setBackgroundImage:[UIImage imageNamed:@"chat_tool_btn.png"] forState:UIControlStateNormal];
        }
        
    }
    
}

-(void)yuyinAction{
    /*
    if (toolHide==NO) {
        [self toolAction];
    }
    yuyin.hidden=YES;
    voice.hidden=NO;
    wenzi.hidden=NO;
    */
//    input.hidden=YES;
//    send.hidden=YES;
}

-(void)wenziAction{
    
    yuyin.hidden=NO;
    voice.hidden=YES;
    wenzi.hidden=YES;
//    input.hidden=NO;
//    send.hidden=NO;
}

-(void)sendAction{
    if (sendState) {
        isMySpeaking=YES;
        //生成视图
        NSString *content=[NSString stringWithFormat:@"%@",input.text];
        if (![content isEqualToString:@""]) {
            if (createChatObject==nil) {
                createChatObject=[[CreateChatObject alloc]init];
            }
            NSString *uuid=[self uuid];
            NSDate *date=[NSDate date];
            WcmCmsMemberMessage *bbsMemberNewMessage;

                bbsMemberNewMessage=[createChatObject getMessage:content uuid:uuid date:date type:1 length:0 fileName:uuid receiveInfo:chatInfo2];
                
                       BubbleView *chatView = [self bubbleView:content from:isMySpeaking date:[NSDate date] success:NO];
            if ([self connectedToNetWork]) {
                [self.localArray addObject:bbsMemberNewMessage];
                [self.listArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:bbsMemberNewMessage, @"text", isMySpeaking?@"self":@"other", @"speaker", chatView, @"view", nil]];
                [listView reloadData];
                sendRow=[self.listArray count]-1;
                [listView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:sendRow inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
                input.text=@"";
                //发送消息
                [self sendMessage:bbsMemberNewMessage uuid:uuid];
                sendType=1;
            }else{
                [chatView.activityView stopAnimating];
                chatView.state.hidden=NO;
                chatView.isSuccess=NO;
                bbsMemberNewMessage.status=-1;
                [self.localArray addObject:bbsMemberNewMessage];
                [self.listArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:bbsMemberNewMessage, @"text", isMySpeaking?@"self":@"other", @"speaker", chatView, @"view", nil]];
                [listView reloadData];
                [listView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.listArray count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
                input.text = @"";
            }
            [NSThread detachNewThreadSelector:@selector(saveMessage:) toTarget:self withObject:bbsMemberNewMessage];
        }
    }else{
        [self showToast:@"请稍等"];
    }
    
    
}

-(void)saveMessage:(WcmCmsMemberMessage *)_message{
    @autoreleasepool {
        FMDatabaseQueue *queue = [[FMDatabaseQueue alloc]initWithPath:[ZUOYLTempHelper getPathForDocuments:@"asiastarbus.db" inDir:@"db"]];
        WcmCmsMemberMessageDAO* dao = [[WcmCmsMemberMessageDAO alloc]initWithDbqueue:queue];
        NSArray *array = [[NSArray alloc]initWithObjects:_message, nil];
        [dao replaceArrayToDB:array callback:^(BOOL block){
            
        }];
        [self.localArray addObject:_message];
        if (chatInfo2.chatId) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshChatInfoList" object:nil];
            
        }else if(memberFriend){
            
            if (chatData==nil) {
                chatData=[[ChatData alloc]init];
            }
            
            BbsChatInfo *chatInfo=[chatData getChat:memberFriend.friendMemberId  chatId:@""];
            
            self.chatInfo2=chatInfo;
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshChatInfoList" object:nil];
        }
    }

    
 
}


-(void)faceAction{
    [input resignFirstResponder];
    if (faceView==nil) {
        faceView=[[ChatFaceView alloc]init];
        faceView.delegate=self;
        faceView.view.frame=CGRectMake(0, 0, kDeviceWidth, KDeviceHeight);
        
        [[UIApplication sharedApplication].keyWindow addSubview:faceView.view];
        
    }
    faceView.view.hidden=NO;
    
}

-(void)selectFace:(NSString *)_face{
    faceView.view.hidden=YES;
    NSString *writeText=self.input.text;
    if (writeText==nil) {
        writeText=@"";
    }
    
    self.input.text=[NSString stringWithFormat:@"%@%@",writeText,_face];
    [self wenziAction];
}

-(void)disFaceAction{
    faceView.view.hidden=YES;
}

-(void)picAction{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]  
                                  initWithTitle:@""  
                                  delegate:self  
                                  cancelButtonTitle:@"取消"  
                                  destructiveButtonTitle:nil  
                                  otherButtonTitles:@"拍摄",@"相册",nil];  
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;  
    actionSheet.tag=7;
    [actionSheet showInView:self.view];
}

-(void)videoAction{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]  
                                  initWithTitle:@""  
                                  delegate:self  
                                  cancelButtonTitle:@"取消"  
                                  destructiveButtonTitle:nil  
                                  otherButtonTitles:@"拍摄",@"相册",nil];  
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;  
    actionSheet.tag=8;
    [actionSheet showInView:self.view];
}


-(void)backAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightAction{
   }

- (void)keyboardWillShow:(NSNotification *)notification {
    if (toolHide==NO) {
//        [self toolAction];
    }
    send.hidden=NO;
    tool.hidden=YES;
    NSDictionary *userInfo = [notification userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    if (keyboardRect.size.height == 252){
        keyHeight=keyboardRect.size.width;
//        toolView.frame=CGRectMake(0, KDeviceHeight-65-keyHeight, kDeviceWidth, 65);
//        toolBar.frame=CGRectMake(0, KDeviceHeight-44-65-keyHeight, kDeviceWidth, 44);
        if (toolHide) {
            toolView.frame=CGRectMake(0, KDeviceHeight-65-keyHeight, kDeviceWidth, 65);
            toolBar.frame=CGRectMake(0, KDeviceHeight-44-keyHeight, kDeviceWidth, 44);
            listView.frame=CGRectMake(0, 0, kDeviceWidth, KDeviceHeight-keyHeight-44);
        }else{
            toolView.frame=CGRectMake(0, KDeviceHeight-65-keyHeight, kDeviceWidth, 65);
            toolBar.frame=CGRectMake(0, KDeviceHeight-44-65-keyHeight, kDeviceWidth, 44);
            listView.frame=CGRectMake(0, 0, kDeviceWidth, KDeviceHeight-44-keyHeight-65);
        }
//    }
//    else if(keyboardRect.size.height == 216){
//        keyHeight=216;
//        toolView.frame=CGRectMake(0, KDeviceHeight-65-216, kDeviceWidth, 65);
//        toolBar.frame=CGRectMake(0, KDeviceHeight-44-65-216, kDeviceWidth, 44);
////        toolView.frame=CGRectMake(0, 91, kDeviceWidth, 65);
////        toolBar.frame=CGRectMake(0, 156, kDeviceWidth, 44);
//        if (toolHide) {
//            listView.frame=CGRectMake(0, 0, kDeviceWidth, KDeviceHeight-44-216);
//        }else{
//           listView.frame=CGRectMake(0, 0, kDeviceWidth, KDeviceHeight-65-216-44);
//        }
//        
//        
//    }
    listView.frame=CGRectMake(0, 0, kDeviceWidth, [UIScreen mainScreen].bounds.size.height-44-50);
    toolBar.frame=CGRectMake(0, [UIScreen mainScreen].bounds.size.height-keyHeight-44, kDeviceWidth, 44);
    [UIView commitAnimations];
    
    
}

- (void)keyboardWillHide:(NSNotification *)notification {
    if ([input.text isEqualToString:@""]) {
//        send.hidden=YES;
//        tool.hidden=NO;
    }
    keyHeight=0;
//    toolView.frame=CGRectMake(0, KDeviceHeight-65, kDeviceWidth, 65);
//    toolBar.frame=CGRectMake(0, KDeviceHeight-44, kDeviceWidth, 44);
    if (toolHide) {
        toolView.frame=CGRectMake(0, KDeviceHeight-65, kDeviceWidth, 65);
        toolBar.frame=CGRectMake(0, KDeviceHeight-64-44, kDeviceWidth, 44);
        listView.frame=CGRectMake(0, 0, kDeviceWidth, KDeviceHeight-44-60);
    }else{
        toolView.frame=CGRectMake(0, KDeviceHeight-65, kDeviceWidth, 65);
        toolBar.frame=CGRectMake(0, KDeviceHeight-64-44-65, kDeviceWidth, 44);
//        listView.frame=CGRectMake(0, 0, kDeviceWidth, 307);
        listView.frame=CGRectMake(0, 0, kDeviceWidth, KDeviceHeight-109);
    }
    
}

- (void)addPhoto
{
    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.navigationBar.tintColor = [UIColor colorWithRed:50.0/255.0 green:150.0/255.0 blue:28.0/255.0 alpha:1.0];
	imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	imagePickerController.delegate = self;
	imagePickerController.allowsEditing = YES;
    
    imagePickerController.showsCameraControls = NO;
//    imagePickerController.cameraOverlayView=self.overlay;
//    //这里放大，把工具栏隐藏//overlay 里手工添加一些控制button 当这，这里要用imageview 模拟成button
//    imagePickerController.cameraViewTransform = cameraTransform;
    
//	[self presentModalViewController:imagePickerController animated:YES];
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)takePhoto
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) 
    {
        [self showToast:@"设备不支持拍照"];
    }
    else
    {
        UIImagePickerController * imagePickerController = [[UIImagePickerController alloc]init];
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = NO;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
}

- (void)addVideo
{
    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.navigationBar.tintColor = [UIColor colorWithRed:50.0/255.0 green:150.0/255.0 blue:28.0/255.0 alpha:1.0];
	imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeMovie];
	imagePickerController.delegate = self;
	imagePickerController.allowsEditing = YES;
    imagePickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)takeVideo
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) 
    {
        [self showToast:@"设备不支持拍摄"];
    }
    else
    {
        UIImagePickerController * imagePickerController = [[UIImagePickerController alloc]init];
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerController.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeMovie];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        [self presentViewController:imagePickerController animated:YES completion:nil];

    }
}
//图片压缩
-(UIImage*)imageWithImageSimple:(UIImage *)image scaledToSize:(CGSize)newSize{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
//发送照片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.image"]) {//如果是图片
        if (sendState) {
            isMySpeaking=YES;
            UIImage * image2 = [info objectForKey:@"UIImagePickerControllerOriginalImage"];//[info objectForKey:UIImagePickerControllerEditedImage];//
            CGSize size=CGSizeMake(640.0f, 640.0f);if (image2.size.width<=600) {
                if (image2.size.height>1000) {
                    image2 = [self imageWithImageSimple:image2 scaledToSize:CGSizeMake(image2.size.width/image2.size.height*1000, 1000)];
                }
            }else  {
                image2 = [self imageWithImageSimple:image2 scaledToSize:CGSizeMake(600, image2.size.height/image2.size.width*600)];
                if (image2.size.height>1000) {
                    image2 = [self imageWithImageSimple:image2 scaledToSize:CGSizeMake(image2.size.width/image2.size.height*1000, 1000)];
                }
            }
            
            NSData *imageData=UIImageJPEGRepresentation(image2, 0.9);

            image2=[CreateImage newImageForSize:size with:image2];
            
            NSString *uuid=[self uuid];
          
            NSString *imageString=[ChangeData data2String:imageData];
            [[NSFileManager defaultManager]createFileAtPath:[NSString stringWithFormat:@"%@/%@.jpg",_strMp3Path,uuid] contents:imageData attributes:nil];
            
            NSDate *date=[NSDate date];
            
            if (createChatObject==nil) {
                createChatObject=[[CreateChatObject alloc]init];
            }
            
            WcmCmsMemberMessage *newmessage;
            newmessage=[createChatObject getMessage:imageString uuid:uuid date:date type:3 length:0 fileName:uuid receiveInfo:chatInfo2];
                
            BubbleView *chatView = [self bubbleView2:image2 from:isMySpeaking date:[NSDate date] success:NO message:newmessage];
            if ([self connectedToNetWork]) {
                [localArray addObject:newmessage];
                [listArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:newmessage, @"image", isMySpeaking?@"self":@"other", @"speaker", chatView, @"view", nil]];
                [listView reloadData];
                sendRow=[listArray count]-1;
                [listView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:sendRow inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
                
                [self sendMessage:newmessage uuid:uuid];
                sendType=3;
            }else{
                [chatView.activityView stopAnimating];
                chatView.state.hidden=NO;
                chatView.isSuccess=NO;
                newmessage.status=-1;
                [localArray addObject:newmessage];
                [listArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:newmessage, @"image", isMySpeaking?@"self":@"other", @"speaker", chatView, @"view", nil]];
                [listView reloadData];
                [listView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[listArray count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
            }
            [NSThread detachNewThreadSelector:@selector(saveMessage:) toTarget:self withObject:newmessage];

            
        }else{
            [self showToast:@"请稍等"];
        }
    }else{
            [self showToast:@"请稍等"];
        
        
        
        
    }
    
    
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (alertView.tag) {
        case 1:{
            if (buttonIndex==1) {
                [self takePhoto];
            }else if (buttonIndex==2){
                [self addPhoto];
            }
            break;
        }
        case 2:{
            if (buttonIndex==0) {
                [self.navigationController popViewControllerAnimated:YES];
            }
            break;
        }
        case 3:{
            if (buttonIndex==0) {
                
            }
            break;
        }
        default:
            break;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@""]&&textField.text.length==1) {
//        send.hidden=YES;
//        tool.hidden=NO;
    } else{
        send.hidden=NO;
        tool.hidden=YES;
    }
    return YES;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    return YES;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [listArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    JkMessage *newmessage=[self.localArray objectAtIndex:indexPath.row];
//    if (newmessage.messageTypeId==7) {
//        return 210;
//    }
    UIView *chatView = [[listArray objectAtIndex:[indexPath row]] objectForKey:@"view"];
	return chatView.frame.size.height+10.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSString *CellIdentifier =[NSString stringWithFormat:@"cell%d",indexPath.row];
//    JkMessage *newmessage=[self.listArray objectAtIndex:indexPath.row];
//    if (newmessage.memberId==singleInfo.identity) {
//        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:nil];
//        if (cell==nil) {
//            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
//        }
//        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(60, 5, kDeviceWidth-120, 200)];
//        backView.layer.cornerRadius=3.0;
//        backView.backgroundColor = [UIColor whiteColor];
//        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, kDeviceWidth-130, 20)];
//        titleLabel.text = newmessage.textMessage;
//        titleLabel.backgroundColor=[UIColor clearColor];
//
//        titleLabel.textAlignment=NSTextAlignmentLeft;
//        titleLabel.textColor=[UIColor blackColor];
//        titleLabel.font=[UIFont systemFontOfSize:14];
//        [backView addSubview:titleLabel];
//        UILabel *dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 25, kDeviceWidth-130, 15)];
//        dateLabel.text = newmessage.addDate;
//        dateLabel.backgroundColor=[UIColor clearColor];
//        dateLabel.textAlignment=NSTextAlignmentLeft;
//        dateLabel.textColor=[UIColor whiteColor];
//        dateLabel.font=[UIFont systemFontOfSize:10];
//        [backView addSubview:dateLabel];
//        
//       UIImageView *imageViewa=[[UIImageView alloc]initWithFrame:CGRectMake((kDeviceWidth-288-120)/2, 40, 288, 140)];
//        //        setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_IP,pic.imgSmall]]refreshCache:NO placeholderImage:[UIImage imageNamed:@"default_160x200.png"]
//        //        [imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",ads.cover]] placeholderImage:[UIImage imageNamed:@"default_320x150.png"]];
//        [imageViewa setImageWithURL:[NSURL URLWithString:singleInfo.headImg] refreshCache:NO placeholderImage:[UIImage imageNamed:@"defaultImage_102x70.png"]];
//        [backView addSubview:imageViewa];
//        UILabel *summaryLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 180, kDeviceWidth-130, 20)];
//        summaryLabel.text = @"点击查看全文";
//        summaryLabel.backgroundColor=[UIColor clearColor];
//        summaryLabel.textAlignment=NSTextAlignmentLeft;
//        summaryLabel.textColor=[UIColor grayColor];
//        summaryLabel.font=[UIFont systemFontOfSize:10];
//        [backView addSubview:summaryLabel];
//        [cell addSubview:backView];
//        cell.backgroundColor = [UIColor clearColor];
//        cell.num=1;
//        cell.ads=newmessage;
//        cell.backgroundColor = [UIColor clearColor];
//        [cell.imageViewa setImageWithURL:[NSURL URLWithString:newmessage.cover] refreshCache:NO placeholderImage:[UIImage imageNamed:@"defaultImage_102x70.png"]];
//        cell.label.text = newmessage.title;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;
//        
//        
//    }else{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSDictionary *chatInfo = [self.listArray objectAtIndex:[indexPath row]];
	for(UIView *subview in [cell.contentView subviews])
		[subview removeFromSuperview];
    
    BubbleView *bubble=[chatInfo objectForKey:@"view"];
    bubble.bubbleImageView.tag=indexPath.row;
	[cell.contentView addSubview:bubble];
    
    /*
    BubbleView *bubble2=[chatInfo objectForKey:@"view"];
    cell.bubble.fromSelf=bubble2.fromSelf;
    cell.bubble.bubbleImageView.image=bubble2.bubbleImageView.image;
    cell.bubble.bubbleImageView.frame=bubble2.bubbleImageView.frame;
    
    cell.bubble.frame=bubble2.frame;
    */
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
        return cell;
//    }
}


//对获得的数据进行打包处理，绘制成一个UIView，以便在TableView上显示
//文字
- (BubbleView *)bubbleView:(NSString *)text from:(BOOL)fromSelf date:(NSDate *)now success:(BOOL)success{
//    fromSelf=NO;
    BubbleView *returnView=[[BubbleView alloc]initWithFrame:CGRectZero];
    
    returnView.fromSelf=fromSelf;
    
    [returnView createView];
    
//    UIFont *font = [UIFont systemFontOfSize:14];
//    CGSize size = [text sizeWithFont:font constrainedToSize:CGSizeMake(150.0f, 1000.0f) lineBreakMode:UILineBreakModeCharacterWrap];
    returnView.bubbleText._string=text;
    CGSize size = [GetChatLabelSize GetChatLabelSize:text withFont:14];
    NSString *now2=@"";
    if (success) {
        now2=[self getDateWithString:now];
    }else{
//        now2=@"正在发送中...";
    }
    
    if (fromSelf) {
        
        returnView.bubbleText.frame = CGRectMake(152-size.width, 34.0f, size.width+5, size.height+5);
        returnView.bubbleImageView.frame = CGRectMake(140-size.width, 25.0f, size.width+30.0f, size.height+30.0f);
        returnView.activityView.frame=CGRectMake(115-size.width, (size.height+40.0f)/2, 20, 20);
        returnView.state.frame=CGRectMake(115-size.width, (size.height+40.0f)/2, 20, 20);
        returnView.noFaceImage.frame = CGRectMake(175.0f, 25.0f, 40.0f, 40.0f);
        returnView.iconImgView.frame = CGRectMake(175.0f, 25.0f, 40.0f, 40.0f);
        [returnView.iconImgView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",singleInfo.headImg]] refreshCache:NO placeholderImage:[UIImage imageNamed:@"touxiang.png"]];
        returnView.frame = CGRectMake(kDeviceWidth - 220 -50, 0.0f, 220.0f, size.height+55.0f);
        returnView.contentImage.frame=CGRectZero;
        returnView.timeBg.frame=CGRectMake(90-size.width, 0, 109, 23);
        returnView.time.text=now2;
        returnView.time.frame=CGRectMake(100-size.width, 5, 95, 13);
        returnView.noFaceImage.image = [UIImage imageNamed:@"touxiang.png"];
        
    }else {
        returnView.bubbleText.frame = CGRectMake(67.5f, 34.0f, size.width+5, size.height+5);
        returnView.bubbleImageView.frame = CGRectMake(50.0f, 25.0f, size.width+30.0f, size.height+30.0f);
        returnView.activityView.frame=CGRectMake(size.width+85, (size.height+40.0f)/2, 20, 20);
        returnView.state.frame=CGRectMake(size.width+85, (size.height+40.0f)/2, 20, 20);
        returnView.noFaceImage.frame = CGRectMake(5.0f, 25.0f, 40.0f, 40.0f);
        returnView.iconImgView.frame = CGRectMake(5.0f, 25.0f, 40.0f, 40.0f);
        [returnView.iconImgView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",toMemberHeadImg]] refreshCache:NO placeholderImage:[UIImage imageNamed:@"icon.png"]];
//        [returnView.iconImgView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",FACE_IP,chatInfo2.sendUserFace]]];
        returnView.frame = CGRectMake(00.0f, 0.0f, 220.0f, size.height+55.0f);
        returnView.contentImage.frame=CGRectZero;
        returnView.timeBg.frame=CGRectMake(size.width+24, 0, 109, 23);
        returnView.time.text=now2;
        returnView.time.frame=CGRectMake(size.width+34, 5, 95, 13);
        returnView.noFaceImage.image = [UIImage imageNamed:@"icon_notifacation.png"];
    }
    [returnView.bubbleImageView addTarget:self action:@selector(bubbleImageViewAction:) forControlEvents:UIControlEventTouchUpInside];
    return returnView ;
}
//照片
-(BubbleView *)bubbleView2:(UIImage *)image from:(BOOL)fromSelf date:(NSDate *)now success:(BOOL)success message:(WcmCmsMemberMessage *)newMessage{
//    fromSelf=NO;
    BubbleView *returnView=[[BubbleView alloc]initWithFrame:CGRectZero];
    
    returnView.fromSelf=fromSelf;
    
    [returnView createView];
    
    float w=image.size.width;
    float h=image.size.height;
    if ((w/h)>1) {
        h=(120*h)/w;
        w=120;
    }else if((w/h<1)){
        w=(120*w)/h;
        h=120;
    }else{
        w=120;
        h=120;
    }
    if (fromSelf) {
        returnView.contentImage.image=image;
    }else{
        [returnView.contentImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",newMessage.fileAddress]]];
    }
    
    
    NSString *now2=@"";
    if (success) {
        now2=[self getDateWithString:now];
    }else{
//        now2=@"正在发送中...";
    }
    
    if (fromSelf) {
        returnView.contentImage.frame=CGRectMake(152-w, 38, w, h);
        returnView.bubbleImageView.frame = CGRectMake(140-w, 25.0f, w+30, h+30.0f);
        returnView.activityView.frame=CGRectMake(115-w, (h+40)/2, 20, 20);
        returnView.state.frame=CGRectMake(115-w, (h+40)/2, 20, 20);
        returnView.noFaceImage.frame = CGRectMake(175.0f, 25.0f, 40.0f, 40.0f);
        returnView.iconImgView.frame = CGRectMake(175.0f, 25.0f, 40.0f, 40.0f);
        [returnView.iconImgView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",singleInfo.headImg]] refreshCache:NO placeholderImage:[UIImage imageNamed:@"touxiang.png"]];
        returnView.frame = CGRectMake(100.0f, 0.0f, 220.0f, h+55.0f);
        returnView.timeBg.frame=CGRectMake(90-w, 0, 109, 23);
        returnView.time.text=now2;
        returnView.time.frame=CGRectMake(100-w, 5, 95, 13);
        returnView.noFaceImage.image = [UIImage imageNamed:@"icon_notifacation.png"];
    }else {
        returnView.contentImage.frame=CGRectMake(67.5, 38, w, h);
        returnView.bubbleImageView.frame = CGRectMake(50.0f, 25.0f, w+30.0f, h+30.0f);
        returnView.activityView.frame=CGRectMake(w+85, (h+40)/2, 20, 20);
        returnView.state.frame=CGRectMake(w+85, (h+40)/2, 20, 20);
        returnView.noFaceImage.frame = CGRectMake(5.0f, 25.0f, 40.0f, 40.0f);
        returnView.iconImgView.frame = CGRectMake(5.0f, 25.0f, 40.0f, 40.0f);
        [returnView.iconImgView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",toMemberHeadImg]]];
        returnView.frame = CGRectMake(0.0f, 0.0f, 220.0f, h+55.0f);
        returnView.timeBg.frame=CGRectMake(w+24, 0, 109, 23);
        returnView.time.text=now2;
        returnView.time.frame=CGRectMake(w+34, 5, 95, 13);
        returnView.noFaceImage.image = [UIImage imageNamed:@"icon_notifacation.png"];
    }
    [returnView.bubbleImageView addTarget:self action:@selector(bubbleImageViewAction:) forControlEvents:UIControlEventTouchUpInside];
    return returnView;
}
//语音
- (BubbleView *)bubbleView3:(NSString *)text from:(BOOL)fromSelf date:(NSDate *)now isNew:(BOOL)isNew success:(BOOL)success{
//    fromSelf=NO;
    BubbleView *returnView=[[BubbleView alloc]initWithFrame:CGRectZero];
    
    returnView.fromSelf=fromSelf;
    
    [returnView createView];
    
    UIFont *font = [UIFont systemFontOfSize:12];
    CGSize size = [text sizeWithFont:font constrainedToSize:CGSizeMake(130.0f, 1000.0f) lineBreakMode:UILineBreakModeCharacterWrap];
    returnView.bubbleText._string=text;
    
    NSString *now2=@"";
    if (success) {
        now2=[self getDateWithString:now];
    }else{
//        now2=@"正在发送中...";
    }
    
    if (fromSelf) {
        returnView.bubbleText.frame = CGRectMake(125-size.width, 34.0f, size.width+5, size.height+5);
        returnView.bubbleImageView.frame = CGRectMake(110-size.width, 25.0f, size.width+60.0f, size.height+30.0f);
        returnView.activityView.frame=CGRectMake(85-size.width,  (size.height+40.0f)/2, 20, 20);
        returnView.state.frame=CGRectMake(85-size.width,  (size.height+40.0f)/2, 20, 20);
        returnView.noFaceImage.frame = CGRectMake(175.0f, 25.0f, 40.0f, 40.0f);
        returnView.iconImgView.frame = CGRectMake(175.0f, 25.0f, 40.0f, 40.0f);
        [returnView.iconImgView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",singleInfo.headImg]] refreshCache:NO placeholderImage:[UIImage imageNamed:@"touxiang.png"]];
        returnView.frame = CGRectMake(100.0, 0.0f, 220.0f, size.height+55.0f);
        returnView.contentImage.frame=CGRectMake(135, 35, 16, 20);
        returnView.voiceImage.frame=CGRectMake(135, 35, 16, 20);
        returnView.voiceImage.hidden=YES;
        
        returnView.contentImage.image=[UIImage imageNamed:@"chatto_voice_playing.png"];
        returnView.timeBg.frame=CGRectMake(60-size.width, 0, 109, 23);
        returnView.time.text=now2;
        returnView.time.frame=CGRectMake(70-size.width, 5, 95, 13);
        returnView.noFaceImage.image = [UIImage imageNamed:@"touxiang.png"];
        
    }else {
        returnView.bubbleText.frame = CGRectMake(95.0f, 34.0f, size.width+5, size.height+5);
        returnView.bubbleImageView.frame = CGRectMake(50.0f, 25.0f, size.width+60.0f, size.height+30.0f);
        returnView.activityView.frame=CGRectMake(size.width+115, (size.height+40.0f)/2, 20, 20);
        returnView.state.frame=CGRectMake(size.width+115, (size.height+40.0f)/2, 20, 20);
        returnView.noFaceImage.frame = CGRectMake(5.0f, 25.0f, 40.0f, 40.0f);
        returnView.iconImgView.frame = CGRectMake(5.0f, 25.0f, 40.0f, 40.0f);
        [returnView.iconImgView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",toMemberHeadImg]]];
        returnView.frame = CGRectMake(0.0f, 0.0f, 220.0f, size.height+55.0f);
        returnView.contentImage.frame=CGRectMake(70, 35, 16, 20);
        returnView.voiceImage.frame=CGRectMake(70, 35, 16, 20);
        returnView.voiceImage.hidden=YES;
        
        returnView.contentImage.image=[UIImage imageNamed:@"chatfrom_voice_playing.png"];
        returnView.timeBg.frame=CGRectMake(size.width+54, 0, 109, 23);
        returnView.time.text=now2;
        returnView.time.frame=CGRectMake(size.width+64, 5, 95, 13);
        returnView.noFaceImage.image = [UIImage imageNamed:@"icon_notifacation.png"];
        if (isNew) {
            returnView.noRead.frame=CGRectMake(size.width+110.0f, 25, 9, 9);
        }
    }
    [returnView.bubbleImageView addTarget:self action:@selector(bubbleImageViewAction:) forControlEvents:UIControlEventTouchUpInside];
    return returnView;
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    //tag 1:文字 2:图片 3:语音 
    if (selectSendSuccess) {//发送成功
        switch (actionSheet.tag) {
            case 1:{
                switch (buttonIndex) {
                    case 0:{//删除
                        [self deleteAction:1];
                        break;
                    }
                    case 1:{//复制
                        NSDictionary *chatInfo = [listArray objectAtIndex:selectRow];
                        WcmCmsMemberMessage *_message=[chatInfo objectForKey:@"text"];
                        NSString *content=_message.textMessage;
                        UIPasteboard *pasteboard=[UIPasteboard generalPasteboard];
                        pasteboard.string = content;
                        [self showToast:@"已复制"];
                        break;
                    }
                    default:
                        break;
                }
                break;
            }   
            case 2:{
                switch (buttonIndex) {
                    case 0:{//删除
                        [self deleteAction:3];
                        break;
                    }
                    case 1:{//存储
                        NSDictionary *chatInfo = [listArray objectAtIndex:selectRow];
                        WcmCmsMemberMessage *_message=[chatInfo objectForKey:@"image"];
                        UIImage *content=[UIImage imageWithContentsOfFile:_message.fileAddress];
                        UIImageWriteToSavedPhotosAlbum(content, self, nil, nil);
                        break;
                    }
                    default:
                        break;
                }
                break;
            }
            case 3:{
                switch (buttonIndex) {
                    case 0:{//删除
                        [self deleteAction:2];
                        break;
                    }
                    default:
                        break;
                }
                break;
            }
            case 4:{
                switch (buttonIndex) {
                    case 0:{//删除
                        [self deleteAction:4];
                        break;
                    }
                    default:
                        break;
                }
                break;
            }
            case 5:{
                switch (buttonIndex) {
                    case 0:{//删除
                        [self deleteAction:5];
                        break;
                    }
                    default:
                        break;
                }
                break;
            }
            case 951:{//新闻
                switch (buttonIndex) {
                    case 0:{//删除
                        [self deleteAction:95];
                        break;
                    }
                    case 1:{//复制
                        NSDictionary *chatInfo = [listArray objectAtIndex:selectRow];
                        WcmCmsMemberMessage *_message=[chatInfo objectForKey:@"news"];
                        NSString *content=_message.textMessage;
                        UIPasteboard *pasteboard=[UIPasteboard generalPasteboard];
                        pasteboard.string = content;
                        [self showToast:@"已复制"];
                        break;
                    }
                    default:
                        break;
                }
                break;
            }
            case 961:{//动态
                switch (buttonIndex) {
                    case 0:{//删除
                        [self deleteAction:96];
                        break;
                    }
                    case 1:{//复制
                        NSDictionary *chatInfo = [listArray objectAtIndex:selectRow];
                        WcmCmsMemberMessage *_message=[chatInfo objectForKey:@"text"];
                        NSString *content=_message.textMessage;
                        UIPasteboard *pasteboard=[UIPasteboard generalPasteboard];
                        pasteboard.string = content;
                        [self showToast:@"已复制"];
                        break;
                    }
                    default:
                        break;
                }
                break;
            }
            case 952:{//新闻
                switch (buttonIndex) {
                    case 0:{//删除
                        [self deleteAction:95];
                        break;
                    }
                    default:
                        break;
                }
                break;
            }
            case 962:{//动态
                switch (buttonIndex) {
                    case 0:{//删除
                        [self deleteAction:96];
                        break;
                    }
                    default:
                        break;
                }
                break;
            }
            default:
                break;
        }
    }else{//发送失败
        if (chatData==nil) {
            chatData=[[ChatData alloc]init];
        }
        switch (actionSheet.tag) {
            case 1:{
                switch (buttonIndex) {
                    case 0:{//删除
                        sendState=YES;
                        [self deleteAction:1];
                    
                        break;
                    }
                    case 1:{//重新发送
                        NSDictionary *chatInfo = [listArray objectAtIndex:selectRow];
                        BubbleView *returnView=[chatInfo objectForKey:@"view"];
                        returnView.state.hidden=YES;
                        [returnView.activityView startAnimating];
                        returnView.time.text=@"正在发送中...";
                        WcmCmsMemberMessage *_message=[chatInfo objectForKey:@"text"];
                        _message.status=0;
                        [chatData updateMessageSendStatus:_message.identity status:0];
                        [self sendMessage:_message uuid:_message.identity];
                        sendType=1;
                        sendRow=selectRow;
                        break;
                    }
                    case 2:{
                        NSDictionary *chatInfo = [listArray objectAtIndex:selectRow];
                        WcmCmsMemberMessage *_message=[chatInfo objectForKey:@"text"];
                        NSString *content=_message.textMessage;
                        UIPasteboard *pasteboard=[UIPasteboard generalPasteboard];
                        pasteboard.string = content;
                        [self showToast:@"已复制"];
                        break;
                    }
                    default:
                        break;
                }
                break;
            }   
            case 2:{
                switch (buttonIndex) {
                    case 0:{//删除
                        sendState=YES;
                        [self deleteAction:3];
                        break;
                    }
                    case 1:{//重新发送
                        NSDictionary *chatInfo = [listArray objectAtIndex:selectRow];
                        BubbleView *returnView=[chatInfo objectForKey:@"view"];
                        returnView.state.hidden=YES;
                        [returnView.activityView startAnimating];
                        returnView.time.text=@"正在发送中...";
                        WcmCmsMemberMessage *_message=[chatInfo objectForKey:@"image"];
                        _message.status=0;
                        [chatData updateMessageSendStatus:_message.identity status:0];
                        [self sendMessage:_message uuid:_message.identity];
                        sendType=3;
                        sendRow=selectRow;
                        break;
                    }
                    case 2:{//保存
                        NSDictionary *chatInfo = [listArray objectAtIndex:selectRow];
                        WcmCmsMemberMessage *_message=[chatInfo objectForKey:@"image"];
                        UIImage *image=[UIImage imageWithContentsOfFile:_message.fileAddress];
                        UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
                        break;
                    }
                    default:
                        break;
                }
                break;
                break;
            }
            case 3:{
                switch (buttonIndex) {
                    case 0:{//删除
                        sendState=YES;
                        [self deleteAction:2];
                        break;
                    }
                    case 1:{//重新发送
                        NSDictionary *chatInfo = [listArray objectAtIndex:selectRow];
                        BubbleView *returnView=[chatInfo objectForKey:@"view"];
                        returnView.state.hidden=YES;
                        [returnView.activityView startAnimating];
                        returnView.time.text=@"正在发送中...";
                        WcmCmsMemberMessage *_message=[chatInfo objectForKey:@"voice"];
                        _message.status=0;
                        [chatData updateMessageSendStatus:_message.identity status:0];
                        [self sendMessage:_message uuid:_message.identity];
                        sendType=2;
                        sendRow=selectRow;
                        break;
                    }
                    default:
                        break;
                }
                break;
            }
            case 4:{
                switch (buttonIndex) {
                    case 0:{//删除
                        sendState=YES;
                        [self deleteAction:4];
                        break;
                    }
                    case 1:{//重新发送
                        NSDictionary *chatInfo = [listArray objectAtIndex:selectRow];
                        BubbleView *returnView=[chatInfo objectForKey:@"view"];
                        returnView.state.hidden=YES;
                        [returnView.activityView startAnimating];
                        returnView.time.text=@"正在发送中...";
                        WcmCmsMemberMessage *_message=[chatInfo objectForKey:@"voice"];
                        _message.status=0;
                        [chatData updateMessageSendStatus:_message.identity status:0];
                        [self sendMessage:_message uuid:_message.identity];
                        sendType=4;
                        sendRow=selectRow;
                        break;
                    }
                    default:
                        break;
                }
                break;
            }
            case 5:{
                switch (buttonIndex) {
                    case 0:{//删除
                        sendState=YES;
                        [self deleteAction:5];
                        break;
                    }
                    case 1:{//重新发送
                        NSDictionary *chatInfo = [listArray objectAtIndex:selectRow];
                        BubbleView *returnView=[chatInfo objectForKey:@"view"];
                        returnView.state.hidden=YES;
                        [returnView.activityView startAnimating];
                        returnView.time.text=@"正在发送中...";
                        WcmCmsMemberMessage *_message=[chatInfo objectForKey:@"voice"];
                        _message.status=0;
                        [chatData updateMessageSendStatus:_message.identity status:0];
                        [self sendMessage:_message uuid:_message.identity];
                        sendType=5;
                        sendRow=selectRow;
                        break;
                    }
                    default:
                        break;
                }
                break;
            }
            default:
                break;
        }
    }
    switch (actionSheet.tag) {
        case 7:{
            switch (buttonIndex) {
                case 0:{
                    [self takePhoto];
                    break;
                }
                case 1:{
                    [self addPhoto];
                    break;
                }
                default:
                    break;
            }
            break;
        }   
        case 8:{
            switch (buttonIndex) {
                case 0:{
                    [self takeVideo];
                    break;
                }
                case 1:{
                    [self addVideo];
                    break;
                }
                default:
                    break;
            }
            break;
        }
        
    }
    
}



//录音
#pragma mark -
-(void)voiceAction{
    [recordHUD stopVoice];
    recordHUD.view.hidden=YES;
    if (_avRecorder) {
        NSError *error=nil;
        @try {
            [_avRecorder stop];
            _avRecorder=Nil;
            if (endRcd) {
                endRcd=nil;
            }
            endRcd=[NSDate date];
            [self toMp3:self._lastRecordFileName];
            
        }
        @catch (NSException *exception) {
            NSLog(@"%@",[exception description]);
            
        }
        @finally {
            NSLog(@"%@",[error description]);
        }
    }
    
}

-(void)recordAction{
    if (sendState) {
        NSDateFormatter *fileNameFormatter = [[NSDateFormatter alloc] init];
        [fileNameFormatter setDateFormat:@"yyyyMMddhhmmss"];
        NSString *fileName = [self uuid];//[fileNameFormatter stringFromDate:[NSDate date]];
        self._lastRecordFileName=fileName;
        
        fileName = [fileName stringByAppendingString:@".caf"];
        NSString *cafFilePath = [_strMp3Path stringByAppendingPathComponent:fileName];
        
        NSURL *cafURL = [NSURL fileURLWithPath:cafFilePath];
        
        NSError *error;
        
        NSDictionary *recordFileSettings = [NSDictionary 
                                            dictionaryWithObjectsAndKeys:
                                            [NSNumber numberWithInt:AVAudioQualityMin],
                                            AVEncoderAudioQualityKey,
                                            [NSNumber numberWithInt:16], 
                                            AVEncoderBitRateKey,
                                            [NSNumber numberWithInt: 2], 
                                            AVNumberOfChannelsKey,
                                            [NSNumber numberWithFloat:8000.0], 
                                            AVSampleRateKey,
                                            nil];
        
        @try {
            if (!_avRecorder) {
                _avRecorder = [[AVAudioRecorder alloc] initWithURL:cafURL settings:recordFileSettings error:&error];
            }else {
                if ([_avRecorder isRecording]) {
                    [_avRecorder stop];
                }
                _avRecorder=Nil;
                _avRecorder = [[AVAudioRecorder alloc] initWithURL:cafURL settings:recordFileSettings error:&error];
            }
            
            if (_avRecorder) {        
                [_avRecorder prepareToRecord];        
                _avRecorder.meteringEnabled = YES;
                [_avRecorder record];
                
                if (beginRcd) {
                    beginRcd=nil;
                }
                beginRcd=[NSDate date];
                
            } 
        }
        @catch (NSException *exception) {
            NSLog(@"%@",[exception description]);
        }
        @finally {
            NSLog(@"%@",[error description]);
        }
        
        if (recordHUD==nil) {
            recordHUD=[[RecordHUD2 alloc]init];
            recordHUD.view.frame=CGRectMake(0, 0, kDeviceWidth, KDeviceHeight);
            [self.view addSubview:recordHUD.view];
        }
        recordHUD.view.hidden=NO;
        [recordHUD startVoice];
    }
    
}

- (void)toMp3:(NSString*)cafFileName
{
    
   /* NSString *cafFilePath =[_strMp3Path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.caf",cafFileName]];
    
    NSString *mp3FileName = [cafFileName stringByAppendingString:@".mp3"];
    NSString *mp3FilePath = [_strMp3Path stringByAppendingPathComponent:mp3FileName];
    
    @try {
        int read, write;
        
        FILE *pcm = fopen([cafFilePath cStringUsingEncoding:1], "rb");//被转换的文件
        FILE *mp3 = fopen([mp3FilePath cStringUsingEncoding:1], "wb");//转换后文件的存放位置
        
        const int PCM_SIZE = 8192;
        const int MP3_SIZE = 8192;
        short int pcm_buffer[PCM_SIZE*2];
        unsigned char mp3_buffer[MP3_SIZE];
        
        lame_t lame = lame_init();
        lame_set_in_samplerate(lame, 8000);
        lame_set_VBR(lame, vbr_default);
        lame_init_params(lame);
        
        do {
            read = fread(pcm_buffer, 2*sizeof(short int), PCM_SIZE, pcm);
            if (read == 0)
                write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
            else
                write = lame_encode_buffer_interleaved(lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
            
            fwrite(mp3_buffer, write, 1, mp3);
            
        } while (read != 0);
        
        lame_close(lame);
        fclose(mp3);
        fclose(pcm);
        
        
    }
    @catch (NSException *exception) {
        NSLog(@"%@",[exception description]);
    }
    @finally {
        
    }
    
    int timeDuration=(int)[endRcd timeIntervalSinceDate:beginRcd];
    if (timeDuration>0) {
        int hours=timeDuration/3600;
        int minutes=timeDuration/60;
        int seconds=timeDuration;
        NSString *time=@"";
        if (hours>0) {
            int seconds2=timeDuration%3600;
            if (seconds2>=60) {
                minutes=seconds/60;
                seconds=seconds2%60;
            }else{
                minutes=0;
                seconds=seconds2;
            }
            time=[NSString stringWithFormat:@"%d %d'%d\"",hours,minutes,seconds];
        }else if (minutes>0) {
            seconds=timeDuration%60;
            time=[NSString stringWithFormat:@"%d'%d\"",minutes,seconds];
        }else{
            time=[NSString stringWithFormat:@"%d\"",seconds];
        }
        
        NSString *uuid=cafFileName;
        NSURL *mp3URL=[NSURL fileURLWithPath:mp3FilePath];
        NSData *voiceData=[NSData dataWithContentsOfURL:mp3URL];
        NSString *voiceString=[ChangeData data2String:voiceData];
        NSDate *date=[NSDate date];
        
        if (createChatObject==nil) {
            createChatObject=[[CreateChatObject alloc]init];
        }
        
        WcmCmsMemberMessage *newmessage;
            newmessage=[createChatObject getMessage:voiceString uuid:uuid date:date type:2 length:timeDuration fileName:uuid receiveInfo:chatInfo2];
        
        
        isMySpeaking=YES;
        BubbleView *chatView = [self bubbleView3:time from:isMySpeaking date:[NSDate date] isNew:NO success:NO];
        if ([self connectedToNetWork]) {
            [localArray addObject:newmessage];
            [listArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:newmessage, @"voice", isMySpeaking?@"self":@"other", @"speaker", chatView, @"view", [NSNumber numberWithInt:timeDuration], @"time", nil]];
            [listView reloadData];
            sendRow=[listArray count]-1;
            [listView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:sendRow inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
            
            //发送声音
            [self sendMessage:newmessage uuid:uuid];
            sendType=2;
        }else{
            [chatView.activityView stopAnimating];
            chatView.state.hidden=NO;
            chatView.isSuccess=NO;
            newmessage.status=0;
            [localArray addObject:newmessage];
            [listArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:newmessage, @"voice", isMySpeaking?@"self":@"other", @"speaker", chatView, @"view", [NSNumber numberWithInt:timeDuration], @"time", nil]];
            [listView reloadData];
            [listView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[listArray count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        }
        
        [NSThread detachNewThreadSelector:@selector(saveMessage:) toTarget:self withObject:newmessage];
        
        NSFileManager *fileManager=[NSFileManager defaultManager];
        [fileManager removeItemAtPath:cafFilePath error:nil];
    }
    */
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WcmCmsMemberMessage *newmessage=[self.localArray objectAtIndex:indexPath.row];
    if (newmessage.messageTypeId==7) {
        notificationMessage *notimessage = [[notificationMessage alloc]init];
        notimessage.notifiction = newmessage;
        [self.navigationController pushViewController:notimessage animated:YES];
    }else{
    NSDictionary *chatInfo = [listArray objectAtIndex:indexPath.row];
    
    if([chatInfo objectForKey:@"voice"]){
        if (playRow!=indexPath.row) {
            WcmCmsMemberMessage *_message=[chatInfo objectForKey:@"voice"];
            NSString *mp3Path=[NSString stringWithFormat:@"%@/Documents/ChatFiles/%@",NSHomeDirectory(),_message.fileAddress];
            NSData *mp3Data=[NSData dataWithContentsOfFile:mp3Path];
            
            NSError *error=nil;
            if (!_avPlayer) {
                _avPlayer= [[AVAudioPlayer alloc] initWithData:mp3Data error:&error];
            }else {
                if ([_avPlayer isPlaying]) {
                    [_avPlayer stop];
                    [self stopAvplayer:playRow];
                }
                _avPlayer=nil;
                _avPlayer= [[AVAudioPlayer alloc] initWithData:mp3Data error:&error];
            }
            
            _avPlayer.volume = 1.0;
            _avPlayer.numberOfLoops= 0;
            if(_avPlayer== nil){
                NSLog(@"%@", [error description]);
                
            }else{
                [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayAndRecord error: nil];
                _avPlayer.delegate=self;
                [_avPlayer play];
                
                playRow=indexPath.row;  
                
                BubbleView *bubble=[chatInfo objectForKey:@"view"];
                bubble.voiceImage.hidden=NO;
                [bubble.voiceImage startAnimating];
                BOOL fromSelf=bubble.fromSelf;
                if (!fromSelf) {
                    bubble.noRead.frame=CGRectZero;
                }
                _message.status=1;
                
                if (chatData==nil) {
                    chatData=[[ChatData alloc]init];
                }
                [chatData updateMessageIsPlay:_message.identity];
                
            }
        }
        
        
    }else if([chatInfo objectForKey:@"image"]){
//        BbsMemberNewMessage *_message=[chatInfo objectForKey:@"image"];
//        NSString *imagePath=[NSString stringWithFormat:@"%@/Documents/ChatFiles/%@",NSHomeDirectory(),_message.fileAddress];
//        UIImage *image=[UIImage imageWithContentsOfFile:imagePath];
   
    }else if([chatInfo objectForKey:@"video"]){
        WcmCmsMemberMessage *message=[chatInfo objectForKey:@"video"];
        NSString *imagePath=[NSString stringWithFormat:@"%@/Documents/ChatFiles/%@",NSHomeDirectory(),message.fileAddress];
        [self playVideo:[NSURL URLWithString:imagePath]];
    }else if([chatInfo objectForKey:@"dynamic"]){
        
    }
    }
    
}


- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    [self stopAvplayer:playRow];
    playRow=-1;
}

-(void)stopAvplayer:(int)row{
    NSDictionary *chatInfo = [listArray objectAtIndex:row];
    BubbleView *bubble=[chatInfo objectForKey:@"view"];
    bubble.voiceImage.hidden=YES;
    
}

-(void)bubbleImageViewAction:(id)sender{
    UIButton *btn=(UIButton *)sender;
    
    int row=btn.tag;
    
    NSDictionary *chatInfo = [listArray objectAtIndex:row];
    
    if([chatInfo objectForKey:@"voice"]){
        if (playRow!=row) {
            WcmCmsMemberMessage *_message=[chatInfo objectForKey:@"voice"];
            NSString *mp3Path=[NSString stringWithFormat:@"%@/Documents/ChatFiles/%@",NSHomeDirectory(),_message.fileAddress];
            NSData *mp3Data;
            if (_message.addUserId!=singleInfo.identity) {
                mp3Data=[NSData dataWithContentsOfURL:[NSURL URLWithString:_message.fileAddress]];
            }else{
                mp3Data=[NSData dataWithContentsOfFile:mp3Path];
            }
            NSError *error=nil;
            if (!_avPlayer) {
                _avPlayer= [[AVAudioPlayer alloc] initWithData:mp3Data error:&error];
            }else {
                if ([_avPlayer isPlaying]) {
                    [_avPlayer stop];
                    [self stopAvplayer:playRow];
                }
            
                _avPlayer=nil;
                _avPlayer= [[AVAudioPlayer alloc] initWithData:mp3Data error:&error];
            }
            
            _avPlayer.volume = 1.0;
            _avPlayer.numberOfLoops= 0;
            if(_avPlayer== nil){
                NSLog(@"%@", [error description]);
                
            }
            else
            {
                [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayAndRecord error: nil];
                _avPlayer.delegate=self;
                [_avPlayer play];
                
                playRow=row;  
                
                BubbleView *bubble=[chatInfo objectForKey:@"view"];
                bubble.voiceImage.hidden=NO;
                [bubble.voiceImage startAnimating];
                BOOL fromSelf=bubble.fromSelf;
                if (!fromSelf) {
                    bubble.noRead.frame=CGRectZero;
                }
                _message.status=1;
                
                if (chatData==nil) {
                    chatData=[[ChatData alloc]init];
                }
                if (_message.addUserId!=self.singleInfo.identity) {
//                    [chatData updateMessageIsPlay:_message.identity];
                }
                
                
            }
        }
        
        
    }else if([chatInfo objectForKey:@"image"]){
        /*BbsMemberNewMessage *_message=[chatInfo objectForKey:@"image"];
        NSString *imagePath=[NSString stringWithFormat:@"%@/Documents/ChatFiles/%@",NSHomeDirectory(),_message.fileAddress];
        UIImage *image=[UIImage imageWithContentsOfFile:imagePath];
        SingePicView *singeView=[[SingePicView alloc]initWithNibName:nil bundle:nil];
        singeView.image=image;
        [self presentModalViewController:singeView animated:YES];
         */
    }else if([chatInfo objectForKey:@"video"]){
        WcmCmsMemberMessage *_message=[chatInfo objectForKey:@"video"];
        NSString *imagePath=[NSString stringWithFormat:@"%@/Documents/ChatFiles/%@",NSHomeDirectory(),_message.fileAddress];
        [self playVideo:[NSURL URLWithString:imagePath]];
    }else if([chatInfo objectForKey:@"dynamic"]){
        
    }
}

-(void)checkNewsAction:(id)sender{
    UIButton *btn=(UIButton *)sender;
    int row=btn.tag;
    NSDictionary *chatInfo = [listArray objectAtIndex:row];
    
    if([chatInfo objectForKey:@"news"]){
        WcmCmsMemberMessage *_message=[chatInfo objectForKey:@"news"];
        CheckNewsView *newsView=[[CheckNewsView alloc]init];
        newsView.urlStr=_message.fileAddress;
        [self.navigationController pushViewController:newsView animated:YES];
    }else if([chatInfo objectForKey:@"dynamic"]){
        
    }
    
    
}

//根据视频url播放视频
- (void) playVideo:(NSURL *) movieURL
{
    MPMoviePlayerViewController *playerViewController = [[MPMoviePlayerViewController alloc] initWithContentURL:movieURL];      
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieFinishedCallback:) name:MPMoviePlayerPlaybackDidFinishNotification object:[playerViewController moviePlayer]];
    playerViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    playerViewController.view.frame=CGRectMake(0, 0, kDeviceWidth, KDeviceHeight);
    
    //-- add to view---
    [[UIApplication sharedApplication].keyWindow addSubview:playerViewController.view];          
//    [self.view addSubview:playerViewController.view];
    
    //---play movie---      
    MPMoviePlayerController *player = [playerViewController moviePlayer];
    player.movieSourceType=MPMovieSourceTypeFile;
    //修复ios5.0以上版本真机只有图像没有声音    
    player.useApplicationAudioSession=NO;        
    
    //加载确定位置和宽高
    player.view.frame=CGRectMake(0 , 0 , kDeviceWidth, KDeviceHeight);
    
    [player play];
}

//当点击Done按键或者播放完毕时调用此函数
- (void) movieFinishedCallback:(NSNotification *)aNotification
{
    MPMoviePlayerController *player = [aNotification object];      
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:player];      
    [player stop];      
    [player.view removeFromSuperview];
}

//发送消息
-(void)sendMessage:(WcmCmsMemberMessage *)message uuid:(NSString *)_uuid{
//    [self connectServer:HOST_IP port:HOST_PORT];
//    if (pub==nil) {
//        pub=[[PublicObject alloc]init];
//    }
//    
////    NSString *deviceNo=[[NSUserDefaults standardUserDefaults] objectForKey:@"serialNumber"];
////    if ([deviceNo isEqualToString:@"(null)"] || [deviceNo isEqualToString:@""] || deviceNo==nil) {
////        deviceNo=_uuid;
////    }
//    
//    NSString *sendString=[pub getXmlWithObject:message withName:@"BbsMemberNewMessage" withNameSpace:CHAT_NEW_NAME_SPACE withMethod:CHAT_SEND_MESSAGE];
//    
//    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8);
//    NSData *data = [sendString dataUsingEncoding:enc];  
//    [sock writeData:data withTimeout:-1 tag:9786];
//    [sock readDataWithTimeout:-1 tag:9786];
    if ([commonJudgeMent ifConnectNet]){
        
        //        举例：BASEURL//saleout/saleout_list.jsp?sid=10&longitude=0&latitude=0&distance=26400&page_size=2&start_page=1&is_page=1
//        NSString *str=[self createProperties:message];//设置参数
        NSMutableArray *urlArray = [[NSMutableArray alloc] init];
        
        jkMessage.addUser = singleInfo.name;
        jkMessage.memberId = singleInfo.identity;
        jkMessage.toMemberId = toMemberId;
        jkMessage.messageType = 5;
        if(sendMessageFlag == -1)
        {
            jkMessage.isAll = 1;
        }
        else{
            jkMessage.isAll = 0;
        }
        jkMessage.textMessage = message.textMessage;
        
        [urlArray addObject:[[MyDictionary alloc] initWithName:@"obj.add_user" Andvale:singleInfo.name]];
        [urlArray addObject:[[MyDictionary alloc] initWithName:@"obj.member_id" Andvale:[NSNumber numberWithInt:singleInfo.identity]]];
        [urlArray addObject:[[MyDictionary alloc] initWithName:@"obj.to_member_id" Andvale:[NSNumber numberWithInt:toMemberId]]];
        [urlArray addObject:[[MyDictionary alloc] initWithName:@"obj.message_type" Andvale:[NSNumber numberWithInt:5]]];
        if(sendMessageFlag == -1)
        {
        [urlArray addObject:[[MyDictionary alloc] initWithName:@"obj.is_all" Andvale:[NSNumber numberWithInt:1]]];
        [urlArray addObject:[[MyDictionary alloc] initWithName:@"company_id" Andvale:[NSNumber numberWithInt:singleInfo.companyId]]];
        }
        else{
            [urlArray addObject:[[MyDictionary alloc] initWithName:@"obj.is_all" Andvale:[NSNumber numberWithInt:0]]];

        }
        [urlArray addObject:[[MyDictionary alloc] initWithName:@"obj.text_message" Andvale:message.textMessage]];

        [urlArray addObject:[[MyDictionary alloc] initWithName:@"table_name" Andvale:@"jk_message"]];


        NSString *str=[self objectToUrl:urlArray];//设置参数

        if (str!=nil && ![str isEqualToString:@""]) {
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,SUBMIT_URL]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
            [request setHTTPMethod:@"POST"];
            NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
            [request setHTTPBody:data];
            //第二步，连接服务器
            connection1 = [[NSURLConnection alloc]initWithRequest:request delegate:self];
        }
    }else{
        [commonAction showToast:NONETWORK WhithNavigationController:self.navigationController];
    }

    sendState=NO;
    
}

- (NSString *)objectToUrl:(NSMutableArray *)myObjectArray
{
    NSMutableString *urlString = [[NSMutableString alloc] init];
    for (MyDictionary *object in myObjectArray)
    {
        [urlString appendString:@"&"];
        [urlString appendString:[NSString stringWithFormat:@"%@=%@",object.name,object.value]];
        
        
    }
    return urlString;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if (connection==connection1) {
        NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
        NSLog(@"%@",[res allHeaderFields]);
        self.receiveData1 = [NSMutableData data];
    }
}

//接收到服务器传输数据的时候调用，此方法根据数据大小执行若干次

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (connection==connection1) {
        [self.receiveData1 appendData:data];
    }
    
}
//数据传完之后调用此方法
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (connection==connection1) {
        NSString *receiveStr = [[NSString alloc]initWithData:self.receiveData1 encoding:NSUTF8StringEncoding];
//        NSLog(@"%@",receiveStr);
//        [commonAction showToast:[JsonToModel getMessageFromDictionaryData:receiveData1] WhithNavigationController:self];
        if ([JsonToModel ifSuccessFromDictionaryData:receiveData1]) {
//            [xingWangLuotableView reloadData];
            
            FMDatabaseQueue *queue = [[FMDatabaseQueue alloc]initWithPath:[ZUOYLTempHelper getPathForDocuments:@"asiastarbus.db" inDir:@"db"]];
            JkMessageDAO *dao = [[JkMessageDAO alloc]initWithDbqueue:queue];
            NSArray *array = [[NSArray alloc]initWithObjects:jkMessage, nil];
            [dao insertToDB:array[0] callback:^(BOOL block){
            }];

        }
        
//        if(textRange.length==7)
//        {
//            NSLog(@"%@",aStr);
            NSDictionary *chatInfo = [listArray objectAtIndex:sendRow];
            BubbleView *returnView=[chatInfo objectForKey:@"view"];
            [returnView.activityView stopAnimating];
            
//            SendResult *sendResult=;//=[pub isSendSuccess:aStr];
            
            if ([JsonToModel ifSuccessFromDictionaryData:receiveData1]) {
                returnView.isSuccess=YES;
                returnView.state.hidden=YES;
            }else{
                returnView.isSuccess=NO;
                returnView.state.hidden=NO;
            }
//            returnView.time.text=[self getDateWithString:sendResult.lastDate];
            
            if (chatData==nil) {
                chatData=[[ChatData alloc]init];
            }
            if ([chatInfo objectForKey:@"text"]) {
                WcmCmsMemberMessage *_message=[chatInfo objectForKey:@"text"];
                _message.status=1;
                _message.flag = 1;
//                _message.addDate=sendResult.lastDate;
                FMDatabaseQueue *queue = [[FMDatabaseQueue alloc]initWithPath:[ZUOYLTempHelper getPathForDocuments:@"asiastarbus.db" inDir:@"db"]];
                WcmCmsMemberMessageDAO* dao = [[WcmCmsMemberMessageDAO alloc]initWithDbqueue:queue];
                NSArray *array = [[NSArray alloc]initWithObjects:_message, nil];
                    [dao replaceArrayToDB:array callback:^(BOOL block){
                    
                }];
//                [chatData updateMessageSendStatus:_message.identity status:1 date:[NSDate date]];
                
            }else if([chatInfo objectForKey:@"image"]){
                WcmCmsMemberMessage *_message=[chatInfo objectForKey:@"image"];
                _message.status=1;
                _message.flag = 1;
//                _message.addDate=sendResult.lastDate;
                FMDatabaseQueue *queue = [[FMDatabaseQueue alloc]initWithPath:[ZUOYLTempHelper getPathForDocuments:@"asiastarbus.db" inDir:@"db"]];
                WcmCmsMemberMessageDAO* dao = [[WcmCmsMemberMessageDAO alloc]initWithDbqueue:queue];
                NSArray *array = [[NSArray alloc]initWithObjects:_message, nil];
                [dao replaceArrayToDB:array callback:^(BOOL block){
                    
                }];
//                [chatData updateMessageSendStatus:_message.identity status:1 date:[NSDate date]];
                
            }else if([chatInfo objectForKey:@"voice"]){
                WcmCmsMemberMessage *_message=[chatInfo objectForKey:@"voice"];
                _message.status=1;
//                _message.addDate=sendResult.lastDate;
                _message.flag = 1;
                FMDatabaseQueue *queue = [[FMDatabaseQueue alloc]initWithPath:[ZUOYLTempHelper getPathForDocuments:@"asiastarbus.db" inDir:@"db"]];
                WcmCmsMemberMessageDAO* dao = [[WcmCmsMemberMessageDAO alloc]initWithDbqueue:queue];
                NSArray *array = [[NSArray alloc]initWithObjects:_message, nil];
                [dao replaceArrayToDB:array callback:^(BOOL block){
                    
                }];
                
            }else if([chatInfo objectForKey:@"video"]){
                WcmCmsMemberMessage *_message=[chatInfo objectForKey:@"video"];
                _message.status=1;
//                _message.addDate=sendResult.lastDate;
//                [chatData updateMessageSendStatus:_message.identity status:1 date:sendResult.lastDate];
            }
            [self.listView reloadData];
            sendState=YES;
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshChatInfoList" object:nil];
            
//        }
        
        

        
    }
}

//网络请求过程中，出现任何错误（断网，连接超时等）会进入此方法
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@",[error localizedDescription]);
}

-(NSString *)createProperties:(WcmCmsMemberMessage *)message{
    NSMutableString *properties = [[NSMutableString alloc]init];
    [properties appendString:@"obj.sid=10&table_name=wcm_cms_member_message"];
    [properties appendString:[NSString stringWithFormat:@"&obj.add_user_id=%d",singleInfo.identity]];
    [properties appendString:[NSString stringWithFormat:@"&obj.add_user=%@",singleInfo.usern]];
    [properties appendString:[NSString stringWithFormat:@"&obj.member_id=%d",message.memberId]];
    [properties appendString:[NSString stringWithFormat:@"&obj.message_type_id=%d",message.messageTypeId]];
    [properties appendString:[NSString stringWithFormat:@"&obj.file_name=%@",message.fileName]];
    [properties appendString:[NSString stringWithFormat:@"&obj.file_address=%@",message.fileAddress]];
    [properties appendString:[NSString stringWithFormat:@"&obj.file_small_address=%@",message.fileSmallAddress]];
    [properties appendString:[NSString stringWithFormat:@"&obj.file_time_length=%d",message.fileTimeLength]];
    [properties appendString:[NSString stringWithFormat:@"&obj.file_small_address=%@",message.fileSmallAddress]];
    [properties appendString:[NSString stringWithFormat:@"&obj.file_size=%d",message.fileSize]];
    [properties appendString:[NSString stringWithFormat:@"&obj.flag=%d",message.flag]];
    [properties appendString:[NSString stringWithFormat:@"&obj.status=%d",message.status]];
    [properties appendString:[NSString stringWithFormat:@"&obj.text_message=%@",message.textMessage]];
        return properties;
    
}
/*
- (void)onSocket:(AsyncSocket *)_sock didConnectToHost:(NSString *)host port:(UInt16)port{  
    //    [_sock readDataWithTimeout:-1 tag:0];  
}

- (void)onSocket:(AsyncSocket *)_sock didReadData:(NSData *)data withTag:(long)tag{
    
    if (tag==9786) {
        [readData appendData:data];
        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8);
        NSString* aStr = [[NSString alloc] initWithData:readData encoding:enc];
        NSRange textRange;
        textRange =[aStr rangeOfString:@"</root>"];
        
        if(textRange.length==7)
        {
            NSLog(@"%@",aStr);
            NSDictionary *chatInfo = [[listArray objectAtIndex:sendRow] retain];
            BubbleView *returnView=[chatInfo objectForKey:@"view"];
            [returnView.activityView stopAnimating];
            
            SendResult *sendResult=[pub isSendSuccess:aStr];
            
            if ([sendResult.resultCode isEqualToString:@"0001"]) {
                returnView.isSuccess=YES;
                returnView.state.hidden=YES;
            }else{
                returnView.isSuccess=NO;
                returnView.state.hidden=NO;
            }
            returnView.time.text=[self getDateWithString:sendResult.lastDate];
            
            if (chatData==nil) {
                chatData=[[ChatData alloc]init];
            }
            if ([chatInfo objectForKey:@"text"]) {
                BbsMemberNewMessage *_message=[chatInfo objectForKey:@"text"];
                _message.status=1;
                _message.createDate=sendResult.lastDate;
                [chatData updateMessageSendStatus:_message.identity status:1 date:sendResult.lastDate];
                
            }else if([chatInfo objectForKey:@"image"]){
                BbsMemberNewMessage *_message=[chatInfo objectForKey:@"image"];
                _message.status=1;
                _message.createDate=sendResult.lastDate;
                [chatData updateMessageSendStatus:_message.identity status:1 date:sendResult.lastDate];
                
            }else if([chatInfo objectForKey:@"voice"]){
                BbsMemberNewMessage *_message=[chatInfo objectForKey:@"voice"];
                _message.status=1;
                _message.createDate=sendResult.lastDate;
                [chatData updateMessageSendStatus:_message.identity status:1 date:sendResult.lastDate];
                
            }else if([chatInfo objectForKey:@"video"]){
                BbsMemberNewMessage *_message=[chatInfo objectForKey:@"video"];
                _message.status=1;
                _message.createDate=sendResult.lastDate;
                [chatData updateMessageSendStatus:_message.identity status:1 date:sendResult.lastDate];
            }else if([chatInfo objectForKey:@"position"]){
                BbsMemberNewMessage *_message=[chatInfo objectForKey:@"position"];
                _message.status=1;
                _message.createDate=sendResult.lastDate;
                [chatData updateMessageSendStatus:_message.identity status:1 date:sendResult.lastDate];
            }
            
            [self.listView reloadData];
            [chatInfo release];
            sendState=YES;
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshChatInfoList" object:nil];
            
        }
        
        [aStr release];
        
        [_sock readDataWithTimeout:-1 tag:9786];
    }
}

- (void)onSocket:(AsyncSocket *)_sock willDisconnectWithError:(NSError *)err  
{   
    NSLog(@"DisconnectError:%@",err);  
}

- (void)onSocketDidDisconnect:(AsyncSocket *)_sock  
{  
    NSLog(@"断开连接");  
    _sock = nil;
    if (!sendState) {
        NSDictionary *chatInfo = [listArray objectAtIndex:sendRow];
        BubbleView *returnView=[chatInfo objectForKey:@"view"];
        [returnView.activityView stopAnimating];
        
        returnView.state.hidden=NO;
        returnView.isSuccess=NO;
        
        if (chatData==nil) {
            chatData=[[ChatData alloc]init];
        }
        switch (sendType) {
            case 1:{
                BbsMemberNewMessage *_message=[chatInfo objectForKey:@"text"];
                _message.status=-1;
                returnView.time.text=[self getDateWithString:_message.createDate];
                [chatData updateMessageSendStatus:_message.identity status:-1];
                break;
            }
            case 2:{//语音
                BbsMemberNewMessage *_message=[chatInfo objectForKey:@"voice"];
                _message.status=-1;
                returnView.time.text=[self getDateWithString:_message.createDate];
                [chatData updateMessageSendStatus:_message.identity status:-1];
                break;
            }
            case 3:{
                BbsMemberNewMessage *_message=[chatInfo objectForKey:@"image"];
                _message.status=-1;
                returnView.time.text=[self getDateWithString:_message.createDate];
                [chatData updateMessageSendStatus:_message.identity status:-1];
                break;
            }
            case 4:{
                BbsMemberNewMessage *_message=[chatInfo objectForKey:@"video"];
                _message.status=-1;
                returnView.time.text=[self getDateWithString:_message.createDate];
                [chatData updateMessageSendStatus:_message.identity status:-1];
                break;
            }
            case 5:{
                BbsMemberNewMessage *_message=[chatInfo objectForKey:@"position"];
                _message.status=-1;
                returnView.time.text=[self getDateWithString:_message.createDate];
                [chatData updateMessageSendStatus:_message.identity status:-1];
                break;
            }
            default:
                break;
        }
        
        [self.listView reloadData];
        sendState=YES;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshChatInfoList" object:nil];
        
    }
}

-(void)connectServer:(NSString *)hostIP port:(int)hostPort{  
    
    sock = [[AsyncSocket alloc] initWithDelegate:self];
    
    NSError *err = nil;
    BOOL connect=[sock connectToHost:hostIP onPort:hostPort withTimeout:-1 error:&err];
    
    if (!connect) {  
        NSLog(@"连接失败！ %@ %@", [err code], [err localizedDescription]);  
        if (!sendState) {
            NSDictionary *chatInfo = [listArray objectAtIndex:sendRow];
            BubbleView *returnView=[chatInfo objectForKey:@"view"];
            [returnView.activityView stopAnimating];
            
            returnView.state.hidden=NO;
            returnView.isSuccess=NO;
            
            if (chatData==nil) {
                chatData=[[ChatData alloc]init];
            }
            switch (sendType) {
                case 1:{
                    BbsMemberNewMessage *_message=[chatInfo objectForKey:@"text"];
                    _message.status=-1;
                    returnView.time.text=[self getDateWithString:_message.createDate];
                    [chatData updateMessageSendStatus:_message.identity status:-1];
                    break;
                }
                case 2:{//语音
                    BbsMemberNewMessage *_message=[chatInfo objectForKey:@"voice"];
                    _message.status=-1;
                    returnView.time.text=[self getDateWithString:_message.createDate];
                    [chatData updateMessageSendStatus:_message.identity status:-1];
                    break;
                }
                case 3:{
                    BbsMemberNewMessage *_message=[chatInfo objectForKey:@"image"];
                    _message.status=-1;
                    returnView.time.text=[self getDateWithString:_message.createDate];
                    [chatData updateMessageSendStatus:_message.identity status:-1];
                    break;
                }
                case 4:{
                    BbsMemberNewMessage *_message=[chatInfo objectForKey:@"video"];
                    _message.status=-1;
                    returnView.time.text=[self getDateWithString:_message.createDate];
                    [chatData updateMessageSendStatus:_message.identity status:-1];
                    break;
                }
                case 5:{
                    BbsMemberNewMessage *_message=[chatInfo objectForKey:@"position"];
                    _message.status=-1;
                    returnView.time.text=[self getDateWithString:_message.createDate];
                    [chatData updateMessageSendStatus:_message.identity status:-1];
                    break;
                }
                default:
                    break;
            }
            [self.listView reloadData];
            sendState=YES;
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshChatInfoList" object:nil];
            
        }
    } else {  
        NSLog(@"连接成功！");  
    }  
    
}
*/
-(BOOL)connectedToNetWork
{
	struct sockaddr_in zeroAddress;
	bzero(&zeroAddress, sizeof(zeroAddress));
	zeroAddress.sin_len = sizeof(zeroAddress);
	zeroAddress.sin_family = AF_INET;
	
	SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
	SCNetworkReachabilityFlags flags;
	
	BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
	CFRelease(defaultRouteReachability);
	
	if (!didRetrieveFlags) {
		return NO;
	}
	
	BOOL isReachable = flags & kSCNetworkFlagsReachable;
	BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
	return (isReachable && !needsConnection) ? YES : NO;
}

-(NSString *)getDateWithString:(NSDate *)_date{
    //时间处理
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    
    df.dateFormat = @"MM月dd号 HH:mm";
    NSString *dateString=[df stringFromDate:_date];
    return dateString;
}

-(NSString *)uuid {  
    CFUUIDRef puuid = CFUUIDCreate( nil );  
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );  
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));  
    CFRelease(puuid);  
    CFRelease(uuidString);  
    return result;  
}

- (void)showToast:(NSString *)contents
{
    iToast *toast = [iToast makeToast:contents];
    [toast setToastPosition:kToastPositionBottom];
    [toast setToastDuration:kToastDurationNormal];
    [toast show];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {     return (interfaceOrientation ==  UIInterfaceOrientationLandscapeLeft || interfaceOrientation ==  UIInterfaceOrientationLandscapeRight );}-(NSUInteger)supportedInterfaceOrientations {    return UIInterfaceOrientationMaskLandscape;}- (BOOL)shouldAutorotate {    return YES;}
@end
