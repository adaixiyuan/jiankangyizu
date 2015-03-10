//
//  AppDelegate.m
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "AppDelegate.h"
#import "dengLuView.h"
#import "RDVTabBarController.h"
#import "UserManage.h"
#import "ziXunView.h"
#import "FirstView.h"
#import "zhiShiKuList.h"
#import "mySelfView.h"
#import "RDVTabBar.h"
#import "RDVTabBarItem.h"

#import "DDXML.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize token;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
       if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings
                                                                             settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)
                                                                             categories:nil]];
        
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        //这里还是原来的代码
        [[UIApplication sharedApplication]registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert |UIRemoteNotificationTypeBadge |UIRemoteNotificationTypeSound)];
    }
//    [self setupStream];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    NSData *userData=[[NSUserDefaults standardUserDefaults]objectForKey:@"user"];
    CommonUser *user= [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    if (user!=nil)
    {
      
//        [self connectPushServerWithUserName:user.usern];
        
        UIViewController *firstViewController = [[UserManage alloc] init];
        UIViewController *firstNavigationController = [[UINavigationController alloc]
                                                       initWithRootViewController:firstViewController];
        
        UIViewController *secondViewController = [[ziXunView alloc] init];
        UIViewController *secondNavigationController = [[UINavigationController alloc]
                                                        initWithRootViewController:secondViewController];
        
        UIViewController *thirdViewController = [[FirstView alloc] init];
        UIViewController *thirdNavigationController = [[UINavigationController alloc]
                                                       initWithRootViewController:thirdViewController];
        UIViewController *forthViewController = [[zhiShiKuList alloc] init];
        UIViewController *forthNavigationController = [[UINavigationController alloc]
                                                       initWithRootViewController:forthViewController];
        UIViewController *fifthViewController = [[mySelfView alloc] init];
        UIViewController *fifthNavigationController = [[UINavigationController alloc]
                                                       initWithRootViewController:fifthViewController];
       
        RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
        [tabBarController setViewControllers:@[firstNavigationController, secondNavigationController,
                                               thirdNavigationController,forthNavigationController,fifthNavigationController]];
        
        
        tabBarController.selectedIndex = 2;
        [self customizeTabBarForController:tabBarController];
        self.window.rootViewController = tabBarController;
        [self.window makeKeyAndVisible];
        
        
        NSString *urlString = [NSString stringWithFormat:@"%@%@?user_id=%d",BASE_URL,MESSAGECOUNT_URL,user.identity];
        
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
                        NSMutableDictionary *dir = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                        NSString *string=[dir objectForKey:@"resultObject"];
                        if([string intValue] > 0)
                        {
                        RDVTabBarItem  *meitem = [[tabBarController tabBar] items][4];
                        [meitem setBadgeBackgroundColor:[UIColor redColor]];
                        [meitem setBadgeValue:string];
                        }
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
//        UILocalNotification *localNote = [[UILocalNotification alloc] init];
//        localNote.alertAction = @"操作标题";
//        localNote.alertBody = @"伦家想你了～～～";
//        localNote.applicationIconBadgeNumber  = 1;
//        localNote.alertLaunchImage = @"icon.png";
//        localNote.fireDate =[NSDate dateWithTimeIntervalSinceNow:10] ;
//        UIApplication *app = [UIApplication sharedApplication];
//        [app cancelAllLocalNotifications];
//        [app scheduleLocalNotification:localNote];

    }
    
    else
    {
        dengLuView *centerController = [[dengLuView alloc] initWithNibName:nil bundle:nil];
        //    UINavigationController *firstNav = [[UINavigationController alloc]initWithRootViewController:centerController];
        
        self.window.rootViewController = centerController;
        [self.window makeKeyAndVisible];

    }
    
        NSSetUncaughtExceptionHandler(& caughtException);
   
//    [self presentViewController:tabBarController animated:YES completion:nil];
    //    [self.navigationController pushViewController:tabBarController animated:YES];

    return YES;
}
- (void)connectPushServerWithUserName:(NSString *)username
{
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@"tiebi123" forKey:@"userPassword"];
    NSLog(@"password : %@",[userDefaults objectForKey:@"userPassword"]);
    NSLog(@"userName = %@",username);
    //断开聊天
    if ([APPALL connect]){
        [APPALL disconnect];
        
        [userDefaults removeObjectForKey:@"kXMPPmyJID"];
        [userDefaults removeObjectForKey:@"kXMPPmyPassword"];
    }
    [userDefaults setObject:[NSString stringWithFormat:@"%@_%@",PROJECTSID,username] forKey:@"kXMPPmyJID"];
    NSLog(@"jid:%@",[userDefaults objectForKey:@"kXMPPmyJID"]);
    NSString *userPass=[userDefaults objectForKey:@"userPassword"];
    [userDefaults setObject:userPass forKey:@"kXMPPmyPassword"];
    NSLog(@"kxmppmypassword%@",[userDefaults objectForKey:@"kXMPPmyPassword"]);
    [APPALL connect];
}
- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    //    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    //    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *tabBarItemImages = @[@"second", @"third", @"first",@"forth",@"fifth"];
    NSArray *tabBarItemTitles = @[@"用户",@"咨询",@"首页",@"知识库",@"我"];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        
        //        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        [item setTitle:[tabBarItemTitles objectAtIndex:index]];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        index++;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}
