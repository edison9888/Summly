//
//  SetViewController.h
//  Summly
//
//  Created by zzlmilk on 12-12-15.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FAFancyMenuView.h"
#import "DDShare.h"
#import "BaseViewController.h"

@interface SetViewController : BaseViewController<FAFancyMenuViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UISwitch *WeiboSwitchView;
    UISwitch *WeixingSwitchView;
    DDShare *shareSina;
    UISwitch *switchView;
    
//    UIButton *imgTutorials1Button;
//    UIButton *imgTutorials2Button;
//    UIButton *imgTutorials3Button;
    
}
+(id)sharedInstance;

@property (nonatomic, retain) NSDictionary *countLitsDic;
@property (nonatomic, retain) NSDictionary *nameDic;
@property (nonatomic, retain) NSArray *keys;
@property (nonatomic, retain) UITableView *listTable;
@property(nonatomic,strong) NSDictionary *currentVersionArr;

@end
