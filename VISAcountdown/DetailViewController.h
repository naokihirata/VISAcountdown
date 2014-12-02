//
//  DetailViewController.h
//  VISAcountdown
//
//  Created by hiratanaoki on 2014/11/11.
//  Copyright (c) 2014年 hiratanaoki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController{

    
    
    UILabel *_countLabel;   //残り日数表示
    
    UILocalNotification *_countNotification;
    
    UIButton *_extendButton;    //延長完了ボタン
    
    NSDateFormatter *_df;   //日にちの表示の書式を設定
    NSDate *_today;         //今日の日付を呼び出す
    NSString *_datestr;     //書式の設定

    //NSDate *_
    
    int _daycount3;//日にち計算
    
}

//@property (nonatomic,assign) int _daycount2;
@property (nonatomic,assign) NSDate *_departdate;

    
@end
