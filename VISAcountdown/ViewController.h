//
//  ViewController.h
//  VISAcountdown
//
//  Created by hiratanaoki on 2014/11/10.
//  Copyright (c) 2014年 hiratanaoki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
@interface ViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,UIAlertViewDelegate,ADBannerViewDelegate>{
    
//    UILabel *_myLabelInput; //入力された文字を表示する
    UILabel *_countryLabel; //選択された国名を表示する
    UILabel *_purposeLabel; //選択された目的を表示する
    UILabel *_periodLabel; //選択された期間を表示する
    UILabel *_dateLabel;    //日程のラベルを表示する
    int _int;  //データを送る
    UIView *_uv;

    UIView *_backView;  //水色のビュー用メンバ変数
    UIView *_backdateView;  //datepcker用のbackview
    BOOL _visibleFlag;  //水色のビューが表示されている:YES 非表示:NO
    
  //  UIButton *_CheckButton;    //金額チェックボタンを作成する
   // UIButton *_CancelButton;    //キャンセルボタンを作成する
   // UIButton *_dateButton;    //登録完了ボタンを作成する
   // UIButton *_countryButton;   //国名を選ぶボタン
   // UIButton *_purposeButton;   //目的を選ぶボタン
   // UIButton *_periodButton;    //期間を選ぶボタン
   // UIButton *_createButton;    //addSubView内の完了ボタン(PickerView)
    //UIButton *_datecreateButton;//addSubView内の完了ボタン(DatePicker)
    //UIButton *_setButton;       //設定を完了するボタン
    
    
    UIPickerView *_PickerView;  //選択項目を表示
    
    NSArray *_country;  //国名の連想配列
    NSArray *_period;   //期間の連想配列
    NSArray *_period_for_compare;//期間のPList検索型の連想配列
    NSArray *_purpose;  //目的の連想配列
    
    NSArray *_PListArray;   //取り出したplistを入れた連想配列
    NSBundle *_bundle;  //プロジェクト内のファイルにアクセス出来るオブジェクトを宣言
    NSString *_path;    //読み込むプロパティリストのファイルパス（場所）(名前)を指定
    NSDictionary *_dic; //プロパティリストの中身のデータを取得
    
    UILabel *_checkLabel;   //料金を表示するラベル
    
    int _valcountry;
    int _valpurpose;
    int _valperiod;
    
    UIDatePicker *_datepicker;
    NSDate *_mindate;   //
    NSDateFormatter *_df;   //日にちの表示の書式を設定
    NSDate *_today;         //今日の日付を呼び出す
 //   NSString *_datestr;
    NSString *_lastdatestr;
    //int _dayCount;  //残り日数の計算
    NSDate *_departdate1;
    
    UIAlertView *_alertview;
    UIAlertView *_alertview2;
    UIAlertView *_alertview3;
    
    //広告
    ADBannerView *_adView;
    BOOL _isVisible; //バナーの表示状態を判別するためのフラグ
    
    int _countdownDayNumber;
    NSDate *_finishdate;        //延長日
    int _daycountoffirstadition; //国ごとの追加日数
    
    int _justday;   //DatePickerを使用した時を見分けるよう
}

//@property (nonatomic,assign) UILocalNotification* _countNotification;
//@property (nonatomic,assign) int _countdownDayNumber;
@property (nonatomic,assign) int _number1;

@end

