//
//  DetailViewController.h
//  VISAcountdown
//
//  Created by hiratanaoki on 2014/11/11.
//  Copyright (c) 2014年 hiratanaoki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController{

    UILabel *_countLabel;
    
    UILocalNotification *_countNotification;
    
}

@property (nonatomic,assign) int _daycount2;

    
@end
