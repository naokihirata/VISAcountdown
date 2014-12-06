//
//  AppDelegate.h
//  VISAcountdown
//
//  Created by hiratanaoki on 2014/11/10.
//  Copyright (c) 2014年 hiratanaoki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "DetailViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>{


    UITabBarController *tabBarController_;
}


@property (strong, nonatomic) UIWindow *window;


@property (nonatomic,assign) UILocalNotification* _countNotification;
@property (nonatomic,assign) int _countdownDayNumber;

- (void)switchTabBarController:(NSInteger)selectedViewIndex;
@end

