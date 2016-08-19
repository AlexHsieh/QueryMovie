//
//  QMMovieListTableViewCell.m
//  QueryMovie
//
//  Created by Alex Hsieh on 8/19/16.
//  Copyright © 2016 Alex Hsieh. All rights reserved.
//

#import "QMMovieListTableViewCell.h"
#import "QMMovieModel.h"
#import "NSDate+NSString.h"
#import "QMFunctions.h"

@interface QMMovieListTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabl;
@property (weak, nonatomic) IBOutlet UILabel *genreLabel;

@end

@implementation QMMovieListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupCell:(QMMovieModel *)model {
    self.nameLabel.text = model.title;
    self.yearLabel.text = [NSDate fromDateToYear:model.date];
    self.ratingLabl.text = [NSString stringWithFormat:@"Rate:%.1f", model.rate];
    if (model.genre.count) {
        __block NSString *g = @"";
        [model.genre enumerateKeysAndObjectsUsingBlock:^(id key, NSString *name, BOOL *stop) {
            g = [[g stringByAppendingString:@" ,"]stringByAppendingString:name];
        }];
        g = [g substringFromIndex:2];
        self.genreLabel.text = g;
    }
}

@end
