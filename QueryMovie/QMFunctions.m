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

@interface QMFunctions()
@property (nonatomic, strong) QMClient *client;

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


@end
