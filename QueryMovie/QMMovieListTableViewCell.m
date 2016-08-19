//
//  QMMovieListTableViewCell.m
//  QueryMovie
//
//  Created by Alex Hsieh on 8/19/16.
//  Copyright © 2016 Alex Hsieh. All rights reserved.
//

#import "QMMovieListTableViewCell.h"
#import "QMMovieModel.h"

@interface QMMovieListTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabl;

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
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy"];
    self.yearLabel.text = [dateFormatter stringFromDate:model.date];
    self.ratingLabl.text = [NSString stringWithFormat:@"Rate:%.1f", model.rate];
}

@end
