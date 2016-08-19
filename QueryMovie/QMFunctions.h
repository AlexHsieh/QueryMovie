//
//  QMFunctions.h
//  QueryMovie
//
//  Created by Alex Hsieh on 8/18/16.
//  Copyright © 2016 Alex Hsieh. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CompletionBlock)(BOOL isSuccess, NSError *error);

extern NSString *const QMNotificationCacheUpdated;

@class QMRequestModel;

@interface QMFunctions : NSObject

/** QMFunctions is singleton
 */
+ (QMFunctions *)sharedInstance;


/** if query server sucess, this method will send notifiation
 * QMNotificationCacheUpdated
 */
- (void)queryMovieFromCacheThenNetwork:(QMRequestModel *)requestModel
                          completion:(CompletionBlock)completion;


/** This method returns Movies loaded from cache
 * and filtered and sorted based on requestModel
 */
- (NSArray *)getMovies;


/** This method returns genre dictionary.
 *  key is genre id, obj is name
 */
- (NSDictionary *)genreType;

@end