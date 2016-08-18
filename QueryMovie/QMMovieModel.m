//
//  QMMovieModel.m
//  QueryMovie
//
//  Created by Alex Hsieh on 8/18/16.
//  Copyright © 2016 Alex Hsieh. All rights reserved.
//

#import "QMMovieModel.h"

@implementation QMMovieModel
+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"id",
                                                       @"title": @"title",
                                                       @"overview": @"overview",
                                                       @"popularity": @"popularity",
                                                       @"poster_path":@"poster",
                                                       @"release_date": @"date",
                                                       @"vote_average": @"rate",
                                                       @"vote_count": @"voteCount",}];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

- (void)setDateWithNSString:(NSString *)dateStr {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-mm-dd"];
    NSTimeZone *taiwanTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
    [dateFormatter setTimeZone:taiwanTimeZone];
    _date = [dateFormatter dateFromString:dateStr];
}

@end
