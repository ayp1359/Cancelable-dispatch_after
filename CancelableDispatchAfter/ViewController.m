//
//  ViewController.m
//  CancelableDispatchAfter
//
//  Created by Ali Panah on 5/11/15.
//  Copyright (c) 2015 Ali Panah. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
  BOOL *cancelPtr;
  int timeCounter;
  NSTimer *timer;
}
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.textLabel.text = @"";
  self.delay = 3;
  timeCounter = 0;
  self.stopButton.enabled = NO;
  self.stopButton.alpha = 0.3;
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (IBAction)stop:(id)sender {
  
  if(cancelPtr){
    *cancelPtr = YES;
    self.textLabel.text = @"Stopped block; did not run.";
    [timer invalidate];
    timer = nil;
    timeCounter = 0;
    self.stopButton.enabled = NO;
    self.stopButton.alpha = 0.3;
    self.startButton.enabled = YES;
    self.startButton.alpha = 1.0;
  }
  
}

- (IBAction)start:(id)sender {
  
  self.startButton.enabled = NO;
  self.startButton.alpha = 0.3;
  
  self.stopButton.enabled = YES;
  self.stopButton.alpha = 1.0;
  
  __block BOOL cancelled = NO;
  
  int64_t delay = self.delay;
  dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, delay*NSEC_PER_SEC);
  dispatch_queue_t queue = dispatch_get_main_queue();
  dispatch_block_t block = ^{
    if(!cancelled){
      self.textLabel.text = @"Too late to stop; ran block.";
      self.stopButton.enabled = NO;
      self.stopButton.alpha = 0.3;
      self.startButton.enabled = YES;
      self.startButton.alpha = 1.0;
      [timer invalidate];
      timer = nil;
      timeCounter = 0;
    }
  };
  
  dispatch_after(time, queue, block);
  
  cancelPtr = &cancelled;
  
  self.textLabel.text = [NSString stringWithFormat:@"Will dispatch in %lld seconds...",self.delay-timeCounter];
  timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(onTick:) userInfo:nil repeats:YES];
  
}

- (void)onTick:(NSTimer *)timer{
  timeCounter++;
  self.textLabel.text = [NSString stringWithFormat:@"Will dispatch in %lld seconds...",self.delay-timeCounter];
}


@end
