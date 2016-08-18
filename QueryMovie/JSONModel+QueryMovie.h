//
//  JSONModel+QueryMovie.h
//  QueryMovie
//
//  Created by Alex Hsieh on 8/18/16.
//  Copyright © 2016 Alex Hsieh. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface JSONModel (QueryMovie)

/** for request model attribute with "." in the attribute
 *  JSONModel will convert it to second layer.
 *  Use this method to get expected parameter using in the 
 *  query API
 */
- (NSDictionary *)modelToDictionary;

@end
