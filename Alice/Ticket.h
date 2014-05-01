//
//  Ticket.h
//  Alice
//
//  Created by Leonard Li on 5/1/14.
//  Copyright (c) 2014 Leonard Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Facility;

@interface Ticket : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) NSString * ticketType;
@property (nonatomic, retain) NSNumber * isDone;
@property (nonatomic, retain) Facility *facility;

@end
