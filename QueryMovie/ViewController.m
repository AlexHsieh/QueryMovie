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
#import "ViewControllerViewModel.h"
#import "MBProgressHUD.h"

@interface ViewController ()<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *movieTitleTextField;
@property (weak, nonatomic) IBOutlet UITextField *yearTextField;

@property (strong,nonatomic) ViewControllerViewModel *viewModel;
@property (strong,nonatomic) UIPickerView *picker;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialSetup];
    
//    NSString *baseUrlString = @"http://api.themoviedb.org/3/";
//    QMClient *client = [[QMClient alloc]initWithBaseURL:[NSURL URLWithString:baseUrlString]];
//    QMRequestModel *rm = [[QMRequestModel alloc]init];
//    rm.query = @"ring";
//    rm.page = @"1";
//    [client search:rm];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initialSetup {
    [self.movieTitleTextField becomeFirstResponder];
    
    self.yearTextField.inputView = self.picker;
    
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
    return self.viewModel.years.count;
}
- (NSString *)pickerView:(UIPickerView *)thePickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.viewModel.years[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self.yearTextField setText:self.viewModel.years[row]];
}


#pragma mark - Action

- (IBAction)searchButtonClicked:(id)sender {

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self disbaleAllInterface];
    [self.viewModel searchWithCompletion:^(BOOL success, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self enableAllInterface];
    }];
}

- (void)disbaleAllInterface {
    [self.view endEditing:YES];
    self.view.userInteractionEnabled = NO;
}

- (void)enableAllInterface {
    self.view.userInteractionEnabled = YES;
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

- (ViewControllerViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ViewControllerViewModel alloc]init];
    }
    return _viewModel;
}

@end
