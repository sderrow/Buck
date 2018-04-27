//
//  Pairing.h
//  Buck
//
//  Created by Sean Derrow on 8/2/14.
//  Copyright (c) 2014 Buck, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Buck, User;

@interface Pairing : NSManagedObject

@property (nonatomic, retain) NSNumber * pairingID;
@property (nonatomic, retain) Buck *buck;
@property (nonatomic, retain) NSSet *players;
@end

@interface Pairing (CoreDataGeneratedAccessors)

- (void)addPlayersObject:(User *)value;
- (void)removePlayersObject:(User *)value;
- (void)addPlayers:(NSSet *)values;
- (void)removePlayers:(NSSet *)values;

@end
