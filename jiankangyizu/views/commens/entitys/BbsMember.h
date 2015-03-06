
#import <Foundation/Foundation.h>
#import "ZUOYLDAOBase.h"
@interface BbsMemberDAO : ZUOYLDAOBase

@end
@interface BbsMember : ZUOYLModelBase{
    
    
    
    
    
    
    
    int  identity ;
    NSString *   username ;
    NSString *   email ;
    NSString *   phone ;
    NSString *   password ;
    NSString *   nickname ;
    NSString *   realName ;
    NSString *   shortName ;
    NSString *   minShortName ;
    int  professionId ;
    NSString * professionName ;
    NSString   *birthday ;
    int  areaId ;
    NSString * areaName ;
    int  homeAreaId ;
    NSString * homeAreaName ;
    int  sex ;
    int  workYearsId ;
    NSString * workYearsName ;
    NSString *   intro ;
    NSString *   myPhotoOriginal ;
    NSString *   myPhotoMedium ;
    NSString *   myPhotoSmall ;
    NSString *   myPhotoRounded ;
    NSString *   cardId ;
    int companyId;
    NSString * companyName;
    int schoolId;
    NSString * schoolName;
    int  militaryRankId ;
    NSString * militaryRankName ;
    int  dutyId ;
    NSString * dutyName ;
    NSString *   qq ;
    NSString *   qqUid ;
    NSString *   sina ;
    NSString *   sinaUid ;
    NSString *   renren ;
    NSString *   renrenUid ;
    int  score ;
    int  prestige ;
    int  contactIsShow ;
    int  requestSetting ;
    int  isAllowVisitContants ;
    int  isAllowAddFaimiar ;
    BOOL  isPublic;
    BOOL  isAuth ;
    BOOL isReal;
    BOOL isMingren;//
    BOOL isZhuanjia;
    BOOL isTenVip;
    int  publicTypeId ;
    NSString * publicTypeName ;
    NSString *   twoDimensionalCode ;
    NSString *   shotAcount ;
    NSString   *lastModifyDate ;
    NSString   *regDate ;
    NSString *   regIp ;
    int lastDeviceId;
    NSString * lastDeviceNo;
    double    lastLoginLongitude ;
    double    lastLoginLatitude ;
    NSString *   lastLoginAddress ;
    int  loginContinuedDayCount ;
    int  loginCount ;
    NSString *   uuid ;
    BOOL isMobile;
    BOOL   isTemp ;
    int viewCount;
    int likeCount;
    int zatanCount;
    int diaryCount;
    int replyCount;
    int picCount;
    int friendCount;
    int publicAccountCount;
    int dynamicCount;
    int friendRequestCount;
    int messageCount;
    double distance;
    int totalCount;
    BOOL isFriend;//
    NSString * hash;
    int solveProCount;//TODO 解决问题数
    int solveMemberCount;//TODO 帮助人数
    int topicCount;//TODO 提问数
    int topicShareCount;//TODO 回答数
    int answerCount;//TODO 回答数
    int expertiseId;//TODO 精通领域
    int expertiseMachineId;//TODO 精通设备
    int expertiseProductId;//TODO 精通产品
    NSString * expertiseName;//TODO 精通领域
    NSString * expertiseMachineName;//TODO 精通设备
    NSString * expertiseProductName;//TODO 精通产品
    int styleId;//
    NSString *styleImg;//
    NSString *styleBackground;
    NSString *styleMobileImg;
    int glamour;
     int allDynimicCount;//TODO 全球动态消息数
     int friendsDynimicCount;//TODO 好友圈消息数
     int myDynimicCount;//TODO 我的消息数
     int nearbyDynimicCount;//TODO 附近消息数
     int pKMemberCount;//TODO PK人数
     int sHMemberCount;//TODO 送花人数
     int pKRankId;//排名id
     int pKWinCount;//PK胜利次数
     int pKLostCount;//PK失败次数
    
}
@property(nonatomic,strong)NSString * expertiseName;//TODO 精通领域
@property(nonatomic,strong)NSString * expertiseMachineName;//TODO 精通设备
@property(nonatomic,strong)NSString * expertiseProductName;//TODO 精通产品
@property(nonatomic,assign)int solveProCount;//TODO 解决问题数
@property(nonatomic,assign)int solveMemberCount;//TODO 帮助人数
@property(nonatomic,assign)int topicCount;//TODO 提问数
@property(nonatomic,assign)int topicShareCount;//TODO 回答数
@property(nonatomic,assign)int answerCount;//TODO 回答数
@property(nonatomic,assign)int expertiseId;//TODO 精通领域
@property(nonatomic,assign)int expertiseMachineId;//TODO 精通设备
@property(nonatomic,assign)int expertiseProductId;//TODO 精通产品
@property(nonatomic,strong)NSString *styleBackground;
@property(nonatomic,strong)NSString *styleMobileImg;
@property(nonatomic,assign)BOOL isZhuanjia;
@property(nonatomic,assign)BOOL isTenVip;
@property(nonatomic,assign)BOOL isMingren;
@property(nonatomic,assign)BOOL isFriend;
@property(nonatomic,assign)int styleId;
@property(nonatomic,strong)NSString *styleImg;
@property(nonatomic,assign)int  identity ;
@property(nonatomic,strong)NSString *   username ;
@property(nonatomic,strong)NSString *   email ;
@property(nonatomic,strong)NSString *   phone ;
@property(nonatomic,strong)NSString *   password ;

