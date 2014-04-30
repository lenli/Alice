//
//  LCLTicketDataManager.h
//  Alice
//
//  Created by Leonard Li on 4/30/14.
//  Copyright (c) 2014 Leonard Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCLTicketDataStore.h"
#import "LCLAliceAPIClient.h"

@interface LCLTicketDataManager : NSObject

@property (strong, nonatomic) LCLAliceAPIClient *aliceAPIClient;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) LCLTicketDataStore *dataStore;

+ (instancetype)sharedManager;
- (instancetype)initWithAliceAPIClient:(LCLAliceAPIClient *)aliceClient
                  managedObjectContext:(NSManagedObjectContext *)managedObjectContext
                             dataStore:(LCLTicketDataStore *)dataStore;
- (void) authenticateWithUsername:(NSString *)usernameString
                     withPassword:(NSString *)passwordString
                   withCompletion:(void (^)(BOOL isSuccessful))completionBlock;
@end
