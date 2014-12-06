//
//  AppDelegate.m
//  VISAcountdown
//
//  Created by hiratanaoki on 2014/11/10.
//  Copyright (c) 2014年 hiratanaoki. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    UIUserNotificationType types =  UIUserNotificationTypeBadge|
    UIUserNotificationTypeSound|
    UIUserNotificationTypeAlert;
    
    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    
    [application registerUserNotificationSettings:mySettings];

//    // UIApplicationLaunchOptionsLocalNotificationKeyをキーにして、情報を取り出す
//    UILocalNotification *notification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    
    
    float osVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    if (osVersion >= 8.0f) {
        UIUserNotificationType types =  UIUserNotificationTypeBadge|
        UIUserNotificationTypeSound|
        UIUserNotificationTypeAlert;
        
        UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        
        [application registerUserNotificationSettings:mySettings];
        
        
    }
    
    return YES;
    
    

//    CGRect bounds = [[UIScreen mainScreen] bounds];
//    _window = [[UIWindow alloc] initWithFrame:bounds];

    
//    // 生成
//    UITabBarController *tab = [[UITabBarController alloc] init];
//    
    // 自身を管理しているUITabBarControllerを取得
   // self.tabBarController;
    
    // （例文１）画面（view1, view2, view3）をタブバーに追加する
//    NSArray *views = [NSArray arrayWithObjects:view1, view2, view3 nil];
    //[tbc setViewControllers:views animated:NO];
    
    // タブバーコントローラ例文
//    TabBarController *tbc = [[UITabBarController alloc] init];
//    UIView *view1 = [[UIView alloc] init];
//    UIView *view2 = [[UIView alloc] init];
//    NSArray *views = [NSArray arrayWithObjects:view1, view2, nil];
//    [self.tbc setViewControllers:views animated:NO];
//    [window addSubView:tbc.view];
//    [window makeKeyAndVisible];
    
//    UITabBarItem *tbi = [tabBarController_.tabBar.items objectAtIndex:0];
//    tbi.title = @"Main";
//    UITabBarItem *tbi2 = [tabBarController_.tabBar.items objectAtIndex:1];
//    tbi2.title = @"Setting";
//    
    
    
    return YES;
}
//
//    //window初期化
//    CGRect bounds = [[UIScreen mainScreen] bounds];
//    _window = [[UIWindow alloc] initWithFrame:bounds];
//    
//    //UITabBarController初期化
//    [self initTabBarController];
//    
//    return YES;
//}
////UITabBarController初期化
//- (void)initTabBarController
//{
//    //基点となる Controller生成
//    tabBarController_ = [[UITabBarController alloc] init];
//    
//    //タブの背景画像と選択時の背景画像を設定
//    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tab_background.png"]];
//    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"tab_selection_indicator.png"]];
//    
//    //タブメニュー選択時のビュー生成
//    UIViewController  *tabFirstVC  = [[UIViewController alloc] init];
//    UIViewController *tabSecondVC = [[UIViewController alloc] init];
//    
//    
////    //タブのアイコン指定
////    [tabFirstVC.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tab_icon1-o.png"]
////                        withFinishedUnselectedImage:[UIImage imageNamed:@"tab_icon1.png"]];
////    [tabSecondVC.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tab_icon2-o.png"]
////                         withFinishedUnselectedImage:[UIImage imageNamed:@"tab_icon2.png"]];
//    
//    //タブのタイトル指定
//    [tabFirstVC setTitle:@"First"];
//    [tabSecondVC setTitle:@"Second"];
//    
//    
//    //タブのタイトル位置設定
//    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -1)];
//    
//    //タブのタイトル色指定
//    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor,nil] forState:UIControlStateNormal];
//    
//    //タブのタイトル色指定(選択中)
//    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0.91f green:1.0f blue:0.74f alpha:1.0f], UITextAttributeTextColor,nil] forState:UIControlStateSelected];
//    
//    //ビューを Controllerに追加
//    NSArray *controllers = [NSArray arrayWithObjects:tabFirstVC, tabSecondVC, nil];
//    [(UITabBarController *)tabBarController_ setViewControllers:controllers animated:NO];
//    
//    //windowに Controllerのビュー追加
//    [_window addSubview:tabBarController_.view];
//    [_window makeKeyAndVisible];
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    
    __countNotification.applicationIconBadgeNumber = __countdownDayNumber;
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    __countNotification.applicationIconBadgeNumber = __countdownDayNumber;
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//typedef enum viewControllerIndexId : NSUInteger {
//    FIRST_ID  = 0,
//    SECOND_ID = 1,
//} viewControllerIndexId;

//タブ切り替え
- (void)switchTabBarController:(NSInteger)selectedViewIndex
{
    UITabBarController *controller = (UITabBarController *)tabBarController_;
    controller.selectedViewController = [controller.viewControllers objectAtIndex:selectedViewIndex];
}
@end