void caughtException(NSException *exception)
{
    NSLog(@"CRASH:%@",exception);
    NSLog(@"Stack Trace:%@",[exception callStackSymbols]);
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "jerei.jiankangyizu" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"jiankangyizu" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"jiankangyizu.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:notification.alertBody message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSString *str = [NSString stringWithFormat:@"Device" ];
    //    token = [NSString stringWithFormat:@"%@",deviceToken];
    self.token =(NSMutableString *)[[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    self.token= (NSMutableString *) [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    
    NSLog(@"%@",token);
    //    [self createUser];
    NSLog(@"------%@",deviceToken);
}
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
//    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    NSLog(@"didReceiveRemoteNotification    %@",userInfo);
}
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    
}
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
//    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    NSLog(@"didReceiveRemoteNotification -----%@",userInfo);
    NSDictionary *dictionary = [userInfo objectForKey:@"aps"];
    NSString *messageName = [dictionary objectForKey:@"alert"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshDingDan" object:nil];
    //    WcmCmsMemberMessage *message = [[WcmCmsMemberMessage alloc]init];
    //    message.textMessage = messageName;
    //    if (message!=nil) {
    //        FMDatabaseQueue *queue = [[FMDatabaseQueue alloc]initWithPath:[ZUOYLTempHelper getPathForDocuments:@"asiastarbus.db" inDir:@"db"]];
    //        WcmCmsMemberMessageDAO* dao = [[WcmCmsMemberMessageDAO alloc]initWithDbqueue:queue];
    //
    //        message.identity=0;
    //        [dao insertToDB:message callback:^(BOOL block){
    //
    //        }];
    //        //            [dao replaceArrayToDB:array callback:^(BOOL block){
    //        //
    //        //            }];
    //    }
    //    message.addDate = [NSDate date];
    
}

- (void)teardownStream
{
    [xmppStream removeDelegate:self];
    [xmppRoster removeDelegate:self];
    
    [xmppReconnect         deactivate];
    [xmppRoster            deactivate];
    [xmppvCardTempModule   deactivate];
    [xmppvCardAvatarModule deactivate];
    [xmppCapabilities      deactivate];
    
    [xmppStream disconnect];
    
    xmppStream = nil;
    xmppReconnect = nil;
    xmppRoster = nil;
    xmppRosterStorage = nil;
    xmppvCardStorage = nil;
    xmppvCardTempModule = nil;
    xmppvCardAvatarModule = nil;
    xmppCapabilities = nil;
    xmppCapabilitiesStorage = nil;
}
- (void)setupStream
{
    NSAssert(xmppStream == nil, @"Method setupStream invoked multiple times");
    
    
    xmppStream = [[XMPPStream alloc] init];
    
#if !TARGET_IPHONE_SIMULATOR
    {
        
        xmppStream.enableBackgroundingOnSocket = YES;
    }
#endif
    
    xmppReconnect = [[XMPPReconnect alloc] init];
    
    
    xmppRosterStorage = [[XMPPRosterCoreDataStorage alloc] init];
    //	xmppRosterStorage = [[XMPPRosterCoreDataStorage alloc] initWithInMemoryStore];
    
    xmppRoster = [[XMPPRoster alloc] initWithRosterStorage:xmppRosterStorage];
    
    xmppRoster.autoFetchRoster = YES;
    xmppRoster.autoAcceptKnownPresenceSubscriptionRequests = YES;
    
    xmppCapabilitiesStorage = [XMPPCapabilitiesCoreDataStorage sharedInstance];
    //    xmppCapabilities = [[XMPPCapabilities alloc] initWithCapabilitiesStorage:xmppCapabilitiesStorage];
    
    xmppCapabilities.autoFetchHashedCapabilities = YES;
    xmppCapabilities.autoFetchNonHashedCapabilities = NO;
    
    // Activate xmpp modules
    
    [xmppReconnect         activate:xmppStream];
    [xmppRoster            activate:xmppStream];
    [xmppvCardTempModule   activate:xmppStream];
    [xmppvCardAvatarModule activate:xmppStream];
    [xmppCapabilities      activate:xmppStream];
    
    // Add ourself as a delegate to anything we may be interested in
    
    [xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
    [xmppRoster addDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    
    //填写服务器信息
    [xmppStream setHostName:XMPP_HOSTIP];
    [xmppStream setHostPort:XMPP_HOSTPORT];
    
    
    // You may need to alter these settings depending on the server you're connecting to
    allowSelfSignedCertificates = NO;
    allowSSLHostNameMismatch = NO;
}
- (void)goOnline
{
    XMPPPresence *presence = [XMPPPresence presence]; // type="available" is implicit
    
    [[self xmppStream] sendElement:presence];
}

- (void)goOffline
{
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"unavailable"];
    
    [[self xmppStream] sendElement:presence];
}

#pragma mark Connect/disconnect

- (BOOL)connect
{
    if (![xmppStream isDisconnected]) {
        return YES;
    }
    
    NSString *myJID = [[NSUserDefaults standardUserDefaults] stringForKey:@"kXMPPmyJID"];
    NSString *myPassword = [[NSUserDefaults standardUserDefaults] stringForKey:@"kXMPPmyPassword"];
    NSLog(@"%@",myPassword);
    if (myJID == nil || myPassword == nil) {
        return NO;
    }
    
    [xmppStream setMyJID:[XMPPJID jidWithString:myJID]];
    password = myPassword;
    NSLog(@"%@",password);
    NSError *error = nil;
    if (![xmppStream connect:&error])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error connecting"
                                                            message:@"See console for error details."
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
        
        NSLog(@"Error connecting: %@", error);
        
        return NO;
    }
    
    return YES;
}

- (void)disconnect
{
    [self goOffline];
    [xmppStream disconnect];
    
}

- (NSManagedObjectContext *)managedObjectContext_roster
{
    NSAssert([NSThread isMainThread],
             @"NSManagedObjectContext is not thread safe. It must always be used on the same thread/queue");
    
    if (managedObjectContext_roster == nil)
    {
        managedObjectContext_roster = [[NSManagedObjectContext alloc] init];
        
        NSPersistentStoreCoordinator *psc = [xmppRosterStorage persistentStoreCoordinator];
        [managedObjectContext_roster setPersistentStoreCoordinator:psc];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(contextDidSave:)
                                                     name:NSManagedObjectContextDidSaveNotification
                                                   object:nil];
    }
    
    return managedObjectContext_roster;
}

