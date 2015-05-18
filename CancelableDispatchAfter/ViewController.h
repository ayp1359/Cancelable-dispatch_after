//
//  ViewController.h
//  CancelableDispatchAfter
//
//  Created by Ali Panah on 5/11/15.
//  Copyright (c) 2015 Ali Panah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (IBAction)stop:(id)sender;
- (IBAction)start:(id)sender;

@property (nonatomic) int64_t delay;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;

@end

