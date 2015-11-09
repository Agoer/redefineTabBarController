//
//  LCTabBarController.m
//  refineTabbarController
//
//  Created by Ceres on 15/11/6.
//  Copyright © 2015年 www.upupapp.com. All rights reserved.
//

#import "LCTabBarController.h"
#import "UIAlertView+Blocks.h"
#import "MenuView.h"
#import "JKSideSlipView.h"
#import "MineUserViewController.h"
@interface LCTabBarController ()<UITabBarControllerDelegate>


@property JKSideSlipView *sideSlipView;


@end

@implementation LCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self redefineMidTabbarImages];
    
    
    _sideSlipView = [[JKSideSlipView alloc]initWithSender:self];
    _sideSlipView.backgroundColor = [UIColor redColor];
    
    MenuView *menu = [MenuView menuView];
    [menu didSelectRowAtIndexPath:^(id cell, NSIndexPath *indexPath) {
        NSLog(@"click");
        [_sideSlipView hide];
        MineUserViewController *next = [[MineUserViewController alloc]init];
        [self.navigationController pushViewController:next animated:YES];
    }];
    menu.items = @[@{@"title":@"1",@"imagename":@"1"},@{@"title":@"2",@"imagename":@"2"},@{@"title":@"3",@"imagename":@"3"},@{@"title":@"4",@"imagename":@"4"}];
    [_sideSlipView setContentView:menu];
    [self.view addSubview:_sideSlipView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(leftSideButtonPressed:) name:@"leftSideButtonPressed" object:nil];
    
    // Do any additional setup after loading the view.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"leftSideButtonPressed" object:nil];
}

- (void)leftSideButtonPressed:(id)sender
{
     [_sideSlipView switchMenu];
}

//自定义mid tabbar image
- (void)redefineMidTabbarImages
{
    UIImage *midImage = [UIImage imageNamed:@"mid"];
    [self.tabBar.items enumerateObjectsUsingBlock:^(UITabBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        //寻找到中间的tabbar
        UITabBarItem *item = obj;
        if (idx == 2) {
            item.image = [midImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];  // 去掉系统对 tabbar 的填充色 蓝色 和灰色
            item.selectedImage = [midImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            item.imageInsets = UIEdgeInsetsMake(5.0, 0, -5.0, 0);
        }
        
    }];
    
//    self.tabBar.tintColor = [UIColor colorWithRed:255.0/255 green:225/255.0 blue:17/255.0 alpha:1.0];
    self.delegate = self;
    
}

#pragma mark- UITabBarControllerDelegate methods

//去掉对 mid tabbar的选中态
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    NSArray * controllers = self.viewControllers;
    NSInteger index = [controllers indexOfObject:viewController];
    if (index == 2) {
        return NO;
    }
    return true;
}

#pragma mark- UITabBarControllerDelegate END

//继承父类方法，
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    //重写父类方法的 mid index
    NSInteger index = [tabBar.items indexOfObject:item];
    
    if (index == 2) {
        
        [UIAlertView showWithTitle:@"点击了 mid image" message:nil cancelButtonTitle:@"ok" otherButtonTitles:nil tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
            
        }];
        //对父类方法 tabbar = 2 进行出来
        
        
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
