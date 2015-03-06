

#import "KnowledgeCell.h"

@implementation KnowledgeCell
@synthesize  newsTitleImg;
@synthesize  keshiName;
@synthesize  summary;
@synthesize  detail;
@synthesize  newsDate;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    }
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        newsTitleImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 70, 70)];
        keshiName = [[UIButton alloc] initWithFrame:CGRectMake(80, 10, 100, 20)];
        [keshiName setTitleColor:YINGYONG_COLOR forState:UIControlStateNormal];
        summary = [[UILabel alloc] initWithFrame:CGRectMake(185,10, kDeviceWidth-185, 20)];
        detail = [[UILabel alloc] initWithFrame:CGRectMake(80,40, kDeviceWidth-80, 20)];
        newsDate = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/2+44, 70,kDeviceWidth/3, 20)];
        
        [self.contentView addSubview:newsTitleImg];
        [self.contentView addSubview:keshiName];
        [self.contentView addSubview:summary];
        [self.contentView addSubview:detail];
        [self.contentView addSubview:newsDate];
    }
    return self;
}

@end
