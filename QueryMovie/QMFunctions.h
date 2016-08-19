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


/** if network sucess, this method will send notifiation
 * QMNotificationCacheUpdated
 */
- (void)getMovieFromCacheThenNetwork:(QMRequestModel *)requestModel
                          completion:(CompletionBlock)completion;


@end