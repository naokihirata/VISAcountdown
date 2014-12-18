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
    UILabel *_finishdatelabel;  //最終日の表示
    UILabel *_countlabel2;          //帰国予定日までのカウントダウンを表示
    UILabel *_willreturndatelabel;  //帰国予定日の表示
    UILabel *_countrylabel;     //選択された国名を表示
    UILabel *_weblabel;
    
    UILocalNotification *_countNotification;
    
    
    UIView *_uv;
    UIButton *_extendButton;
    UIButton *_extendButton2;
    UIButton *_extendButton3;
    UIButton *_extendButton29;
    UIButton *_extendButton6;
    
    UIView *_backview;
    UIWebView *_webview;
 //   UIButton *_extendButton;    //延長完了ボタン
    
    NSDateFormatter *_df;   //日にちの表示の書式を設定
    NSDate *_today;         //今日の日付を呼び出す
  //  NSString *_datestr;     //書式の設定

    //NSDate *_
    
  //  int _daycount3;//日にち計算
    NSArray *_country;  //国名の連想配列
    //広告
    ADBannerView *_adView;
    BOOL _isVisible; //バナーの表示状態を判別するためのフラグ
    
  //  NSDateComponents *_def1;
    int _countdownDayNumber;    //日付の差分
    
    int _daycountoffirstadition; //ボタンによる期間の延長
    
    int _number;    
}

@property (nonatomic,assign) int _daycount2;
//@property (nonatomic,assign) NSDate *_departdate;
@property (nonatomic,assign) NSDate *_finishdate1;
@property (nonatomic,assign) UISwitch *_switch2;
    
@end
