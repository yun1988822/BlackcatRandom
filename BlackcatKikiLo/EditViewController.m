//
//  EditViewController.m
//  BlackcatKikiLo
//
//  Created by Lo Chi Yun on 2014/12/8.
//  Copyright (c) 2014年 Lo Chi Yun. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController () {
    NSMutableArray *peopleArray;
    NSInteger textFieldNumber;
    UIAlertView *messageAlertView;
    UIAlertView *resetAlertView;
    UIImagePickerController *imagePickerController;
}

- (void)touchDoneButtonUpInside;

@end

@implementation EditViewController
@synthesize saveBtn;
@synthesize backgroundBtn;
@synthesize resetBtn;
@synthesize backBtn;
@synthesize addNameTextField;
@synthesize addNameAtIndexTextField;
@synthesize modifyNameTextField;
@synthesize modifyNameAtIndexTextField;
@synthesize deleteNameAtIndexTextField;
@synthesize backgroundImageView;

@synthesize testView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // UITextField
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(touchDoneButtonUpInside)];
    UIBarButtonItem *flexableItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44.0f)];
    [toolbar setItems:[NSArray arrayWithObjects:flexableItem,doneItem, nil]];
    
    [self.addNameAtIndexTextField setInputAccessoryView:toolbar];
    [self.deleteNameAtIndexTextField setInputAccessoryView:toolbar];
    [self.modifyNameAtIndexTextField setInputAccessoryView:toolbar];
    
    [self.addNameTextField setDelegate:self];
    [self.addNameAtIndexTextField setDelegate:self];
    [self.deleteNameAtIndexTextField setDelegate:self];
    [self.modifyNameTextField setDelegate:self];
    [self.modifyNameAtIndexTextField setDelegate:self];
    
    // peopleArray
    peopleArray = [[NSMutableArray alloc] init];
    
    // UIAlertView
    messageAlertView = [[UIAlertView alloc] initWithTitle:@"Warning" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    resetAlertView = [[UIAlertView alloc] initWithTitle:@"Restored all values" message:@"are you sure?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
    
    // imagePickerController
    imagePickerController = [[UIImagePickerController alloc] init];
    [imagePickerController setAllowsEditing:YES];
    [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [imagePickerController setDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSData *data;
    
    // peopleArray
    if ([peopleArray count] > 0) {
        [peopleArray removeAllObjects];
    }
    
    data = [[NSUserDefaults standardUserDefaults] objectForKey:@"peopleList"];
    if (data) {
        [peopleArray addObjectsFromArray:(NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithData:data]];
    }
    else {
        [peopleArray addObject:@"Fans 01"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"peopleList"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    // textFieldNumber
    textFieldNumber = 0;
    
    // backgroundImageView
    data = [[NSUserDefaults standardUserDefaults] dataForKey:@"background"];
    if (data) {
        NSDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        UIImage *img = [dic objectForKey:UIImagePickerControllerOriginalImage];
        [self.backgroundImageView setImage:img];
    }
    else {
        [self.backgroundImageView setImage:[UIImage imageNamed:@"Background.png"]];
    }
    
    // Test
//    [self.view addSubview:testView];
//    NSLog(@"self.vew superview:%@", [self.view superview]);
//    NSLog(@"self.view subviews:%@", [self.view subviews]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions
- (IBAction)clickSaveButton:(id)sender {
    UIButton *btn = sender;
    BOOL bShowMessage = NO;
    if (btn.tag == 1) {
        if ([addNameAtIndexTextField.text length] > 0) {
            if ([addNameTextField.text length] > 0) {
                if (addNameAtIndexTextField.text.integerValue >= [peopleArray count]) { // Add object directly
                    [peopleArray addObject:addNameTextField.text];
                }
                else { // Insert object at index
                    [peopleArray insertObject:addNameTextField.text atIndex:(addNameAtIndexTextField.text.integerValue -1)];
                }
            }
            else {
                [messageAlertView setMessage:@"The name field is nil."];
                bShowMessage = YES;
            }
        }
        else { // Add object directly
            if ([addNameTextField.text length] > 0) {
                [peopleArray addObject:addNameTextField.text];
            }
            else {
                [messageAlertView setMessage:@"The name field is nil."];
                bShowMessage = YES;
            }
        }
    }
    else if (btn.tag == 2) {
        if ([deleteNameAtIndexTextField.text length] > 0) {
            if (deleteNameAtIndexTextField.text.integerValue >= [peopleArray count]) {
                [messageAlertView setMessage:@"The name index is invaild."];
                bShowMessage = YES;
            }
            else {
                [peopleArray removeObjectAtIndex:deleteNameAtIndexTextField.text.integerValue];
            }
        }
        else {
            [messageAlertView setMessage:@"The name index is nil."];
            bShowMessage = YES;
        }
    
    }
    else if (btn.tag == 3) {
        if ([modifyNameTextField.text length] > 0) {
            if ([modifyNameAtIndexTextField.text length] > 0) {
                if (modifyNameAtIndexTextField.text.integerValue >= [peopleArray count]) {
                    [messageAlertView setMessage:@"The replace index is invaild."];
                    bShowMessage = YES;
                }
                else {
                    [peopleArray replaceObjectAtIndex:modifyNameAtIndexTextField.text.integerValue withObject:modifyNameTextField.text];
                }
            }
            else {
                [messageAlertView setMessage:@"The replace index is nil."];
                bShowMessage = YES;
            }
        }
        else {
            [messageAlertView setMessage:@"The name field is nil."];
            bShowMessage = YES;
        }
    }
    
    if (bShowMessage) {
        [messageAlertView show];
    }
    else { // Save peopleArray
        [self.addNameTextField setText:@""];
        [self.addNameAtIndexTextField setText:@""];
        [self.deleteNameAtIndexTextField setText:@""];
        [self.modifyNameTextField setText:@""];
        [self.modifyNameAtIndexTextField setText:@""];
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:peopleArray];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"peopleList"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (IBAction)clickSetBackgroundButton:(id)sender {
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (IBAction)clickResetButton:(id)sender {
    [resetAlertView show];
}

- (IBAction)clickBackButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextField Delegates
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == addNameAtIndexTextField) {
        textFieldNumber = 1;
    }
    else if (textField == deleteNameAtIndexTextField) {
        textFieldNumber = 2;
    }
    else if (textField == modifyNameAtIndexTextField) {
        textFieldNumber = 3;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UIAlertView Delegates
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView == resetAlertView) {
        if (buttonIndex != [resetAlertView cancelButtonIndex]) {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"peopleList"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"background"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self clickBackButton:nil];
        }
    }
}

#pragma mark - UIImagePickerController Delegates
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.backgroundImageView setImage:img];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:info];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"background"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Other methods
- (void)touchDoneButtonUpInside {
    switch (textFieldNumber) {
        case 1:
            [self.addNameAtIndexTextField resignFirstResponder];
            break;
        case 2:
            [self.deleteNameAtIndexTextField resignFirstResponder];
            break;
        case 3:
            [self.modifyNameAtIndexTextField resignFirstResponder];
            break;
        default:
            break;
    }
}

@end