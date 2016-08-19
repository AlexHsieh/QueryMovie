//
//  QMMovieDetailViewController.h
//  QueryMovie
//
//  Created by Alex Hsieh on 8/19/16.
//  Copyright © 2016 Alex Hsieh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QMMovieModel;

@interface QMMovieDetailViewController : UIViewController

- (void)setupMovieModel:(QMMovieModel *)model;

@end
