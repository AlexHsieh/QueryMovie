//
//  ViewController.m
//  QueryMovie
//
//  Created by Alex Hsieh on 8/18/16.
//  Copyright © 2016 Alex Hsieh. All rights reserved.
//

#import "ViewController.h"
#import "QMClient.h"
#import "QMRequestModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *baseUrlString = @"http://api.themoviedb.org/3/";
    QMClient *client = [[QMClient alloc]initWithBaseURL:[NSURL URLWithString:baseUrlString]];
    QMRequestModel *rm = [[QMRequestModel alloc]init];
    rm.query = @"ring";
    rm.page = @"1";
    [client search:rm];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
