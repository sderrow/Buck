//
//  Pairing+Create.h
//  Buck
//
//  Created by Sean Derrow on 8/5/14.
//  Copyright (c) 2014 Buck, Inc. All rights reserved.
//

#import "Pairing.h"
#import "Buck.h"

@interface Pairing (Create)
+ (Pairing *)pairingWithBuck:(Buck *)buck
                     players:(NSSet *)players
      inManagedObjectContext:(NSManagedObjectContext *)context;
@end
