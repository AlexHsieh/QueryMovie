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
#import "NSDate+NSString.h"

NSString *const QMNotificationCacheUpdated = @"QMNotificationCacheUpdated";


@interface QMFunctions()
@property (nonatomic, strong) QMClient *client;
@property (nonatomic, strong) NSMutableDictionary *cache;
@property (nonatomic, strong) QMRequestModel *requestModel;
@property (nonatomic, strong) NSDictionary *genre;
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
    
    if ([self isThereCacheForRequestModel:requestModel]) {
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

- (BOOL)isThereCacheForRequestModel:(QMRequestModel *)model {
    //Discovery
    if (model.query.length == 0 && self.cache.count >= 20) {
        return YES;
    }
    
    //search
    return [self getMovies].count?YES:NO;
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
 
    return [[[[self filterTitle].task continueWithSuccessBlock:^id(BFTask *task) {
        return [self filterYear:task.result].task;
    }] continueWithSuccessBlock:^id(BFTask *task) {
        return [self filterGenre:task.result].task;
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
    for (QMMovieModel *mm in movies) {
        NSString *year = [NSDate fromDateToYear:mm.date];
        if ([year isEqualToString:self.requestModel.year]) {
            [filterMovies addObject:mm];
        }
    }
    
    [completionSource setResult:filterMovies];
    return completionSource;
}

- (BFTaskCompletionSource *)filterGenre:(NSArray *)movies {
    BFTaskCompletionSource *completionSource = [BFTaskCompletionSource taskCompletionSource];
    if (!self.requestModel || !self.requestModel.genre) {
        [completionSource setResult:movies];
        return completionSource;
    }
    
    NSMutableArray *filterMovies = [NSMutableArray array];
    for (QMMovieModel *mm in movies) {
        if ([mm.genre objectForKey:@(self.requestModel.genre.integerValue)]) {
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

- (NSDictionary *)genreType {
    if (!_genre) {
        _genre = @{@"28":@"Action",@"12":@"Adventure",@"16":@"Animation",@"35":@"Comedy",
                   @"80":@"Crime",@"99":@"Documentary",@"18":@"Drama",@"10751":@"Family",
                   @"14":@"Fantasy",@"10769":@"Foreign",@"36":@"History",@"27":@"Horror",
                   @"10402":@"Music",@"9648":@"Mystery",@"10749":@"Romance",@"878":@"Science Fiction",
                   @"10770":@"TV Movie",@"53":@"Thriller",@"10752":@"War",@"37":@"Western"};
    }
    return _genre;
}

@end
