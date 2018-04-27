//
//  Buck.h
//  Buck
//
//  Created by Sean Derrow on 8/2/14.
//  Copyright (c) 2014 Buck, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Comment, Pairing, User;

@interface Buck : NSManagedObject

@property (nonatomic, retain) NSNumber * answer;
@property (nonatomic, retain) NSNumber * buckID;
@property (nonatomic, retain) NSString * choice1;
@property (nonatomic, retain) NSString * choice2;
@property (nonatomic, retain) NSDate * expirationDate;
@property (nonatomic, retain) NSNumber * likeCount;
@property (nonatomic, retain) NSDate * postedDate;
@property (nonatomic, retain) NSString * proposition;
@property (nonatomic, retain) NSNumber * status;
@property (nonatomic, retain) NSNumber * waitingChoice;
@property (nonatomic, retain) NSSet *comments;
@property (nonatomic, retain) NSSet *pairings;
@property (nonatomic, retain) User *host;
@property (nonatomic, retain) NSSet *waitingUsers;
@end

@interface Buck (CoreDataGeneratedAccessors)

- (void)addCommentsObject:(Comment *)value;
- (void)removeCommentsObject:(Comment *)value;
- (void)addComments:(NSSet *)values;
- (void)removeComments:(NSSet *)values;

- (void)addPairingsObject:(Pairing *)value;
- (void)removePairingsObject:(Pairing *)value;
- (void)addPairings:(NSSet *)values;
- (void)removePairings:(NSSet *)values;

- (void)addWaitingUsersObject:(User *)value;
- (void)removeWaitingUsersObject:(User *)value;
- (void)addWaitingUsers:(NSSet *)values;
- (void)removeWaitingUsers:(NSSet *)values;

@end
