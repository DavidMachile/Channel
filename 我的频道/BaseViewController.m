//
//  BaseViewController.m
//  我的频道
//
//  Created by cctv-person on 2018/12/3.
//  Copyright © 2018 cctv-person. All rights reserved.
//

#import "BaseViewController.h"

//#define KScreenWidth [UIScreen mainScreen].bounds.size.width
//#define rowNum 5
@interface BaseViewController ()
@end

@implementation BaseViewController

- (instancetype)initWithTitle:(NSString *)title{
    if (self) {
        self.title = title;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    // Do any additional setup after loading the view.
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