- (NSManagedObjectContext *)managedObjectContext_capabilities
{
    NSAssert([NSThread isMainThread],
             @"NSManagedObjectContext is not thread safe. It must always be used on the same thread/queue");
    
    if (managedObjectContext_capabilities == nil)
    {
        managedObjectContext_capabilities = [[NSManagedObjectContext alloc] init];
        
        NSPersistentStoreCoordinator *psc = [xmppCapabilitiesStorage persistentStoreCoordinator];
        [managedObjectContext_roster setPersistentStoreCoordinator:psc];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(contextDidSave:)
                                                     name:NSManagedObjectContextDidSaveNotification
                                                   object:nil];
    }
    
    return managedObjectContext_capabilities;
}

- (void)contextDidSave:(NSNotification *)notification
{
    NSManagedObjectContext *sender = (NSManagedObjectContext *)[notification object];
    
    if (sender != managedObjectContext_roster &&
        [sender persistentStoreCoordinator] == [managedObjectContext_roster persistentStoreCoordinator])
    {
        NSLog(@"%@: %@ - Merging changes into managedObjectContext_roster", THIS_FILE, THIS_METHOD);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [managedObjectContext_roster mergeChangesFromContextDidSaveNotification:notification];
        });
    }
    
    if (sender != managedObjectContext_capabilities &&
        [sender persistentStoreCoordinator] == [managedObjectContext_capabilities persistentStoreCoordinator])
    {
        NSLog(@"%@: %@ - Merging changes into managedObjectContext_capabilities", THIS_FILE, THIS_METHOD);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [managedObjectContext_capabilities mergeChangesFromContextDidSaveNotification:notification];
        });
    }
}


