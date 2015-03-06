#import "BbsMember.h"
@implementation BbsMemberDAO
+(Class)getBindingModelClass
{
    return [BbsMember class];
}
const static NSString* tablename = @"BbsMember";
+(const NSString *)getTableName
{
    return tablename;
}
@end
@implementation BbsMember

@synthesize  identity,username,email,phone,password,nickname,realName,shortName,minShortName,professionId,professionName,birthday,areaId,areaName,homeAreaId,homeAreaName,sex,workYearsId,workYearsName,intro,myPhotoOriginal,myPhotoMedium,myPhotoSmall,myPhotoRounded,cardId,companyId,companyName,schoolId,schoolName,militaryRankId,militaryRankName,dutyId,dutyName,qq,qqUid,sina,sinaUid,renren,renrenUid,score,prestige,contactIsShow,requestSetting,isReal,isAllowVisitContants,isAllowAddFaimiar,isPublic,isAuth,publicTypeId,publicTypeName,twoDimensionalCode,shotAcount,lastModifyDate,regDate,regIp,lastDeviceId,lastDeviceNo,lastLoginLongitude,lastLoginLatitude,lastLoginAddress,loginContinuedDayCount,loginCount,uuid,isMobile,isTemp,viewCount,likeCount,zatanCount,diaryCount,replyCount,picCount,friendCount,publicAccountCount,dynamicCount,friendRequestCount,messageCount,distance,totalCount,hash,isMingren,isFriend,styleId,styleImg,isTenVip,isZhuanjia,styleMobileImg,styleBackground,topicCount,answerCount,expertiseId,solveProCount,topicShareCount,solveMemberCount,expertiseMachineId,expertiseProductId,expertiseName,expertiseMachineName,expertiseProductName,machineId,industryId,workObjectId;
//@synthesize newPassword
@synthesize allDynimicCount;//TODO 全球动态消息数
@synthesize friendsDynimicCount;//TODO 好友圈消息数
@synthesize myDynimicCount;//TODO 我的消息数
@synthesize nearbyDynimicCount;//TODO 附近消息数
@synthesize pKMemberCount;//TODO PK人数
@synthesize sHMemberCount;//TODO 送花人数
@synthesize pKRankId;//排名id
@synthesize pKWinCount;//PK胜利次数
@synthesize pKLostCount;//PK失败次数
@synthesize glamour;
-(id)init{
    self=[super init];
    return self;
}
@end