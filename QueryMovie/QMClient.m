//
//  QMClient.m
//  QueryMovie
//
//  Created by Alex Hsieh on 8/18/16.
//  Copyright © 2016 Alex Hsieh. All rights reserved.
//

#import "QMClient.h"
#import "QMRequestModel.h"
#import "QMResponseModel.h"

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

- (NSDictionary *)convertModelToParameter:(QMRequestModel *)model {
    NSMutableDictionary *d = model.toDictionary.mutableCopy;
    [d setObject:@"8318e2cc672e2f5929d3a63dcff410c3" forKey:@"api_key"];
    return d.copy;
}


- (QMClientTaskCompletionSource *)_taskCompletionwWithPath:(NSString *)path
                                              requestModel:(QMRequestModel *)model
{
    QMClientTaskCompletionSource *source = [QMClientTaskCompletionSource taskCompletionSource];
    
    // Create a example parameters for now
    NSDictionary *parameters = [self convertModelToParameter:model];
  
    source.connectionTask = [self GET:path parameters:parameters progress:nil
                              success:^(NSURLSessionDataTask *task, id result) {
                                  NSError *jsonError = nil;
                                  QMResponseModel *response = [[QMResponseModel alloc] initWithDictionary:result error:&jsonError];
                                  if (jsonError) {
                                      [source setError:jsonError];
                                      return;
                                  }
                                NSLog(@"query response = %@",response);
                                [source setResult:response];
                            }failure:^(NSURLSessionDataTask *task, NSError *error) {
                                NSLog(@"query error = %@",error);
                                [source setError:error];
                            }];
    

    return source;
}

- (QMClientTaskCompletionSource *)search:(QMRequestModel *)model {
    return [self _taskCompletionwWithPath:@"search/movie" requestModel:model];
}

@end
