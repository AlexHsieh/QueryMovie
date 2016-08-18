//
//  QMMovieModel.h
//  QueryMovie
//
//  Created by Alex Hsieh on 8/18/16.
//  Copyright © 2016 Alex Hsieh. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol QMMovieModel
@end

@interface QMMovieModel : JSONModel
@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *overview;
@property (nonatomic,assign) float popularity;
@property (nonatomic,strong) NSString *poster;
@property (nonatomic,strong) NSDate *date;
@property (nonatomic,assign) float rate;
@property (nonatomic,assign) float voteCount;
@end
