//
//  MRStartViewController.m
//  MRTodo-OC
//
//  Created by 南墙先生 on 2024/7/31.
//

#import "MRStartViewController.h"
#import "../SceneDelegate.h"
#import "SubView/MRStartSinglePreviewView.h"

@interface MRStartViewController ()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *previewScrollView;
@property (strong, nonatomic) UIPageControl *pageControl;

@property (strong, nonatomic) UIView *logoPreviewView;
@property (strong, nonatomic) UIImageView *logoImage;

@property (strong, nonatomic) UIView *calendarPreviewView;
@property (strong, nonatomic) UIView *todoPreviewView;
@property (strong, nonatomic) UIView *statisticPreviewView;
@property (strong, nonatomic) UIView *tomatoClockPreviewView;

@property (strong, nonatomic) UIButton *nextButton;
@property (nonatomic) float currentPageNumber;

@end

@implementation MRStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.currentPageNumber = 0;
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    
    // 滚动视图
    self.previewScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height - 225)];
    self.previewScrollView.contentSize = CGSizeMake(UIScreen.mainScreen.bounds.size.width * 5, UIScreen.mainScreen.bounds.size.height - 225);
    self.previewScrollView.pagingEnabled = YES; // 设置滚动视图翻页模式
    self.previewScrollView.showsHorizontalScrollIndicator = NO; // 设置水平滚动条不可见
    self.previewScrollView.delegate = self;
    
    
    // Logo 预览图
    self.logoPreviewView = [[MRStartSinglePreviewView alloc] initWithImage:@"MRTodo App Logo V1 - 1024x1024 - Light - RoundShadow" withTitle:@"欢迎使用“MRTodo”" withText:nil withCurrentPageNumber:0 withType:MRStartSinglePreviewViewStyleAppIcon];
    [self.previewScrollView addSubview:self.logoPreviewView];
    
    // 日历预览图片视图
    self.calendarPreviewView = [[MRStartSinglePreviewView alloc] initWithImage:@"CalendarPreview" withTitle:@"日历日程" withText:@"管理并查看你的日程安排和重要事件。" withCurrentPageNumber:1 withType:MRStartSinglePreviewViewStyleDefault];
    [self.previewScrollView addSubview:self.calendarPreviewView];
    
    // 待办预览图片视图
    self.todoPreviewView = [[MRStartSinglePreviewView alloc] initWithImage:@"TodoPreview" withTitle:@"待办事项" withText:@"创建、追踪和完成你的任务清单。" withCurrentPageNumber:2 withType:MRStartSinglePreviewViewStyleDefault];
    [self.previewScrollView addSubview:self.todoPreviewView];
    
    // 统计预览图片视图
    self.statisticPreviewView = [[MRStartSinglePreviewView alloc] initWithImage:@"StatisticPreview" withTitle:@"统计趋势" withText:@"分析和展示你的任务和时间管理趋势。" withCurrentPageNumber:3 withType:MRStartSinglePreviewViewStyleDefault];
    [self.previewScrollView addSubview:self.statisticPreviewView];

    // 番茄钟预览图片视图
    self.tomatoClockPreviewView = [[MRStartSinglePreviewView alloc] initWithImage:@"TomatoClockPreview" withTitle:@"番茄钟" withText:@"利用番茄工作法提高工作效率并专注于任务。" withCurrentPageNumber:4 withType:MRStartSinglePreviewViewStyleDefault];
    [self.previewScrollView addSubview:self.tomatoClockPreviewView];
    
    
    // 将预览滚动视图添加到整个启动页视图中
    [self.view addSubview:self.previewScrollView];
    
    
    // 下一个按钮
    self.nextButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.nextButton setFrame:CGRectMake((self.view.bounds.size.width / 2) - 100, (self.view.bounds.size.height / 2) - 50, 200, 50)];
    [self updateButtonText];
    [self.nextButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [self.nextButton setBackgroundColor:UIColor.tintColor];
    self.nextButton.layer.cornerRadius = 10;
    self.nextButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.nextButton addTarget:self action:@selector(nextPreivewPage) forControlEvents:UIControlEventTouchUpInside];
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
        [self.pageControl.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:50],
        [self.pageControl.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-50],
        [self.pageControl.bottomAnchor constraintEqualToAnchor:self.nextButton.topAnchor constant:-50],
        [self.pageControl.heightAnchor constraintEqualToConstant:50],
    ]];

    
}


// MARK: - UIScrollViewDelegate

/// 页面滚动时执行
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 设定页面指示器当前页面的值
    float currentPage = scrollView.contentOffset.x / self.previewScrollView.frame.size.width;
    self.pageControl.currentPage = (NSInteger)(currentPage);
    self.currentPageNumber = currentPage;
    [self updateButtonText];
}


// MARK: - Custom

/// 关闭启动页
- (void)nextPreivewPage {
    if (self.currentPageNumber < 4) {
        self.currentPageNumber++; // 计数
        // 翻页
        CGFloat pageWidth = self.previewScrollView.frame.size.width;
        CGPoint offset = CGPointMake(self.currentPageNumber * pageWidth, 0);
        [self.previewScrollView setContentOffset:offset animated:YES];
    } else {
        // 修改 UserDefaults，下次启动时不会再出现启动页
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setBool:YES forKey:@"isNotFirstLaunch"];
        // 获取当前的 SceneDelegate
        SceneDelegate *sceneDelegate = (SceneDelegate *)[UIApplication sharedApplication].connectedScenes.allObjects.firstObject.delegate;
        // 切换视图到 TabBar
        sceneDelegate.window.rootViewController = [sceneDelegate tabBarConfigure];
        // 配置切换动画
        [UIView transitionWithView:sceneDelegate.window duration:1.0 options:UIViewAnimationOptionTransitionFlipFromRight animations:nil completion:nil];
    }
}

/// 页面指示器切换
- (void)pageControlValueChanged:(UIPageControl *)sender {
    self.currentPageNumber = sender.currentPage;
    CGFloat pageWidth = self.previewScrollView.frame.size.width;
    CGPoint offset = CGPointMake(sender.currentPage * pageWidth, 0);
    [self.previewScrollView setContentOffset:offset animated:YES];
}

/// 更新按钮文字
- (void)updateButtonText {
    // 设定为 3.001 是防止按钮文字二次闪烁，在用户拖动预览视图时，立刻对按钮文字进行更改
    if (self.currentPageNumber < 3.001) {
        [self.nextButton setTitle:@"继续" forState:UIControlStateNormal];
    } else {
        [self.nextButton setTitle:@"完成" forState:UIControlStateNormal];
    }
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