#pragma mark XMPPStream Delegate
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)xmppStream:(XMPPStream *)sender socketDidConnect:(GCDAsyncSocket *)socket
{
    NSLog(@"%@: %@", THIS_FILE, THIS_METHOD);
}

- (void)xmppStream:(XMPPStream *)sender willSecureWithSettings:(NSMutableDictionary *)settings
{
    NSLog(@"%@: %@", THIS_FILE, THIS_METHOD);
    
    if (allowSelfSignedCertificates)
    {
        [settings setObject:[NSNumber numberWithBool:YES] forKey:(NSString *)kCFStreamSSLAllowsAnyRoot];
    }
    if (allowSSLHostNameMismatch)
    {
        [settings setObject:[NSNull null] forKey:(NSString *)kCFStreamSSLPeerName];
    }
    else
    {
        
        NSString *expectedCertName = nil;
        
        NSString *serverDomain = xmppStream.hostName;
        NSString *virtualDomain = [xmppStream.myJID domain];
        
        if ([serverDomain isEqualToString:XMPP_HOSTIP])
        {
            if ([virtualDomain isEqualToString:XMPP_SERVERIP])
            {
                expectedCertName = virtualDomain;
            }
            else
            {
                expectedCertName = serverDomain;
            }
        }
        else if (serverDomain == nil)
        {
            expectedCertName = virtualDomain;
        }
        else
        {
            expectedCertName = serverDomain;
        }
        
        if (expectedCertName)
        {
            [settings setObject:expectedCertName forKey:(NSString *)kCFStreamSSLPeerName];
        }
    }
}

- (void)xmppStreamDidSecure:(XMPPStream *)sender
{
    NSLog(@"%@: %@", THIS_FILE, THIS_METHOD);
}


//stream开始连接服务器
- (void)xmppStreamDidConnect:(XMPPStream *)sender
{
    NSLog(@"%@: %@", THIS_FILE, THIS_METHOD);
    
    isXmppConnected = YES;
    
    NSError *error = nil;
    
    if (![[self xmppStream] registerWithPassword:password error:&error]) {
        NSLog(@"Error authenticating: %@", error);
    }
    
    //	if (![[self xmppStream] authenticateWithPassword:password error:&error])
    //	{
    //		NSLog(@"Error authenticating: %@", error);
    //	}
}


//验证成功
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
    NSLog(@"%@: %@", THIS_FILE, THIS_METHOD);
    
    [self goOnline];
}


//验证失败
- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(NSXMLElement *)error
{
    NSLog(@"%@: %@", THIS_FILE, THIS_METHOD);
}

