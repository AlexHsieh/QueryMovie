//
//  ViewController.m
//  QueryMovie
//
//  Created by Alex Hsieh on 8/18/16.
//  Copyright © 2016 Alex Hsieh. All rights reserved.
//

#import "ViewController.h"
#import "QMClient.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *baseUrlString = @"http://api.themoviedb.org/3/";
    QMClient *client = [[QMClient alloc]initWithBaseURL:[NSURL URLWithString:baseUrlString]];
    [client _taskCompletion];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
