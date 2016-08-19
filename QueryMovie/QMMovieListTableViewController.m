//
//  QMMovieListTableViewController.m
//  QueryMovie
//
//  Created by Alex Hsieh on 8/19/16.
//  Copyright © 2016 Alex Hsieh. All rights reserved.
//

#import "QMMovieListTableViewController.h"
#import "QMMovieModel.h"

@interface QMMovieListTableViewController()
@property (nonatomic,strong) NSArray *data;
@end

@implementation QMMovieListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Just use static cell ..
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentfiier"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellIdentfiier"];
    }
    
    cell.textLabel.text = @"This is title";
    cell.detailTextLabel.text = @"This is rating";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
