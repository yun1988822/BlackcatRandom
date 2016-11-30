//
//  CustomLabel.m
//  BlackcatKikiLo
//
//  Created by Lo Chi Yun on 2015/2/9.
//  Copyright (c) 2015年 Lo Chi Yun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomLabel.h"

@implementation CustomLabel
- (id)init {
    self = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    if (self) {
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [self setTextColor:[UIColor purpleColor]];
    [self setText:@"Hello Kiki :P"];
    [self setClipsToBounds:YES];
    [self setShadowColor:[UIColor redColor]];
    [self setShadowOffset:CGSizeMake(3, 3)];
    [self.layer setShadowRadius:5.0f];
    [self.layer setMasksToBounds:YES];
}

@end