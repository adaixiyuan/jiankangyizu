
#import <Foundation/Foundation.h>
@interface BbsMemberAttention : NSObject{
    int identity  ;
    int memberId;
    int attentionMemberId;
    NSString * nickname;
    int professionId;
    NSString * professionName;
    int companyId;
    NSString * companyName;
    NSString * realName;
    NSString * intro;
    NSString * userFace;
    int sex;
    int areaId;
    NSString * areaFullName;
    NSString * areaName;
    int homeAreaId;
    NSString * homeAreaName;
    NSString * phone;
    double lastLoginLongitude;
    double lastLoginLatitude;
    BOOL isPublic;
    BOOL isFriend;
    BOOL isContact;
    BOOL isSameArea;
    BOOL isSameHome;
    BOOL isSameProfession;
    BOOL isSameCompany;
    int totalCount;
    
}
@property(nonatomic,assign)int identity  ;
@property(nonatomic,assign)int memberId;
@property(nonatomic,assign)int attentionMemberId;
@property(nonatomic,strong)NSString * nickname;
@property(nonatomic,assign)int professionId;
@property(nonatomic,strong)NSString * professionName;
@property(nonatomic,assign)int companyId;
@property(nonatomic,strong)NSString * companyName;
@property(nonatomic,strong)NSString * realName;
@property(nonatomic,strong)NSString * intro;
@property(nonatomic,strong)NSString * userFace;
@property(nonatomic,assign)int sex;
@property(nonatomic,assign)int areaId;
@property(nonatomic,strong)NSString * areaFullName;
@property(nonatomic,strong)NSString * areaName;
@property(nonatomic,assign)int homeAreaId;
@property(nonatomic,strong)NSString * homeAreaName;
@property(nonatomic,strong)NSString * phone;
@property(nonatomic,assign)double lastLoginLongitude;
@property(nonatomic,assign)double lastLoginLatitude;
@property(nonatomic,assign)BOOL isPublic;
@property(nonatomic,assign)BOOL isFriend;
@property(nonatomic,assign)BOOL isContact;
@property(nonatomic,assign)BOOL isSameArea;
@property(nonatomic,assign)BOOL isSameHome;
@property(nonatomic,assign)BOOL isSameProfession;
@property(nonatomic,assign)BOOL isSameCompany;
@property(nonatomic,assign)int totalCount;


@end
