
#import "BbsChatInfo.h"
@implementation BbsChatInfoDAO
+(Class)getBindingModelClass
{
    return [BbsChatInfo class];
}
const static NSString* tablename = @"BbsChatInfo";
+(const NSString *)getTableName
{
    return tablename;
}
@end
@implementation BbsChatInfo
@synthesize chatId,sendUserId,sendUserName,sendUserFace,receiveUserId,receiveUserName,receiveUserFace,sendDate,receiveDate,infoCatalogText,messageTitle,messageContent,resourceFileAddress,resourceFileType,sendStatus,shareLat,shareLog,shareAddress,newMsgCount;

-(id)init{
    self=[super init];
    return self;
}




@end
