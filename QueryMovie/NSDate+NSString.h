//
//  NSDate+NSString.h
//  QueryMovie
//
//  Created by Alex Hsieh on 8/19/16.
//  Copyright © 2016 Alex Hsieh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (NSString)

/** convert date to year only
 */
+ (NSString *)fromDateToYear:(NSDate *)date;

@end
