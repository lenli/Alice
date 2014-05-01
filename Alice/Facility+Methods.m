//
//  Facility+Methods.m
//  Alice
//
//  Created by Leonard Li on 5/1/14.
//  Copyright (c) 2014 Leonard Li. All rights reserved.
//

#import "Facility+Methods.h"

@implementation Facility (Methods)

+ (instancetype) facilityWithId:(NSNumber *)idNumber
                       withName:(NSString *)facilityString
                      inContext:(NSManagedObjectContext *)context
{
    return [[self alloc] initWithId:idNumber
                           withName:facilityString
                          inContext:context];
}

- (instancetype) initWithId:(NSNumber *)idNumber
                   withName:(NSString *)facilityString
                  inContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *facilitySearch = [NSFetchRequest fetchRequestWithEntityName:@"Facility"];
    NSPredicate *idCheck = [NSPredicate predicateWithFormat:@"id==%@", idNumber];
    facilitySearch.predicate = idCheck;
    NSArray *facilityMatches = [context executeFetchRequest:facilitySearch error:nil];
    if ([facilityMatches count] == 0) {
        Facility *newFacility = [NSEntityDescription insertNewObjectForEntityForName:@"Facility" inManagedObjectContext:context];
        
        if (newFacility) {
            newFacility.id = idNumber;
            newFacility.name = facilityString;
        }
        return newFacility;
    }
    return facilityMatches[0];
}

@end
