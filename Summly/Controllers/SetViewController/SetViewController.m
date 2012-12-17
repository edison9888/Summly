//
//  SetViewController.m
//  Summly
//
//  Created by zzlmilk on 12-12-15.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import "SetViewController.h"

@interface SetViewController ()
@property (nonatomic, strong) FAFancyMenuView *menu;
@end

@implementation SetViewController
@synthesize listTable;

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
    self.title =@"设置";
	// Do any additional setup after loading the view.
    
    UIButton *_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setBackgroundImage:[UIImage imageNamed:@"navigation-back-button.png"] forState:UIControlStateNormal];
    [_button setFrame:CGRectMake(0, 0, 50.0f, 30.0f)];
    [_button addTarget:self action:@selector(bactToTopic) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc]initWithCustomView:_button];
    
    
    
    NSArray *accountArray = [NSArray arrayWithObjects:@"Facebook", nil];
    NSArray *shareArray = [NSArray arrayWithObjects:@"共享个性化设置", nil];
    NSArray *informationArray = [NSArray arrayWithObjects:@"共享应用",@"关注@summly",@"游览该应用", nil];
    NSArray *aboutArray = [NSArray arrayWithObjects:@"观看教程",@"关于summly", nil];
    
    _countLitsDic = [NSDictionary dictionaryWithObjectsAndKeys:accountArray,@"0", shareArray,@"1", informationArray,@"2",aboutArray,@"3",nil];
    
    _keys = [[_countLitsDic allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    _nameDic = [NSDictionary dictionaryWithObjectsAndKeys:@"账户",@"0", @"",@"1", @"传递消息",@"2",@"",@"3",nil];
    
    listTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-30) style:UITableViewStyleGrouped];
    listTable.backgroundColor = [UIColor whiteColor];
    listTable.dataSource = self;
    listTable.delegate = self;
    listTable.backgroundView = nil;
    [listTable setBackgroundColor:[UIColor clearColor]];
    //[listTable setSeparatorColor:[UIColor clearColor]];
    //[listTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:listTable];
    
    
    
    //    NSArray *images = @[[UIImage imageNamed:@"petal-twitter.png"],[UIImage imageNamed:@"petal-facebook.png"],[UIImage imageNamed:@"petal-email.png"],[UIImage imageNamed:@"petal-save.png"]];
    //    self.menu = [[FAFancyMenuView alloc] init];
    //    self.menu.delegate = self;
    //    self.menu.buttonImages = images;
    //    [self.view addSubview:self.menu];
    //
}


- (void)fancyMenu:(FAFancyMenuView *)menu didSelectedButtonAtIndex:(NSUInteger)index{
    NSLog(@"%i",index);
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [_keys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *key = [_keys objectAtIndex:section];
    NSArray *nameSection = [_countLitsDic objectForKey:key];
    return [nameSection count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *SecionsTableIdentifier = @"SecionsTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SecionsTableIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SecionsTableIdentifier];
    }
    NSUInteger seciton = [indexPath section];
    NSUInteger row = [indexPath row];
    
    NSString *key = [_keys objectAtIndex:seciton];
    NSArray *nameSection = [_countLitsDic objectForKey:key];
    
    if (seciton ==0 && row == 0) {
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectMake(220, 10, 100, 28)];
        switchView.on = YES;//设置初始为ON的一边
        [switchView addTarget:self action:@selector(switchAction) forControlEvents:UIControlEventValueChanged];
        [cell addSubview:switchView];
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = [nameSection objectAtIndex:row];
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    NSString *key = [_keys objectAtIndex:section];
    
    return [_nameDic objectForKey:key];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    首先是用indexPath获取当前行的内容
    NSInteger row = [indexPath row];
    NSInteger section = [indexPath section];
    
    NSString *key = [_keys objectAtIndex:section];
    NSArray *nameSection = [_countLitsDic objectForKey:key];
    
    NSString *sting = [nameSection objectAtIndex:row];
    NSLog(@"%@",sting);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)switchAction
{
    
}


- (void)bactToTopic
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

