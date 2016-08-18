//
//  ViewControllerViewModel.m
//  QueryMovie
//
//  Created by Alex Hsieh on 8/18/16.
//  Copyright © 2016 Alex Hsieh. All rights reserved.
//

#import "ViewControllerViewModel.h"

@implementation ViewControllerViewModel

- (NSArray *)years {
    if (!_years) {
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy"];
        int cy  = [[formatter stringFromDate:[NSDate date]] intValue];
        
        NSMutableArray *arr = [NSMutableArray array];
        for (int i=1960; i<=cy; i++) {
            [arr addObject:[NSString stringWithFormat:@"%d",i]];
        }
        _years = arr.copy;
    }
    return _years;
}

@end
