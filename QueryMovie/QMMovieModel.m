//
//  QMMovieModel.m
//  QueryMovie
//
//  Created by Alex Hsieh on 8/18/16.
//  Copyright © 2016 Alex Hsieh. All rights reserved.
//

#import "QMMovieModel.h"
#import "QMFunctions.h"

@implementation QMMovieModel
+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"id",
                                                       @"title": @"title",
                                                       @"overview": @"overview",
                                                       @"popularity": @"popularity",
                                                       @"poster_path":@"poster",
                                                       @"release_date": @"date",
                                                       @"vote_average": @"rate",
                                                       @"vote_count": @"voteCount",
                                                       @"genre_ids":@"genre"}];
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

- (void)setGenreWithNSArray:(NSArray *)arr {
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    for (NSNumber *n in arr) {
        NSString *genre = [[[QMFunctions sharedInstance] genreType] objectForKey:n.stringValue];
        if (genre) {
            [md setObject:genre forKey:n];
        }
    }
    _genre = md.copy;
}

@end
