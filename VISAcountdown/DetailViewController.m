//
//  DetailViewController.m
//  VISAcountdown
//
//  Created by hiratanaoki on 2014/11/11.
//  Copyright (c) 2014年 hiratanaoki. All rights reserved.
//

#import "DetailViewController.h"
#import "ViewController.h"
@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self countLabel];
    
    [self countBudge];
    //_countNotification.applicationIconBadgeNumber = self._daycount2;
    
}
-(void)countLabel{
    _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(0 ,160 ,self.view.bounds.size.width, 60)];
    
    _countLabel.font = [UIFont systemFontOfSize:36];
    _countLabel.textAlignment = NSTextAlignmentCenter;
    
    NSString *daycount = [NSString stringWithFormat:@"残り%d日", self._daycount2];
    
    _countLabel.text = daycount;
    [self.view addSubview:_countLabel];
}
//UILocalNotification *localNotification = [[UILocalNotification alloc] init];
//
//localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:10];
//localNotification.alertBody = @"10秒経過した";
//
//localNotification.applicationIconBadgeNumber = 1;
//
//
//localNotification.timeZone = [NSTimeZone defaultTimeZone];
//[[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
-(void)countBudge{
    _countNotification = [[UILocalNotification alloc] init];
    
    
    _countNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:1];
    _countNotification.alertBody = @"visa";
    _countNotification.applicationIconBadgeNumber = self._daycount2;
    _countNotification.timeZone = [NSTimeZone defaultTimeZone];
    [[UIApplication sharedApplication] scheduleLocalNotification:_countNotification];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
