//
//  User+Create.h
//  Buck
//
//  Created by Sean Derrow on 7/31/14.
//  Copyright (c) 2014 Buck, Inc. All rights reserved.
//

#import "User.h"

@interface User (Create)

+ (User *)userWithUserID:(NSString *)userID
               firstName:(NSString *)firstName
                lastName:(NSString *)lastName
  inManagedObjectContext:(NSManagedObjectContext *)context;
+ (User *)myUserID:(NSManagedObjectContext *)context;
@end
