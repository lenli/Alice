//
//  Facility+Methods.h
//  Alice
//
//  Created by Leonard Li on 5/1/14.
//  Copyright (c) 2014 Leonard Li. All rights reserved.
//

#import "Facility.h"

@interface Facility (Methods)
+ (instancetype) facilityWithId:(NSNumber *)idNumber
                       withName:(NSString *)facilityString
                      inContext:(NSManagedObjectContext *)context;
- (instancetype) initWithId:(NSNumber *)idNumber
                   withName:(NSString *)facilityString
                  inContext:(NSManagedObjectContext *)context;
@end
