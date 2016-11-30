//
//  ViewController.h
//  BlackcatKikiLo
//
//  Created by Lo Chi Yun on 2014/12/8.
//  Copyright (c) 2014年 Lo Chi Yun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate, UIPickerViewDelegate> {
    IBOutlet UIButton *editBtn;
    IBOutlet UIButton *startBtn;
    IBOutlet UITextField *randomTextField;
    IBOutlet UITextView *resultTextView;
    IBOutlet UIPickerView *randomPickerView;
    IBOutlet UIImageView *backgroundImageView;
}
@property (strong, nonatomic) IBOutlet UIButton *editBtn;
@property (strong, nonatomic) IBOutlet UIButton *startBtn;
@property (strong, nonatomic) IBOutlet UITextField *randomTextField;
@property (strong, nonatomic) IBOutlet UITextView *resultTextView;
@property (strong, nonatomic) IBOutlet UIPickerView *randomPickerView;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;

- (IBAction)clickEditButton:(id)sender;
- (IBAction)clickStartButton:(id)sender;

@end

