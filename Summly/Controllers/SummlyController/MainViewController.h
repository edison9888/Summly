//
//  MainViewController.h
//  Summly
//
//  Created by zzlmilk on 12-12-9.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainSummlyView.h"
#import "BaseViewController.h"

@interface MainViewController :BaseViewController<UINavigationControllerDelegate>
{
    MainSummlyView *mainSummlyView;

}

@property(nonatomic,strong) NSArray *topicsArr;
@property(nonatomic)BOOL isRestUI;
@end
