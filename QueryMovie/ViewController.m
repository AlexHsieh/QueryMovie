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
#import "MBProgressHUD.h"
#import "QMFunctions.h"

@interface ViewController ()<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *movieTitleTextField;
@property (weak, nonatomic) IBOutlet UITextField *yearTextField;

@property (strong,nonatomic) UIPickerView *picker;

/** year from 1960 to now
 */
@property (strong,nonatomic) NSArray *years;

@end

@implementation ViewController

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
    return self.years.count;
}
- (NSString *)pickerView:(UIPickerView *)thePickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.years[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self.yearTextField setText:self.years[row]];
}


#pragma mark - Action

- (IBAction)searchButtonClicked:(id)sender {

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self disbaleAllInterface];
    [self searchWithCompletion:^(BOOL success, NSError *error) {
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


- (NSArray *)years {
    if (!_years) {
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy"];
        int cy  = [[formatter stringFromDate:[NSDate date]] intValue];
        
        NSMutableArray *arr = [NSMutableArray array];
        for (int i=1960; i<=cy; i++) {
            [arr addObject:[NSString stringWithFormat:@"%d",i]];
        }
        _years = arr.copy;
    }
    return _years;
}

- (void)searchWithCompletion:(void (^)(BOOL success, NSError *error))completion {
    
    
}


@end
