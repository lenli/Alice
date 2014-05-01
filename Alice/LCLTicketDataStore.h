//
//  LCLTicketDataStore.h
//  Alice
//
//  Created by Leonard Li on 4/30/14.
//  Copyright (c) 2014 Leonard Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ticket+Methods.h"
#import "Facility+Methods.h"

@interface LCLTicketDataStore : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) NSFetchedResultsController *ticketFRController;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

+ (instancetype)sharedDataStore;

@end
