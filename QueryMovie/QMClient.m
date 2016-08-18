//
//  QMClient.m
//  QueryMovie
//
//  Created by Alex Hsieh on 8/18/16.
//  Copyright © 2016 Alex Hsieh. All rights reserved.
//

#import "QMClient.h"

@implementation QMClientTaskCompletionSource

+ (QMClientTaskCompletionSource *)taskCompletionSource
{
    return [[QMClientTaskCompletionSource alloc] init];
}

- (void)dealloc
{
    [self.connectionTask cancel];
    self.connectionTask = nil;
}

- (void)cancel
{
    [self.connectionTask cancel];
    [super cancel];
}

@end

@implementation QMClient

- (instancetype)initWithBaseURL:(NSURL *)url
{
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    self = [super initWithBaseURL:url sessionConfiguration:sessionConfiguration];
    if (self) {
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        
        AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        policy.allowInvalidCertificates = YES;
        policy.validatesDomainName = NO;
        self.securityPolicy = policy;
    }
    return self;
}


- (QMClientTaskCompletionSource *)_taskCompletion
{
    QMClientTaskCompletionSource *source = [QMClientTaskCompletionSource taskCompletionSource];
    // make |requestPath|, this will create `<baseURL>/discover/movie`
    NSString *requestPath = [NSString stringWithFormat:@"discover/movie"];
    
    // Create a example parameters for now
    NSDictionary *parameters = @{@"api_key":@"8318e2cc672e2f5929d3a63dcff410c3",@"sort_by":@"vote_average.desc",
                                 @"page":@"1",@"vote_count.gte":@"100"};
  
    source.connectionTask = [self GET:requestPath parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id result) {
        NSLog(@"query result = %@",result);
        [source setResult:result];
    }failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"query error = %@",error);
        [source setError:error];
    }];
    

    return source;
}

@end
