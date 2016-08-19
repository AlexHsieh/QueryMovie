//
//  QMRequestModel.m
//  QueryMovie
//
//  Created by Alex Hsieh on 8/18/16.
//  Copyright © 2016 Alex Hsieh. All rights reserved.
//

#import "QMRequestModel.h"

@implementation QMRequestModel

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"query": @"query",
                                                       @"page": @"page",
                                                       @"primary_release_year": @"year",
                                                       @"sort_by": @"sortBy",
                                                       @"vote_count.gte": @"voteCountGreat",
                                                       @"with_genres":@"genre"
                                                       }];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end
