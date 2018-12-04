//
//  ViewController.m
//  我的频道
//
//  Created by cctv-person on 2018/12/3.
//  Copyright © 2018 cctv-person. All rights reserved.
//

#import "ViewController.h"
#import "CommonViewController.h"
#import "TXSPViewController.h"
#import "ToutiaoViewController.h"
#import "YoukuViewController.h"
static NSString *reuser = @"tableviewReuser";

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic , strong) UITableView *tableview;
@property (nonatomic , strong) NSArray *controllerArray;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableview = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:reuser];
    [self.view addSubview:self.tableview];
    self.controllerArray = @[[[CommonViewController alloc]initWithTitle:@"普通样式"],
                             [[TXSPViewController alloc]initWithTitle:@"类似腾讯"],
                             [[ToutiaoViewController alloc]initWithTitle:@"类似头条"],
                             [[YoukuViewController alloc]initWithTitle:@"类似优酷"]];
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.controllerArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = self.controllerArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuser forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuser];
    }
    UIViewController *viewcontrol = self.controllerArray[indexPath.row];
    cell.textLabel.text = viewcontrol.title;
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
