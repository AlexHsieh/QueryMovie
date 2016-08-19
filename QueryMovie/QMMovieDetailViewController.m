//
//  QMMovieDetailViewController.m
//  QueryMovie
//
//  Created by Alex Hsieh on 8/19/16.
//  Copyright © 2016 Alex Hsieh. All rights reserved.
//

#import "QMMovieDetailViewController.h"
#import "QMMovieModel.h"

@interface QMMovieDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *overviewLabel;

@property (strong,nonatomic) QMMovieModel *movieModel;
@end

@implementation QMMovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupGUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupGUI {
    self.titleLabel.text = self.movieModel.title;
    self.overviewLabel.text = self.movieModel.overview;
}

@end
