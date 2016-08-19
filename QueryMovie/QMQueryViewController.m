//
//  QMQueryViewController.m
//  QueryMovie
//
//  Created by Alex Hsieh on 8/18/16.
//  Copyright © 2016 Alex Hsieh. All rights reserved.
//

#import "QMQueryViewController.h"
#import "QMClient.h"
#import "QMRequestModel.h"
#import "MBProgressHUD.h"
#import "QMFunctions.h"
#import "NSDate+NSString.h"

@interface QMQueryViewController ()<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *movieTitleTextField;
@property (weak, nonatomic) IBOutlet UITextField *yearTextField;
@property (weak, nonatomic) IBOutlet UITextField *genreTextField;

@property (strong,nonatomic) UIPickerView *picker;
@property (strong,nonatomic) UIPickerView *genrePicker;
@property (nonatomic) BOOL isLoading;

/** year from 1961 to now
 */
@property (strong,nonatomic) NSArray *years;

/** genre type array
 */
@property (strong,nonatomic) NSArray *genres;

@end

@implementation QMQueryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialSetup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initialSetup {
    [self.movieTitleTextField becomeFirstResponder];
    self.movieTitleTextField.clearButtonMode = UITextFieldViewModeAlways;
    self.yearTextField.inputView = self.picker;
    self.yearTextField.clearButtonMode = UITextFieldViewModeAlways;
    self.genreTextField.inputView = self.genrePicker;
    self.genreTextField.clearButtonMode = UITextFieldViewModeAlways;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == _movieTitleTextField) {
        [self.yearTextField becomeFirstResponder];
    } else {
        //search
    }
    return NO;
}


#pragma mark - picker delegate

- (NSInteger)numberOfComponentsInPickerView: (UIPickerView*)thePickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component
{
    return thePickerView == self.picker ? self.years.count : self.genres.count;
}
- (NSString *)pickerView:(UIPickerView *)thePickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return thePickerView == self.picker ? self.years[row] : self.genres[row][@"name"];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pickerView == self.picker) {
        [self.yearTextField setText:self.years[row]];
    } else {
        [self.genreTextField setText:self.genres[row][@"name"]];
    }
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //should do compare segue identifier here. Since only one segue. just skip..
    
}

#pragma mark - Action

- (IBAction)searchButtonClicked:(id)sender {

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self disbaleAllInterface];
    self.isLoading = YES;
    
    QMRequestModel *rm = [[QMRequestModel alloc]init];
    rm.query = self.movieTitleTextField.text?:@"";
    rm.page = @"1";
    rm.year = self.yearTextField.text?:nil;
    rm.genre = [self getGenreIdFromString:self.genreTextField.text]?:nil;
    rm.sortBy = @"vote_average.asc";
    rm.voteCountGreat = @"100";
    
    [[QMFunctions sharedInstance] queryMovieFromCacheThenNetwork:rm completion:^(BOOL isSuccess, NSError *error){
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self enableAllInterface];
        if (isSuccess && self.isLoading) {
            self.isLoading = NO;
            [self performSegueWithIdentifier:@"movieListViewSegueIdentifier" sender:self];
        }
    }];
    
}

- (void)disbaleAllInterface {
    [self.view endEditing:YES];
    self.view.userInteractionEnabled = NO;
}

- (void)enableAllInterface {
    self.view.userInteractionEnabled = YES;
}

- (NSString *)getGenreIdFromString:(NSString *)name {
    for (NSDictionary *dic in self.genres) {
        if ([name isEqualToString:dic[@"name"]]) {
            return dic[@"id"];
        }
    }
    return nil;
}

#pragma mark - getter & setter

- (UIPickerView *)picker {
    if (!_picker) {
        UIPickerView *picker = [[UIPickerView alloc]init];
        picker.delegate = self;
        _picker = picker;
    }
    return _picker;
}

- (UIPickerView *)genrePicker {
    if (!_genrePicker) {
        UIPickerView *picker = [[UIPickerView alloc]init];
        picker.delegate = self;
        _genrePicker = picker;
    }
    return _genrePicker;
}

- (NSArray *)years {
    if (!_years) {
        int cy  = [[NSDate fromDateToYear:[NSDate date]] intValue];
        
        NSMutableArray *arr = [NSMutableArray array];
        for (int i=cy; i>1960; i--) {
            [arr addObject:[NSString stringWithFormat:@"%d",i]];
        }
        _years = arr.copy;
    }
    return _years;
}

- (NSArray *)genres {
    if (!_genres) {
        NSMutableArray *arr = [NSMutableArray array];
        [[[QMFunctions sharedInstance]genreType] enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *name, BOOL *stop) {
            [arr addObject:@{@"id":key,@"name":name}];
        }];
        _genres = arr.copy;
    }
    return _genres;
}

@end