@property(nonatomic,strong)NSString *nickname ;
@property(nonatomic,strong)NSString *   realName ;
@property(nonatomic,strong)NSString *   shortName ;
@property(nonatomic,strong)NSString *   minShortName ;
@property(nonatomic,assign)int  professionId ;
@property(nonatomic,strong)NSString * professionName ;
@property(nonatomic,strong)NSString   *birthday ;
@property(nonatomic,assign)int  areaId ;
@property(nonatomic,strong)NSString * areaName ;
@property(nonatomic,assign)int  homeAreaId ;
@property(nonatomic,strong)NSString * homeAreaName ;
@property(nonatomic,assign)int  sex ;
@property(nonatomic,assign)int  workYearsId ;
@property(nonatomic,strong)NSString * workYearsName ;
@property(nonatomic,strong)NSString *   intro ;
@property(nonatomic,strong)NSString *   myPhotoOriginal ;
@property(nonatomic,strong)NSString *   myPhotoMedium ;
@property(nonatomic,strong)NSString *   myPhotoSmall ;
@property(nonatomic,strong)NSString *   myPhotoRounded ;
@property(nonatomic,strong)NSString *   cardId ;
@property(nonatomic,assign)int companyId;
@property(nonatomic,strong)NSString * companyName;
@property(nonatomic,assign)int schoolId;
@property(nonatomic,strong)NSString * schoolName;
@property(nonatomic,assign)int  militaryRankId ;
@property(nonatomic,strong)NSString * militaryRankName ;
@property(nonatomic,assign)int  dutyId ;
@property(nonatomic,strong)NSString * dutyName ;
@property(nonatomic,strong)NSString *   qq ;
@property(nonatomic,strong)NSString *   qqUid ;
@property(nonatomic,strong)NSString *   sina ;
@property(nonatomic,strong)NSString *   sinaUid ;
@property(nonatomic,strong)NSString *   renren ;
@property(nonatomic,strong)NSString *   renrenUid ;
@property(nonatomic,assign)int  score ;
@property(nonatomic,assign)int  prestige ;
@property(nonatomic,assign)int  contactIsShow ;
@property(nonatomic,assign)int  requestSetting ;
@property(nonatomic,assign)BOOL  isReal ;
@property(nonatomic,assign)int  isAllowVisitContants ;
@property(nonatomic,assign)int  isAllowAddFaimiar ;
@property(nonatomic,assign)BOOL  isPublic;
@property(nonatomic,assign)BOOL  isAuth ;
@property(nonatomic,assign)int  publicTypeId ;
@property(nonatomic,strong)NSString * publicTypeName ;
@property(nonatomic,strong)NSString *   twoDimensionalCode ;
@property(nonatomic,strong)NSString *   shotAcount ;
@property(nonatomic,strong)NSString   *lastModifyDate ;
@property(nonatomic,strong)NSString   *regDate ;
@property(nonatomic,strong)NSString *   regIp ;
@property(nonatomic,assign)int lastDeviceId;
@property(nonatomic,strong)NSString * lastDeviceNo;
@property(nonatomic,assign)double    lastLoginLongitude ;
@property(nonatomic,assign)double    lastLoginLatitude ;
@property(nonatomic,strong)NSString *   lastLoginAddress ;
@property(nonatomic,assign)int  loginContinuedDayCount ;
@property(nonatomic,assign)int  loginCount ;
@property(nonatomic,strong)NSString *   uuid ;
@property(nonatomic,assign)BOOL isMobile;
@property(nonatomic,assign)BOOL   isTemp ;
@property(nonatomic,assign)int viewCount;
@property(nonatomic,assign)int likeCount;
@property(nonatomic,assign)int zatanCount;
@property(nonatomic,assign)int diaryCount;
@property(nonatomic,assign)int replyCount;
@property(nonatomic,assign)int picCount;
@property(nonatomic,assign)int friendCount;
@property(nonatomic,assign)int publicAccountCount;
@property(nonatomic,assign)int dynamicCount;
@property(nonatomic,assign)int friendRequestCount;
@property(nonatomic,assign)int messageCount;
@property(nonatomic,assign)double distance;
@property(nonatomic,assign)int totalCount;
@property(nonatomic,strong)NSString * hash;
@property(nonatomic,assign)int glamour;
@property(nonatomic,assign)int machineId;
@property(nonatomic,assign)int industryId;
@property(nonatomic,assign)int workObjectId;

@property(nonatomic,assign)int allDynimicCount;//TODO 全球动态消息数
@property(nonatomic,assign)int friendsDynimicCount;//TODO 好友圈消息数
@property(nonatomic,assign)int myDynimicCount;//TODO 我的消息数
@property(nonatomic,assign)int nearbyDynimicCount;//TODO 附近消息数
@property(nonatomic,assign)int pKMemberCount;//TODO PK人数
@property(nonatomic,assign)int sHMemberCount;//TODO 送花人数
@property(nonatomic,assign)int pKRankId;//排名id
@property(nonatomic,assign)int pKWinCount;//PK胜利次数
@property(nonatomic,assign)int pKLostCount;//PK失败次数
@end
