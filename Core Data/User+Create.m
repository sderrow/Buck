//
//  User+Create.m
//  Buck
//
//  Created by Sean Derrow on 7/31/14.
//  Copyright (c) 2014 Buck, Inc. All rights reserved.
//

#import "User+Create.h"

@implementation User (Create)

+ (User *)userWithUserID:(NSString *)userID
               firstName:(NSString *)firstName
                   lastName:(NSString *)lastName
     inManagedObjectContext:(NSManagedObjectContext *)context
{
    User *user = nil;
    
    if ([userID length]) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
        request.predicate = [NSPredicate predicateWithFormat:@"userID = %@", userID];
        
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            NSLog(@"error fetching user with userID %@", userID);
        } else if (![matches count]) {
            //NSLog(@"Didn't find user");
            user = [NSEntityDescription insertNewObjectForEntityForName:@"User"
                                                         inManagedObjectContext:context];
            user.userID = userID;
            user.firstName = firstName;
            user.lastName = lastName;
            user.joinDate = [NSDate date];
            user.hostRating = @(10);
            user.playerRating = @(1);
            user.thumbnail = UIImagePNGRepresentation([UIImage imageNamed:[firstName lowercaseString]]);
        } else {
            user = [matches lastObject];
        }
    }
    
    return user;
}

+ (User *)myUserID:(NSManagedObjectContext *)context
{
    NSString *userID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    return [User userWithUserID:userID firstName:nil lastName:nil inManagedObjectContext:context];
}

@end
