//
//  QMResponseModel.m
//  QueryMovie
//
//  Created by Alex Hsieh on 8/18/16.
//  Copyright © 2016 Alex Hsieh. All rights reserved.
//

#import "QMResponseModel.h"

@implementation QMResponseModel
+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"results":@"results",
                                                       @"page": @"page",
                                                       @"total_pages": @"totalPages",
                                                       @"total_results": @"totalResults"}];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end
