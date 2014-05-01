//
//  LCLAliceAPIClient.m
//  Alice
//
//  Created by Leonard Li on 4/30/14.
//  Copyright (c) 2014 Leonard Li. All rights reserved.
//

#import "LCLAliceAPIClient.h"
#import "AFNetworking.h"

@interface LCLAliceAPIClient ()
@property (strong, nonatomic) AFHTTPSessionManager *manager;
@property (strong, nonatomic) NSString *baseURLString;

@end

@implementation LCLAliceAPIClient

+ (instancetype)sharedClient {
    static LCLAliceAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[LCLAliceAPIClient alloc] init];
    });
    
    return _sharedClient;
}

#pragma mark - Lazy Instantiation

- (NSString *) baseURLString
{
    return @"http://test.alice-app.com/";
}

- (AFHTTPSessionManager *) manager
{
    if (!_manager)
    {
        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:self.baseURLString]];
        _manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    }
    
    return _manager;
}


- (void) postAuthenticationWithUser:(NSString *)usernameString
                       withPassword:(NSString *)passwordString
               Completion:(void (^)(NSDictionary *))completion
{
    NSString *aliceUserLoginURL = [NSString stringWithFormat:@"%@app_auth?ajax=true", self.baseURLString];
    NSURL *url = [NSURL URLWithString:aliceUserLoginURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    AFHTTPRequestOperation *newOp = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    NSString *json = [NSString stringWithFormat:@"{\"j_username\":\"%@\",\"j_password\":\"%@\"}",usernameString, passwordString];
    request.HTTPBody = [json dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";
    
    [newOp setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error = nil;
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        if (error) {
            
            NSLog(@"JSON Serialization Error on User: %@", error);
        }

//        NSLog(@"Alice Post Response Object: %@",responseDictionary);
        [self saveCookies];
//        NSLog(@"Session Cookie: %@", [[NSUserDefaults standardUserDefaults] valueForKey:@"sessionCookies"]);
        completion(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Alice Post Error On User: %@",error);
    }];
    
    [newOp start];
}

- (void) getTicketsWithCompletion:(void (^)(NSDictionary *ticketDictionary))completion
{
    NSString *aliceTicketURL = [NSString stringWithFormat:@"%@employeeView/loadTickets", self.baseURLString];
    NSURL *url = [NSURL URLWithString:aliceTicketURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *newOp = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    request.HTTPMethod = @"GET";
    
    [self loadCookies];
    [newOp setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error = nil;
        NSDictionary *ticketDictionary = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                         options:NSJSONReadingAllowFragments
                                                                           error:&error];
//        NSLog(@"Alice Ticket Dictionary: %@", ticketDictionary);
        if (error) {
            NSLog(@"JSON Serialization Error On Tickets: %@", error);
        }
        completion(ticketDictionary);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Alice Get Error On Tickets: %@",error);
    }];
    
    [newOp start];
}

#pragma mark - Cookie Helper Methods

- (void)saveCookies{
    
    NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject: [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject: cookiesData forKey: @"sessionCookies"];
    [defaults synchronize];
    
}

- (void)loadCookies{
    
    NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey: @"sessionCookies"]];
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    for (NSHTTPCookie *cookie in cookies){
        [cookieStorage setCookie: cookie];
    }
    
}


@end
