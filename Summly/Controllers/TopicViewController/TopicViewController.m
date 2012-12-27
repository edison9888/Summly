//
//  TopicViewController.m
//  Summly
//
//  Created by zzlmilk on 12-12-13.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import "TopicViewController.h"
#import "SetViewController.h"
#import "Topic.h"
#import "MainViewController.h"
#import "BundleHelp.h"

#define LeftMargin 20
#define DistanceMargin 10
#define ItemSummlyHeight 100

@interface TopicViewController ()

@end

@implementation TopicViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title =@"添加话题";
    
    
    MainViewController* m = (MainViewController*)[self.navigationController.viewControllers objectAtIndex:0];
    m.isRestUI = YES;
    
    self.view.backgroundColor=[UIColor clearColor];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    scrollView.userInteractionEnabled=YES;
    [scrollView setBackgroundColor:[UIColor clearColor]];
    //scrollView.showsVerticalScrollIndicator= YES;
    [self.view addSubview:scrollView];

    
    UIButton *_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setBackgroundImage:[UIImage imageNamed:@"navigation-button.png"] forState:UIControlStateNormal];
    [_button setImage:[UIImage imageNamed:@"navigation-bar-settings-icon.png"] forState:UIControlStateNormal];
    [_button setImageEdgeInsets:UIEdgeInsetsMake(2, 13, 4, 13)];
    [_button setFrame:CGRectMake(0, 0, 50.0f, 30.0f)];
    [_button addTarget:self action:@selector(set) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem= [[UIBarButtonItem alloc]initWithCustomView:_button];

    
    //自定义summly
    ItemSummly *addItemSummly = [[ItemSummly alloc] initWithFrame:CGRectMake(LeftMargin, 15, 280, ItemSummlyHeight)];
    addItemSummly.itemSummlyType=manageAdd;
    addItemSummly.actionDelegate=self;
    [addItemSummly setContentSize:CGSizeMake(280, ItemSummlyHeight)];
    [scrollView addSubview:addItemSummly];
    
    //产生固定topic
    for (int i=0;i< self.topicsArr.count ;i++) {
        ItemSummly *item = [[ItemSummly alloc]initWithFrame:CGRectMake(LeftMargin, addItemSummly.frame.size.height+addItemSummly.frame.origin.y+(i+1)*DistanceMargin+i*ItemSummlyHeight,280, ItemSummlyHeight)];
        item.topic = [self.topicsArr objectAtIndex:i];
        item.itemSummlyType=manage;
        item.actionDelegate =self;
        [item setContentSize:CGSizeMake(280, ItemSummlyHeight)];
        [item changeBackView:item.topic.status];
        item.tag=i;
        [scrollView addSubview:item];
    }
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, (ItemSummlyHeight+DistanceMargin)*(self.topicsArr.count+2)-30);
}



//设置
-(void)set{
    SetViewController *topViewController = [[SetViewController alloc]init];
    [self.navigationController pushViewController:topViewController animated:YES];
}

#pragma mark--
#pragma mark-- ItemSummlydelegate
-(void)ItemSummlydidTap:(ItemSummly * )itemSummly{
    if (itemSummly.itemSummlyType==manageAdd) {
        
        NSLog(@"产生新话题");
    }
    else if(itemSummly.itemSummlyType==manage){
        itemSummly.topic.status = !itemSummly.topic.status;
        BOOL isSelect = itemSummly.topic.status;
        [itemSummly changeBackView:isSelect];
        
        [self updatePlist:isSelect tag:itemSummly.tag];
    }
    
}

//更新status状态--更新plist
- (void)updatePlist:(BOOL)isSelect tag:(NSInteger)tag{

    NSDictionary *dic = [BundleHelp getDictionaryFromPlist:Plist];
    NSMutableArray *arr = [NSMutableArray arrayWithArray:[dic objectForKey:@"topics"]];
    
    NSMutableDictionary *dicManage =  [NSMutableDictionary dictionaryWithDictionary:[[arr objectAtIndex:tag] objectForKey:@"topic"]];
    [dicManage setObject:[NSNumber numberWithBool:isSelect] forKey:@"status"];
    
    [arr removeObjectAtIndex:tag];
    [arr insertObject:[NSDictionary dictionaryWithObject:dicManage forKey:@"topic"] atIndex:tag];
    NSMutableDictionary *lastDic = [NSMutableDictionary dictionaryWithObject:arr forKey:@"topics"];
    
    [lastDic writeToFile:[BundleHelp getBundlePath:Plist] atomically:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
