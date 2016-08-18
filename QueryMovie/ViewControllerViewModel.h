//
//  ViewControllerViewModel.h
//  QueryMovie
//
//  Created by Alex Hsieh on 8/18/16.
//  Copyright © 2016 Alex Hsieh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewControllerViewModel : NSObject

/** year from 1960 to now
 */
@property (strong,nonatomic) NSArray *years;


/* search action
 */
- (void)searchWithCompletion:(void (^)(BOOL success, NSError *error))completion;

@end
