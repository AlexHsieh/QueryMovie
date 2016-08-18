//
//  QMResponseModel.h
//  QueryMovie
//
//  Created by Alex Hsieh on 8/18/16.
//  Copyright © 2016 Alex Hsieh. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "QMMovieModel.h"

@interface QMResponseModel : JSONModel
@property (nonatomic,strong) NSArray<QMMovieModel> *results;
@property (nonatomic,assign) float page;
@property (nonatomic,assign) float totalPages;
@property (nonatomic,assign) float totalResults;

@end
