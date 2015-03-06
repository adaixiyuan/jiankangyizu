//
//  AppDelegate.h
//  yuehandier
//
//  Created by apple on 14/12/8.
//  Copyright (c) 2014年 jerei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "XMPPFramework.h"
#import "DDLog.h"
#import "DDTTYLogger.h"
#import "GCDAsyncSocket.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,XMPPRosterDelegate>
{
    __strong XMPPStream *xmppStream;
    __strong XMPPReconnect *xmppReconnect;
    __strong XMPPRoster *xmppRoster;
    __strong XMPPRosterCoreDataStorage *xmppRosterStorage;
    __strong XMPPvCardCoreDataStorage *xmppvCardStorage;
    __strong XMPPvCardTempModule *xmppvCardTempModule;
    __strong XMPPvCardAvatarModule *xmppvCardAvatarModule;
    __strong XMPPCapabilities *xmppCapabilities;
    __strong XMPPCapabilitiesCoreDataStorage *xmppCapabilitiesStorage;
    
    NSManagedObjectContext *managedObjectContext_roster;
    NSManagedObjectContext *managedObjectContext_capabilities;
    NSString *password;
    
    BOOL allowSelfSignedCertificates;
    BOOL allowSSLHostNameMismatch;
    
    BOOL isXmppConnected;
   
}
@property (nonatomic, retain) XMPPStream *xmppStream;
@property (nonatomic, readonly) XMPPReconnect *xmppReconnect;
@property (nonatomic, readonly) XMPPRoster *xmppRoster;
@property (nonatomic, readonly) XMPPRosterCoreDataStorage *xmppRosterStorage;
@property (nonatomic, readonly) XMPPvCardTempModule *xmppvCardTempModule;
@property (nonatomic, readonly) XMPPvCardAvatarModule *xmppvCardAvatarModule;
@property (nonatomic, readonly) XMPPCapabilities *xmppCapabilities;
@property (nonatomic, readonly) XMPPCapabilitiesCoreDataStorage *xmppCapabilitiesStorage;
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) NSString *token;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSManagedObjectContext *)managedObjectContext_roster;
- (NSManagedObjectContext *)managedObjectContext_capabilities;
- (BOOL)connect;
- (void)disconnect;
- (void)setupStream;
- (void)teardownStream;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

