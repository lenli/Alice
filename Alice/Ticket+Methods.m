//
//  Ticket+Methods.m
//  Alice
//
//  Created by Leonard Li on 5/1/14.
//  Copyright (c) 2014 Leonard Li. All rights reserved.
//

#import "Ticket+Methods.h"

@implementation Ticket (Methods)

+ (instancetype) ticketWithId:(NSNumber *)idNumber
                   withStatus:(NSString *)status
                     withType:(NSString *)type
                       isDone:(BOOL)isDone
                    inContext:(NSManagedObjectContext *)context
{
    return [[self alloc] initWithId:idNumber
                         withStatus:status
                           withType:type
                             isDone:isDone
                          inContext:context];
}

- (instancetype) initWithId:(NSNumber *)idNumber
                 withStatus:(NSString *)status
                   withType:(NSString *)type
                     isDone:(BOOL)isDone
                  inContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *ticketSearch = [NSFetchRequest fetchRequestWithEntityName:@"Ticket"];
    NSPredicate *idCheck = [NSPredicate predicateWithFormat:@"id==%@", idNumber];
    ticketSearch.predicate = idCheck;
    NSArray *ticketMatches = [context executeFetchRequest:ticketSearch error:nil];
    if ([ticketMatches count] == 0) {
        Ticket *newTicket = [NSEntityDescription insertNewObjectForEntityForName:@"Ticket" inManagedObjectContext:context];
        
        if (newTicket) {
            newTicket.id = idNumber;
            newTicket.status = status;
            newTicket.ticketType = type;
            newTicket.isDone = @(isDone);
        }
        return newTicket;
    }
    return ticketMatches[0];
}
@end
