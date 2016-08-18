//
//  JSONModel+QueryMovie.m
//  QueryMovie
//
//  Created by Alex Hsieh on 8/18/16.
//  Copyright © 2016 Alex Hsieh. All rights reserved.
//

#import "JSONModel+QueryMovie.h"
#import "JSONModelClassProperty.h"


@implementation JSONModel (QueryMovie)

- (NSDictionary *)modelToDictionary {
    NSMutableDictionary *tmpDic = self.toDictionary.mutableCopy;
    if ([tmpDic objectForKey:@"vote_count"]) {
        [tmpDic setObject:tmpDic[@"vote_count"][@"gte"] forKey:@"vote_count.gte"];
        [tmpDic removeObjectForKey:@"vote_count"];
    }
    return tmpDic.copy;
}


@end
