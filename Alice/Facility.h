//
//  Facility.h
//  Alice
//
//  Created by Leonard Li on 5/1/14.
//  Copyright (c) 2014 Leonard Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Ticket;

@interface Facility : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *tickets;
@end

@interface Facility (CoreDataGeneratedAccessors)

- (void)addTicketsObject:(Ticket *)value;
- (void)removeTicketsObject:(Ticket *)value;
- (void)addTickets:(NSSet *)values;
- (void)removeTickets:(NSSet *)values;

@end
