//
//  LCLAliceAPIClient.h
//  Alice
//
//  Created by Leonard Li on 4/30/14.
//  Copyright (c) 2014 Leonard Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCLAliceAPIClient : NSObject
+ (instancetype)sharedClient;
- (void) postAuthenticationWithUser:(NSString *)usernameString
                       withPassword:(NSString *)passwordString
                         Completion:(void (^)(NSDictionary *successObject))completion;

@end
