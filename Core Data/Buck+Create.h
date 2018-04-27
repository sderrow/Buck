//
//  Buck+Create.h
//  Buck
//
//  Created by Sean Derrow on 7/31/14.
//  Copyright (c) 2014 Buck, Inc. All rights reserved.
//

#import "Buck.h"
#import "User.h"

@interface Buck (Create)

+ (Buck *)newBuckwithProposition:(NSString *)proposition
                host:(User *)host
             choice1:(NSString *)choice1
             choice2:(NSString *)choice2
      expirationDate:(NSDate *)expirationDate
inManagedObjectContext:(NSManagedObjectContext *)context;

@end
