//
//  Pairing+Create.m
//  Buck
//
//  Created by Sean Derrow on 8/5/14.
//  Copyright (c) 2014 Buck, Inc. All rights reserved.
//

#import "Pairing+Create.h"

@implementation Pairing (Create)

+ (Pairing *)pairingWithBuck:(Buck *)buck
                     players:(NSSet *)players
      inManagedObjectContext:(NSManagedObjectContext *)context
{
    Pairing *pairing = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Pairing"];
    request.predicate = nil;
    
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if (!matches) {
        NSLog(@"error fetching all pairings");
    } else {
        pairing = [NSEntityDescription insertNewObjectForEntityForName:@"Pairing"
                                             inManagedObjectContext:context];
        pairing.pairingID = @([matches count] + 1);
        pairing.buck = buck;
        [pairing addPlayers:players];
        
    }
    
    return pairing;
}

@end
