//
//  Buck+Create.m
//  Buck
//
//  Created by Sean Derrow on 7/31/14.
//  Copyright (c) 2014 Buck, Inc. All rights reserved.
//

#import "Buck+Create.h"

@implementation Buck (Create)

+ (Buck *)newBuckwithProposition:(NSString *)proposition
                            host:(User *)host
                         choice1:(NSString *)choice1
                         choice2:(NSString *)choice2
                  expirationDate:(NSDate *)expirationDate
          inManagedObjectContext:(NSManagedObjectContext *)context
{
    Buck *buck = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Buck"];
    request.predicate = nil;
    
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if (!matches) {
        NSLog(@"error fetching all bucks");
    } else {
        buck = [NSEntityDescription insertNewObjectForEntityForName:@"Buck"
                                             inManagedObjectContext:context];
        buck.buckID = @([matches count] + 1);
        buck.proposition = proposition;
        buck.host = host;
        buck.postedDate = [NSDate date];
        buck.expirationDate = expirationDate;
        buck.likeCount = @(0);
        buck.comments = [[NSSet alloc] init];
        buck.status = @(1);
        buck.pairings = [[NSSet alloc] init];
        buck.choice1 = choice1;
        buck.choice2 = choice2;
        buck.waitingChoice = @(0);
        buck.answer = @(0);
    }

    return buck;
}

@end
