//
//  User.h
//  Buck
//
//  Created by Sean Derrow on 8/2/14.
//  Copyright (c) 2014 Buck, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Buck, Comment, Pairing;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSDate * joinDate;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSData * thumbnail;
@property (nonatomic, retain) NSString * userID;
@property (nonatomic, retain) NSNumber * hostRating;
@property (nonatomic, retain) NSNumber * playerRating;
@property (nonatomic, retain) NSSet *comments;
@property (nonatomic, retain) NSSet *pairings;
@property (nonatomic, retain) NSSet *hostedBucks;
@property (nonatomic, retain) NSSet *waitingBucks;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addCommentsObject:(Comment *)value;
- (void)removeCommentsObject:(Comment *)value;
- (void)addComments:(NSSet *)values;
- (void)removeComments:(NSSet *)values;

- (void)addPairingsObject:(Pairing *)value;
- (void)removePairingsObject:(Pairing *)value;
- (void)addPairings:(NSSet *)values;
- (void)removePairings:(NSSet *)values;

- (void)addHostedBucksObject:(Buck *)value;
- (void)removeHostedBucksObject:(Buck *)value;
- (void)addHostedBucks:(NSSet *)values;
- (void)removeHostedBucks:(NSSet *)values;

- (void)addWaitingBucksObject:(Buck *)value;
- (void)removeWaitingBucksObject:(Buck *)value;
- (void)addWaitingBucks:(NSSet *)values;
- (void)removeWaitingBucks:(NSSet *)values;

@end
