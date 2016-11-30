//
//  ViewController.m
//  BlackcatKikiLo
//
//  Created by Lo Chi Yun on 2014/12/8.
//  Copyright (c) 2014年 Lo Chi Yun. All rights reserved.
//

#import "ViewController.h"
#import "CustomLabel.h"

@interface ViewController () {
    NSMutableArray *peopleArray;
    NSMutableArray *copyPeopleArray;
    NSMutableArray *resultArray;
}

@end

@implementation ViewController
@synthesize editBtn;
@synthesize startBtn;
@synthesize randomTextField;
@synthesize resultTextView;
@synthesize randomPickerView;
@synthesize backgroundImageView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // randomTextField
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(touchDoneButtonUpInside)];
    UIBarButtonItem *flexableItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:NULL];
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44.0f)];
    [toolbar setItems:[NSArray arrayWithObjects:flexableItem,doneItem, nil]];
    [self.randomTextField setInputAccessoryView:toolbar];
    [self.randomTextField setDelegate:self];
    
    // randomPickerView
    [self.randomPickerView setDelegate:self];
    
    // NSMutableArray
    peopleArray = [[NSMutableArray alloc] init];
    copyPeopleArray = [[NSMutableArray alloc] init];
    resultArray = [[NSMutableArray alloc] init];
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
    
    // randomPickerView
    [randomPickerView reloadAllComponents];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions
- (IBAction)clickEditButton:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"EditViewController"];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)clickStartButton:(id)sender {
    [self.resultTextView setText:@""];
    if ([resultArray count] > 0) {
        [resultArray removeAllObjects];
    }
    copyPeopleArray = [NSMutableArray arrayWithArray:peopleArray];
    
    int number;
    for (int i = 0; i < randomTextField.text.integerValue; i++) {
        number = rand() % [copyPeopleArray count];
        [resultArray addObject:[copyPeopleArray objectAtIndex:number]];
//        NSLog(@"index:%d name:%@", number, [copyPeopleArray objectAtIndex:number]);
        [copyPeopleArray removeObjectAtIndex:number];
    }
    
    [self.resultTextView setText:[resultArray componentsJoinedByString:@"\n"]];
    [self.resultTextView.layer setMasksToBounds:YES];
    [self.resultTextView.layer setShadowRadius:5.0f];
}

#pragma mark - Other methods
- (void)touchDoneButtonUpInside {
    if ([[self.randomTextField text] integerValue] > [peopleArray count]) {
        return;
    }
    [self.randomTextField resignFirstResponder];
}

#pragma mark - UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (peopleArray != nil) {
        return [peopleArray count];
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (peopleArray != nil) {
        return [peopleArray objectAtIndex:row];
    }
    return @"";
}

@end
