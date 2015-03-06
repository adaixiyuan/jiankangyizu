
#import <Foundation/Foundation.h>
@interface BbsMemberFriend : NSObject{
    int identity  ;
    int memberId ;		   
    int friendMemberId ;	
    NSString *friendMemberAccountId;
    NSString *friendMemberName;
    NSString *friendMemberMinShortName;
    NSString *friendMemberFace;
    int friendMemberSex;
    NSString *friendMemberPhone;
    NSString *friendMemberContactName;
    NSString *friendMemberIntro;
    NSString *friendMemberAreaName;
    NSString *friendMemberAreaFullName;
    NSString *friendMemberProfessionName;
    BOOL isContact;
    NSDate *joinDate;
    NSString *remark;
    int totalCount;
    
    int score;
    int prestige;
    BOOL isMingren;
    
    int glamour;//魅力值
    BOOL isSend;//是否已经送过花
    BOOL isReceive;//是否给我送过花
}
@property(nonatomic,assign)int identity  ;
@property(nonatomic,assign)int memberId ;		   
@property(nonatomic,assign)int friendMemberId ;	
@property(nonatomic,strong)NSString *friendMemberAccountId;
@property(nonatomic,strong)NSString *friendMemberName;
@property(nonatomic,strong)NSString *friendMemberMinShortName;
@property(nonatomic,strong)NSString *friendMemberFace;
@property(nonatomic,assign)int friendMemberSex;
@property(nonatomic,strong)NSString *friendMemberPhone;
@property(nonatomic,strong)NSString *friendMemberContactName;
@property(nonatomic,strong)NSString *friendMemberIntro;
@property(nonatomic,strong)NSString *friendMemberAreaName;
@property(nonatomic,strong)NSString *friendMemberAreaFullName;
@property(nonatomic,strong)NSString *friendMemberProfessionName;
@property(nonatomic,assign)BOOL isContact;
@property(nonatomic,strong)NSDate *joinDate;
@property(nonatomic,strong)NSString *remark;
@property(nonatomic,assign)int totalCount;
@property(nonatomic,assign)int score;
@property(nonatomic,assign)int prestige;
@property(nonatomic,assign)BOOL isMingren;

@property(nonatomic,assign)int glamour;//魅力值
@property(nonatomic,assign)BOOL isSend;
@property(nonatomic,assign)BOOL isReceive;

@end
