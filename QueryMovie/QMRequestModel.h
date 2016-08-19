//
//  QMRequestModel.h
//  QueryMovie
//
//  Created by Alex Hsieh on 8/18/16.
//  Copyright © 2016 Alex Hsieh. All rights reserved.
//


#import <JSONModel/JSONModel.h>

@interface QMRequestModel : JSONModel
@property (nonatomic,strong) NSString *query;
@property (nonatomic,strong) NSString *page;
@property (nonatomic,strong) NSString *year;
@property (nonatomic,strong) NSString *genre;

@property (nonatomic,strong) NSString *sortBy;
@property (nonatomic,strong) NSString *voteCountGreat;

@end
