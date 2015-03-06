#import "XMPPCapsResourceCoreDataStorageObject.h"
#import "XMPPCapsCoreDataStorageObject.h"

#if ! __has_feature(objc_arc)
#endif


@implementation XMPPCapsResourceCoreDataStorageObject 

@dynamic jidStr;
@dynamic streamBareJidStr;

@dynamic haveFailed;
@dynamic failed;

@dynamic node;
@dynamic ver;
@dynamic ext;

@dynamic hashStr;
@dynamic hashAlgorithm;

@dynamic caps;

- (BOOL)haveFailed
{
	return [[self failed] boolValue];
}

- (void)setHaveFailed:(BOOL)flag
{
	self.failed = [NSNumber numberWithBool:flag];
}

@end
