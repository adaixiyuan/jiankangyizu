#import "BbsMemberFriend.h"

@implementation BbsMemberFriend

@synthesize  identity ;
@synthesize memberId ;
@synthesize friendMemberId ;
@synthesize friendMemberAccountId,friendMemberName,friendMemberFace,friendMemberSex,friendMemberPhone,friendMemberContactName,friendMemberIntro,friendMemberAreaName,friendMemberAreaFullName,friendMemberProfessionName,isContact,joinDate,remark,totalCount,friendMemberMinShortName,score,prestige,isMingren;
@synthesize glamour;
@synthesize isSend;
@synthesize isReceive;
-(id)init{
    self=[super init];
    return self;
}

@end