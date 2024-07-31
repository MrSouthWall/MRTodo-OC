//
//  MRStartViewController.m
//  MRTodo-OC
//
//  Created by 南墙先生 on 2024/7/31.
//

#import "MRStartViewController.h"

@interface MRStartViewController ()

@end

@implementation MRStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [doneButton setFrame:CGRectMake((self.view.bounds.size.width / 2) - 100, (self.view.bounds.size.height / 2) - 50, 200, 50)];
    [doneButton setTitle:@"完成" forState:UIControlStateNormal];
    [doneButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [doneButton setBackgroundColor:UIColor.tintColor];
    doneButton.layer.cornerRadius = 10;
    doneButton.translatesAutoresizingMaskIntoConstraints = NO;
    [doneButton addTarget:self action:@selector(turnOffStartupView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:doneButton];
    
    [NSLayoutConstraint activateConstraints:@[
        [doneButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [doneButton.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-20],
        [doneButton.widthAnchor constraintEqualToConstant:self.view.bounds.size.width - 80],
        [doneButton.heightAnchor constraintEqualToConstant:50]
    ]];
    
}


// MARK: - Button

/// 关闭启动页
- (void)turnOffStartupView {
    NSLog(@"已按下完成按钮！");
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
