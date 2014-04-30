//
//  LCLTicketDataManager.m
//  Alice
//
//  Created by Leonard Li on 4/30/14.
//  Copyright (c) 2014 Leonard Li. All rights reserved.
//

#import "LCLTicketDataManager.h"

@implementation LCLTicketDataManager

+ (LCLAliceAPIClient *)defaultAliceClient
{
    return [LCLAliceAPIClient sharedClient];
}

+ (NSManagedObjectContext *)defaultManagedObjectContext
{
    return [LCLTicketDataStore sharedDataStore].managedObjectContext;
}

+ (LCLTicketDataStore *)defaultDataStore
{
    return [LCLTicketDataStore sharedDataStore];
}


#pragma mark - Init Helper Methods

+ (instancetype)sharedManager {
    
    return [[self alloc] init];
}

- (instancetype)init
{
    return [self initWithAliceAPIClient:[[self class] defaultAliceClient]
                   managedObjectContext:[[self class] defaultManagedObjectContext]
                              dataStore:[[self class] defaultDataStore]];

}

- (instancetype)initWithAliceAPIClient:(LCLAliceAPIClient *)aliceClient
                  managedObjectContext:(NSManagedObjectContext *)managedObjectContext
                             dataStore:(LCLTicketDataStore *)dataStore
{
    
    static LCLTicketDataManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [super init];
        if (_sharedManager) {
            _aliceAPIClient = aliceClient;
            _managedObjectContext = managedObjectContext;
            _dataStore = dataStore;
        }
    });
    
    return _sharedManager;
}

#pragma mark - User Methods
- (void) authenticateWithUsername:(NSString *)usernameString
                     withPassword:(NSString *)passwordString
                   withCompletion:(void (^)(BOOL isSuccessful))completionBlock
{
    [self.aliceAPIClient postAuthenticationWithUser:usernameString
                                       withPassword:passwordString
                                         Completion:^(NSDictionary *successObject) {
        
    }];
}




@end
