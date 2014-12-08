//
//  DetailViewController.h
//  VISAcountdown
//
//  Created by hiratanaoki on 2014/11/11.
//  Copyright (c) 2014年 hiratanaoki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
@interface DetailViewController : UIViewController<ADBannerViewDelegate>{


    UILabel *_countLabel;   //残り日数表示
    
    UILocalNotification *_countNotification;
    
    UIButton *_extendButton;    //延長完了ボタン
    
    NSDateFormatter *_df;   //日にちの表示の書式を設定
    NSDate *_today;         //今日の日付を呼び出す
    NSString *_datestr;     //書式の設定

    //NSDate *_
    
    int _daycount3;//日にち計算
    
    //広告
    ADBannerView *_adView;
    BOOL _isVisible; //バナーの表示状態を判別するためのフラグ
    
    NSDateComponents *_def1;
    int _countdownDayNumber;
}

@property (nonatomic,assign) int _daycount2;
//@property (nonatomic,assign) NSDate *_departdate;
@property (nonatomic,assign) NSDate *_finishdate1;

    
@end
