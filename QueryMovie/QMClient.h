//
//  QMClient.h
//  QueryMovie
//
//  Created by Alex Hsieh on 8/18/16.
//  Copyright © 2016 Alex Hsieh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPSessionManager.h"
#import "Bolts.h"

@interface QMClientTaskCompletionSource : BFTaskCompletionSource

+ (QMClientTaskCompletionSource *)taskCompletionSource;
@property (nonatomic, strong) NSURLSessionTask *connectionTask;

@end

@class QMRequestModel;
@interface QMClient : AFHTTPSessionManager

/** search API
 */
- (QMClientTaskCompletionSource *)search:(QMRequestModel *)model;

/** discover API
 */
- (QMClientTaskCompletionSource *)discover:(QMRequestModel *)model;

@end
