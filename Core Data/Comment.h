//
//  Comment.h
//  Buck
//
//  Created by Sean Derrow on 8/2/14.
//  Copyright (c) 2014 Buck, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Buck, User;

@interface Comment : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) Buck *buck;
@property (nonatomic, retain) User *user;

@end
