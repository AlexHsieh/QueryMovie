//
//  QMMovieListTableViewController.m
//  QueryMovie
//
//  Created by Alex Hsieh on 8/19/16.
//  Copyright © 2016 Alex Hsieh. All rights reserved.
//

#import "QMMovieListTableViewController.h"
#import "QMFunctions.h"
#import "QMMovieListTableViewCell.h"
#import "QMMovieDetailViewController.h"

@interface QMMovieListTableViewController ()
@property (nonatomic,strong) NSArray *data;
@end

@implementation QMMovieListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QMMovieListTableViewCell *cell = (QMMovieListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    [cell setupCell:self.data[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QMMovieModel *model = self.data[indexPath.row];
    [self performSegueWithIdentifier:@"movieDetailSegueIdentifier" sender:model];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    QMMovieDetailViewController *vc = segue.destinationViewController;
    [vc setupMovieModel:sender];
}


#pragma mark - Getter

- (NSArray *)data {
    if (!_data) {
        _data = [[QMFunctions sharedInstance] getMovies];
    }
    return _data;
}

@end
