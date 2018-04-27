//
//  BuckAppDelegate.m
//  Buck
//
//  Created by Sean Derrow on 7/31/14.
//  Copyright (c) 2014 Buck, Inc. All rights reserved.
//

#import "BuckAppDelegate.h"
#import "BuckDatabaseAvailability.h"
#import "User+Create.h"
#import "Buck+Create.h"

@interface BuckAppDelegate()

@property (strong, nonatomic) NSManagedObjectContext *buckDatabaseContext;
@property (strong, nonatomic) UIManagedDocument *document;
@property (strong, nonatomic) NSString *userID;

@end

@implementation BuckAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.userID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    [self createContext];
    
    // Override point for customization after application launch.
    return YES;
}

- (void)createContext
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentsDirectory = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
    NSURL *url = [documentsDirectory URLByAppendingPathComponent:@"BuckDocument"];
    self.document = [[UIManagedDocument alloc] initWithFileURL:url];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:[url path]]) {
        [self.document saveToURL:self.document.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            if (success) {
                //NSLog(@"document created");
                [self documentIsReady];
            } else {
                NSLog(@"couldn't create document at %@", url);
            }
        }];
    }
    else {
        [self.document openWithCompletionHandler:^(BOOL success) {
            if (success) {
                //NSLog(@"document opened");
                [self documentIsReady];
            } else {
                NSLog(@"couldn't open document at %@", url);
            }
        }];
    }
}

- (void)documentIsReady
{
    if (self.document.documentState == UIDocumentStateNormal) {
        self.buckDatabaseContext = self.document.managedObjectContext;
        
        [User userWithUserID:self.userID firstName:@"Sean" lastName:@"Derrow" inManagedObjectContext:self.buckDatabaseContext];
        [User userWithUserID:@"cecilUserID" firstName:@"Cecil" lastName:@"Qiu" inManagedObjectContext:self.buckDatabaseContext];

    }
}

- (void)setBuckDatabaseContext:(NSManagedObjectContext *)buckDatabaseContext
{
    _buckDatabaseContext = buckDatabaseContext;
    
    NSDictionary *userInfo = self.buckDatabaseContext ? @{ BuckDatabaseAvailabilityContext : self.buckDatabaseContext } : nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:BuckDatabaseAvailabilityNotification
                                                        object:self
                                                      userInfo:userInfo];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
