//
//  Ticket+Methods.h
//  Alice
//
//  Created by Leonard Li on 5/1/14.
//  Copyright (c) 2014 Leonard Li. All rights reserved.
//

#import "Ticket.h"

@interface Ticket (Methods)
+ (instancetype) ticketWithId:(NSNumber *)idNumber
                   withStatus:(NSString *)status
                     withType:(NSString *)type
                       isDone:(BOOL)isDone
                    inContext:(NSManagedObjectContext *)context;
- (instancetype) initWithId:(NSNumber *)idNumber
                 withStatus:(NSString *)status
                   withType:(NSString *)type
                     isDone:(BOOL)isDone
                  inContext:(NSManagedObjectContext *)context;

@end
