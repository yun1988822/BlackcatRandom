//
//  EditViewController.h
//  BlackcatKikiLo
//
//  Created by Lo Chi Yun on 2014/12/8.
//  Copyright (c) 2014年 Lo Chi Yun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditViewController : UIViewController <UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
    IBOutlet UIButton *saveBtn;
    IBOutlet UIButton *backgroundBtn;
    IBOutlet UIButton *resetBtn;
    IBOutlet UIButton *backBtn;
    IBOutlet UITextField *addNameTextField;
    IBOutlet UITextField *addNameAtIndexTextField;
    IBOutlet UITextField *deleteNameAtIndexTextField;
    IBOutlet UITextField *modifyNameTextField;
    IBOutlet UITextField *modifyNameAtIndexTextField;
    IBOutlet UIImageView *backgroundImageView;
    
    IBOutlet UIView *testView;
}
@property (strong, nonatomic) IBOutlet UIButton *saveBtn;
@property (strong, nonatomic) IBOutlet UIButton *backgroundBtn;
@property (strong, nonatomic) IBOutlet UIButton *resetBtn;
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet UITextField *addNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *addNameAtIndexTextField;
@property (strong, nonatomic) IBOutlet UITextField *deleteNameAtIndexTextField;
@property (strong, nonatomic) IBOutlet UITextField *modifyNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *modifyNameAtIndexTextField;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;

@property (strong, nonatomic) IBOutlet UIView *testView;

- (IBAction)clickSaveButton:(id)sender;
- (IBAction)clickSetBackgroundButton:(id)sender;
- (IBAction)clickResetButton:(id)sender;
- (IBAction)clickBackButton:(id)sender;

@end
