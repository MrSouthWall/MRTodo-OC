//
//  MRStartViewController.m
//  MRTodo-OC
//
//  Created by 南墙先生 on 2024/7/31.
//

#import "MRStartViewController.h"

@interface MRStartViewController ()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *previewScrollView;
@property (strong, nonatomic) UIPageControl *pageControl;

@property (strong, nonatomic) UIView *logoPreviewView;
@property (strong, nonatomic) UIView *calendarPreviewView;
@property (strong, nonatomic) UIView *todoPreviewView;
@property (strong, nonatomic) UIView *statisticPreviewView;
@property (strong, nonatomic) UIView *tomatoClockPreviewView;

@property (strong, nonatomic) UIButton *nextButton;

@end

@implementation MRStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    
    // 滚动视图
    self.previewScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height - 200)];
    self.previewScrollView.contentSize = CGSizeMake(UIScreen.mainScreen.bounds.size.width * 5, UIScreen.mainScreen.bounds.size.height - 200);
    self.previewScrollView.pagingEnabled = YES; // 设置滚动视图翻页模式
    self.previewScrollView.showsHorizontalScrollIndicator = NO; // 设置水平滚动条不可见
    self.previewScrollView.delegate = self;
    
    
    // Logo 预览图
    self.logoPreviewView = [[UIView alloc] initWithFrame:CGRectMake(UIScreen.mainScreen.bounds.size.width * 0, 0, self.previewScrollView.frame.size.width, self.previewScrollView.frame.size.height)];
    UIImageView *logoImage = [UIImageView new];
    logoImage.image = [UIImage imageNamed:@"MRTodo App Logo V1 - Light - Round"];
    logoImage.contentMode = UIViewContentModeScaleAspectFit;
    logoImage.layer.shadowColor = UIColor.labelColor.CGColor;
    logoImage.layer.shadowOffset = CGSizeMake(0, 2);
    logoImage.layer.shadowOpacity = 0.25;
    logoImage.layer.shadowRadius = 10;
//    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 150, 150) cornerRadius:35];
//    logoImage.layer.shadowPath = shadowPath.CGPath;
    logoImage.translatesAutoresizingMaskIntoConstraints = NO;
    [self.logoPreviewView addSubview:logoImage];
    [self.previewScrollView addSubview:self.logoPreviewView];
    [NSLayoutConstraint activateConstraints:@[
        [logoImage.centerXAnchor constraintEqualToAnchor:self.logoPreviewView.centerXAnchor],
        [logoImage.topAnchor constraintEqualToAnchor:self.logoPreviewView.safeAreaLayoutGuide.topAnchor constant:100],
        [logoImage.widthAnchor constraintEqualToConstant:150],
        [logoImage.heightAnchor constraintEqualToConstant:150],
    ]];

    
    // 日历预览图片视图
    self.calendarPreviewView = [[UIView alloc] initWithFrame:CGRectMake(UIScreen.mainScreen.bounds.size.width * 1, 0, self.previewScrollView.frame.size.width, self.previewScrollView.frame.size.height)];
    UIImageView *calendarPreviewImage = [UIImageView new];
    calendarPreviewImage.image = [UIImage imageNamed:@"CalendarPreview"];
    calendarPreviewImage.contentMode = UIViewContentModeScaleAspectFit;
    calendarPreviewImage.translatesAutoresizingMaskIntoConstraints = NO;
    [self.calendarPreviewView addSubview:calendarPreviewImage];
    [self.previewScrollView addSubview:self.calendarPreviewView];
    [NSLayoutConstraint activateConstraints:@[
        [calendarPreviewImage.centerXAnchor constraintEqualToAnchor:self.calendarPreviewView.centerXAnchor],
        [calendarPreviewImage.topAnchor constraintEqualToAnchor:self.calendarPreviewView.safeAreaLayoutGuide.topAnchor constant:50],
    ]];
    
    
    // 待办预览图片视图
    self.todoPreviewView = [[UIView alloc] initWithFrame:CGRectMake(UIScreen.mainScreen.bounds.size.width * 2, 0, self.previewScrollView.frame.size.width, self.previewScrollView.frame.size.height)];
    UIImageView *todoPreviewImage = [UIImageView new];
    todoPreviewImage.image = [UIImage imageNamed:@"TodoPreview"];
    todoPreviewImage.contentMode = UIViewContentModeScaleAspectFit;
    todoPreviewImage.translatesAutoresizingMaskIntoConstraints = NO;
    [self.todoPreviewView addSubview:todoPreviewImage];
    [self.previewScrollView addSubview:self.todoPreviewView];
    [NSLayoutConstraint activateConstraints:@[
        [todoPreviewImage.centerXAnchor constraintEqualToAnchor:self.todoPreviewView.centerXAnchor],
        [todoPreviewImage.topAnchor constraintEqualToAnchor:self.todoPreviewView.safeAreaLayoutGuide.topAnchor constant:50],
    ]];

    
    // 将预览滚动视图添加到整个启动页视图中
    [self.view addSubview:self.previewScrollView];
    
    
    // 下一个按钮
    self.nextButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.nextButton setFrame:CGRectMake((self.view.bounds.size.width / 2) - 100, (self.view.bounds.size.height / 2) - 50, 200, 50)];
    [self.nextButton setTitle:@"完成" forState:UIControlStateNormal];
    [self.nextButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [self.nextButton setBackgroundColor:UIColor.tintColor];
    self.nextButton.layer.cornerRadius = 10;
    self.nextButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.nextButton addTarget:self action:@selector(turnOffStartupView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.nextButton];
    [NSLayoutConstraint activateConstraints:@[
        [self.nextButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.nextButton.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:40],
        [self.nextButton.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-40],
        [self.nextButton.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-40],
        [self.nextButton.heightAnchor constraintEqualToConstant:45],
    ]];
    
    // 页面指示器
    self.pageControl = [UIPageControl new];
    self.pageControl.numberOfPages = 5;
    self.pageControl.currentPage = 0;
    self.pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    self.pageControl.pageIndicatorTintColor = UIColor.systemGray5Color;
    self.pageControl.currentPageIndicatorTintColor = UIColor.tintColor;
    [self.pageControl addTarget:self action:@selector(pageControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.pageControl];
    [NSLayoutConstraint activateConstraints:@[
        [self.pageControl.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:40],
        [self.pageControl.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-40],
        [self.pageControl.bottomAnchor constraintEqualToAnchor:self.nextButton.topAnchor constant:-40],
        [self.pageControl.heightAnchor constraintEqualToConstant:45],
    ]];

    
}


// MARK: - UIScrollViewDelegate

/// 页面滚动时执行
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 设定页面指示器当前页面的值
    NSInteger currentPage = (NSInteger)(scrollView.contentOffset.x / self.previewScrollView.frame.size.width);
    self.pageControl.currentPage = currentPage;
}


// MARK: - Button

/// 关闭启动页
- (void)turnOffStartupView {
    NSLog(@"已按下完成按钮！");
}

/// 页面指示器切换
- (void)pageControlValueChanged:(UIPageControl *)sender {
    CGFloat pageWidth = self.previewScrollView.frame.size.width;
    CGPoint offset = CGPointMake(sender.currentPage * pageWidth, 0);
    [self.previewScrollView setContentOffset:offset animated:YES];
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