//收到消息
//http://192.168.1.55:9909/notification.do
- (BOOL)xmppStream:(XMPPStream *)sender didReceiveIQ:(XMPPIQ *)iq
{
    NSLog(@"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%@",iq);
    NSLog(@"%@: %@ - %@", THIS_FILE, THIS_METHOD, [iq elementID]);
    NSString *stringIq=[NSString stringWithFormat:@"%@",iq];
    [stringIq stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    [stringIq stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    
    [self getMessage1:[NSString stringWithFormat:@"%@",stringIq]];
    return NO;
}

//收到消息
- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message
{
    //	NSLog(@"%@: %@", THIS_FILE, THIS_METHOD);
    
    // A simple example of inbound message handling.
    
    if ([message isChatMessageWithBody])
    {
        //        [self getMessage1:[NSString stringWithFormat:@"%@",message]];
        
        XMPPUserCoreDataStorageObject *user = [xmppRosterStorage userForJID:[message from]
                                                                 xmppStream:xmppStream
                                                       managedObjectContext:[self managedObjectContext_roster]];
        NSString *body = [[message elementForName:@"body"] stringValue];
        NSString *displayName = [user displayName];
        
        if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive)
        {
            NSDictionary *msg = [NSDictionary dictionaryWithObjectsAndKeys:message,@"message", nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"getMessage" object:nil userInfo:msg];
        }
        else
        {
            // We are not active, so use a local notification instead
            UILocalNotification *localNotification = [[UILocalNotification alloc] init];
            localNotification.alertAction = @"Ok";
            localNotification.alertBody = [NSString stringWithFormat:@"From: %@\n\n%@",displayName,body];
            
            [[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];
        }
    }
}
-(void)getMessage1:(NSString *)_string{
//    NSLog(@"00000000000d0000000%@",_string);
//    
//    GetMessageTool *getMessageTool=[[GetMessageTool alloc]init];
//    
//    WcmCmsMemberMessage *chatMessage=[getMessageTool getMessage:_string];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshChatMessage" object:chatMessage];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshChatInfoList" object:nil];
    /*
     if (chatMessage) {
     
     
     switch (chatMessage.messageTypeId) {
     case 1:{//文字
     
     break;
     }
     case 2:{//语音
     NSData *voiceData=[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",chatMessage.fileAddress]]];
     
     NSString *voicePath=[NSString stringWithFormat:@"%@/Documents/ChatFiles/%@",NSHomeDirectory(),chatMessage.fileAddress];
     [[NSFileManager defaultManager]createFileAtPath:voicePath contents:voiceData attributes:nil];
     
     break;
     }
     case 3:{//图片
     
     NSData *imageData=[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",chatMessage.fileAddress]]];
     
     //                NSData *imageData=[ChangeData string2Data:chatMessage.resourceFileIOS];
     //
     NSString *imagePath=[NSString stringWithFormat:@"%@/Documents/ChatFiles/%@",NSHomeDirectory(),chatMessage.fileAddress];
     [[NSFileManager defaultManager]createFileAtPath:imagePath contents:imageData attributes:nil];
     
     break;
     }
     case 4:{//视频
     
     NSData *imageData=[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_IP,chatMessage.fileAddress]]];
     
     //                NSData *imageData=[ChangeData string2Data:chatMessage.resourceFileIOS];
     //
     //                NSData *imageData2=[ChangeData string2Data:chatMessage.resourceFile];
     
     NSString *imagePath=[NSString stringWithFormat:@"%@/Documents/ChatFiles/%@",NSHomeDirectory(),chatMessage.fileAddress];
     
     //                NSString *imagePath2=[NSString stringWithFormat:@"%@/Documents/ChatFiles/%@",NSHomeDirectory(),chatMessage.fileAddress];
     
     [[NSFileManager defaultManager]createFileAtPath:imagePath contents:imageData attributes:nil];
     
     //                [[NSFileManager defaultManager]createFileAtPath:imagePath2 contents:imageData2 attributes:nil];
     
     break;
     }
     default:
     break;
     }
     
     
     [chatMessage save];
     
     [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshChatMessage" object:chatMessage];
     [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshChatInfoList" object:nil];
     
     //系统声音
     AudioServicesPlaySystemSound(1007);
     //震动
     //AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
     }*/
    
}

//接受到好友状态更新
- (void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence
{
    NSLog(@"%@: %@ - %@", THIS_FILE, THIS_METHOD, [presence fromStr]);
}

- (void)xmppStream:(XMPPStream *)sender didReceiveError:(id)error
{
    NSLog(@"%@: %@", THIS_FILE, THIS_METHOD);
}

//stream连接断开的时候调用
- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error
{
    NSLog(@"%@: %@", THIS_FILE, THIS_METHOD);
    
    if (!isXmppConnected)
    {
        NSLog(@"Unable to connect to server. Check xmppStream.hostName");
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark XMPPRosterDelegate
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)xmppRoster:(XMPPRoster *)sender didReceiveBuddyRequest:(XMPPPresence *)presence
{
    NSLog(@"%@: %@", THIS_FILE, THIS_METHOD);
    
    XMPPUserCoreDataStorageObject *user = [xmppRosterStorage userForJID:[presence from]
                                                             xmppStream:xmppStream
                                                   managedObjectContext:[self managedObjectContext_roster]];
    
    NSString *displayName = [user displayName];
    NSString *jidStrBare = [presence fromStr];
    NSString *body = nil;
    
    if (![displayName isEqualToString:jidStrBare])
    {
        body = [NSString stringWithFormat:@"Buddy request from %@ <%@>", displayName, jidStrBare];
    }
    else
    {
        body = [NSString stringWithFormat:@"Buddy request from %@", displayName];
    }
    
    
    if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:displayName
                                                            message:body
                                                           delegate:nil
                                                  cancelButtonTitle:@"Not implemented"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
    else
    {
        // We are not active, so use a local notification instead
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        localNotification.alertAction = @"Not implemented";
        localNotification.alertBody = body;
        
        [[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];
    }
    
}
@end
