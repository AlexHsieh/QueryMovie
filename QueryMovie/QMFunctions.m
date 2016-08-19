//
//  QMFunctions.m
//  QueryMovie
//
//  Created by Alex Hsieh on 8/18/16.
//  Copyright © 2016 Alex Hsieh. All rights reserved.
//

#import "QMFunctions.h"
#import "QMClient.h"
#import "QMRequestModel.h"
#import "QMMovieModel.h"
#import "QMResponseModel.h"


NSString *const QMNotificationCacheUpdated = @"QMNotificationCacheUpdated";


@interface QMFunctions()
@property (nonatomic, strong) QMClient *client;
@property (nonatomic, strong) NSMutableDictionary *cache;
@property (nonatomic, strong) QMRequestModel *requestModel;

@end

@implementation QMFunctions

+ (QMFunctions *)sharedInstance {
    static QMFunctions *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        NSURL *serverURL = [NSURL URLWithString:@"http://api.themoviedb.org/3/"];
        sharedInstance.client = [[QMClient alloc] initWithBaseURL:serverURL];
    });
    return sharedInstance;
}


- (void)queryMovieFromCacheThenNetwork:(QMRequestModel *)requestModel
                          completion:(CompletionBlock)completion {
    
    self.requestModel = requestModel;
    
    // check if there are some data in cache
    // although data in cache may not what we want
    // we set 20 for now. We can update this later
    if (self.cache.count > 20) {
        completion(YES,nil);
    }
    
    
    //search network
    if (requestModel.query.length) {
        [[[self.client search:requestModel].task continueWithSuccessBlock:^id(BFTask *task) {
            return [self storeMovieIntoCache:task.result].task;
        }] continueWithBlock:^id(BFTask *task) {
//            NSLog(@"cache:%@",self.cache);
            if (task.result) {
                completion(YES,nil);
                [[NSNotificationCenter defaultCenter]postNotificationName:QMNotificationCacheUpdated object:self];
            } else {
                completion(NO,task.error);
            }
            return nil;
        }];
    } else {
        [[[self.client discover:requestModel].task continueWithSuccessBlock:^id(BFTask *task) {
            return [self storeMovieIntoCache:task.result].task;
        }] continueWithBlock:^id(BFTask *task) {
//            NSLog(@"cache:%@",self.cache);
            if (task.result) {
                completion(YES,nil);
                [[NSNotificationCenter defaultCenter]postNotificationName:QMNotificationCacheUpdated object:self];
            } else {
                completion(NO,task.error);
            }
            return nil;
        }];
    }
}



- (BFTaskCompletionSource *)storeMovieIntoCache:(QMResponseModel *)responseModel {
    BFTaskCompletionSource *completionSource = [BFTaskCompletionSource taskCompletionSource];
    for (QMMovieModel *mm in responseModel.results) {
        [self.cache setObject:mm forKey:mm.id];
    }
    [completionSource setResult:responseModel];
    return completionSource;
}


- (NSArray *)getMovies {
 
    return [[[self filterTitle].task continueWithSuccessBlock:^id(BFTask *task) {
        return [self filterYear:task.result].task;
    }] continueWithSuccessBlock:^id(BFTask *task) {
        return [self sortMovies:task.result].task;
    }].result;
}

- (BFTaskCompletionSource *)filterTitle {
    BFTaskCompletionSource *completionSource = [BFTaskCompletionSource taskCompletionSource];
    if (!self.requestModel || !self.requestModel.query.length) {
        NSMutableArray *movies = [NSMutableArray arrayWithCapacity:self.cache.count];
        [self.cache enumerateKeysAndObjectsUsingBlock:^(NSString *id, QMMovieModel *mm, BOOL *stop){
            [movies addObject:mm];
        }];
        [completionSource setResult:movies];
        return completionSource;
    }
    
    NSMutableArray *movies = [NSMutableArray array];
    [self.cache enumerateKeysAndObjectsUsingBlock:^(NSString *id, QMMovieModel *mm, BOOL *stop){
        if ([mm.title rangeOfString:self.requestModel.query options:NSCaseInsensitiveSearch].length > 0) {
            [movies addObject:mm];
        }
    }];
    
    [completionSource setResult:movies];
    return completionSource;
}

- (BFTaskCompletionSource *)filterYear:(NSArray *)movies {
    BFTaskCompletionSource *completionSource = [BFTaskCompletionSource taskCompletionSource];
    if (!self.requestModel || self.requestModel.year.length < 4) {
        [completionSource setResult:movies];
        return completionSource;
    }
    
    NSMutableArray *filterMovies = [NSMutableArray array];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy"];
    for (QMMovieModel *mm in movies) {
        NSString *year = [dateFormatter stringFromDate:mm.date];
        if ([year isEqualToString:self.requestModel.year]) {
            [filterMovies addObject:mm];
        }
    }
    
    [completionSource setResult:filterMovies];
    return completionSource;
}

- (BFTaskCompletionSource *)sortMovies:(NSArray *)movies {
    BFTaskCompletionSource *completionSource = [BFTaskCompletionSource taskCompletionSource];

    NSArray *sortedMovies = [movies sortedArrayUsingComparator:^NSComparisonResult(QMMovieModel *mm1, QMMovieModel *mm2){
        return mm1.rate > mm2.rate;
    }];
    [completionSource setResult:sortedMovies];
    return completionSource;
}

#pragma mark - getter

- (NSMutableDictionary *)cache {
    if (!_cache) {
        _cache = [[NSMutableDictionary alloc]init];
    }
    return _cache;
}

@end
