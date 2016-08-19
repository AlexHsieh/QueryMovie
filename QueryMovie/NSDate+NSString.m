//
//  NSDate+NSString.m
//  QueryMovie
//
//  Created by Alex Hsieh on 8/19/16.
//  Copyright © 2016 Alex Hsieh. All rights reserved.
//

#import "NSDate+NSString.h"

@implementation NSDate (NSString)

+ (NSDateFormatter *)singletonDateFormatter {
    static NSDateFormatter *sharedDateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDateFormatter = [[NSDateFormatter alloc]init];
        [sharedDateFormatter setDateFormat:@"yyyy"];
    });
    return sharedDateFormatter;
}

+ (NSString *)fromDateToYear:(NSDate *)date {
    return [[self singletonDateFormatter] stringFromDate:date];
}

@end
