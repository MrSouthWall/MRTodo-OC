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

@property (strong, nonatomic) UIView *previewView;

@end

@implementation MRStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 设置从第一页开始
    self.currentPageNumber = 0;
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    
    // 滚动视图
    CGFloat previewScrollViewHeight = UIScreen.mainScreen.bounds.size.height - 225;
    self.previewScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, previewScrollViewHeight)];
    self.previewScrollView.contentSize = CGSizeMake(UIScreen.mainScreen.bounds.size.width * 5, previewScrollViewHeight);
    self.previewScrollView.pagingEnabled = YES; // 设置滚动视图翻页模式
    self.previewScrollView.showsHorizontalScrollIndicator = NO; // 设置水平滚动条不可见
    self.previewScrollView.delegate = self;
    
    // 预览视图图片
    NSArray *images = @[
        @"MRTodo App Logo V1 - 1024x1024 - Light - RoundShadow",
        @"CalendarPreview",
        @"TodoPreview",
        @"StatisticPreview",
        @"TomatoClockPreview",
    ];
    // 预览视图标题
    NSArray *titles = @[
        @"欢迎使用“MRTodo”",
        @"日历日程",
        @"待办事项",
        @"统计趋势",
        @"番茄钟",
    ];
    // 预览视图文字
    NSArray *texts = @[
        @"",
        @"管理并查看你的日程安排和重要事件。",
        @"创建、追踪和完成你的任务清单。",
        @"分析和展示你的任务和时间管理趋势。",
        @"利用番茄工作法提高工作效率并专注于任务。",
    ];
    
    // 创建预览页面
    for (int i = 0; i < 5; i++) {
        if (i) { // 如果 i 为 0，则为假，执行 else 后面 AppIcon 样式的代码
            self.previewView = [
                [MRStartSinglePreviewView alloc]
                initWithImage:images[i]
                withTitle:titles[i]
                withText:texts[i]
                withCurrentPageNumber:i
                withHeight:previewScrollViewHeight
                withType:MRStartSinglePreviewViewStyleDefault
            ];
        } else {
            self.previewView = [
                [MRStartSinglePreviewView alloc]
                initWithImage:images[i]
                withTitle:titles[i]
                withText:nil
                withCurrentPageNumber:i
                withHeight:previewScrollViewHeight
                withType:MRStartSinglePreviewViewStyleAppIcon
            ];
        }
        [self.previewScrollView addSubview:self.previewView]; // 添加到 ScrollView
    }
    
    // 将预览滚动视图添加到整个启动页视图中
    [self.view addSubview:self.previewScrollView];
    
    // 配置继续按钮
    self.nextButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self buttonConfigure];
    
    // 配置页面指示器
    self.pageControl = [UIPageControl new];
    [self pageControlConfigure];
}


// MARK: - Configure

/// 配置按钮属性
- (void)buttonConfigure {
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
}

/// 配置控制器属性
- (void)pageControlConfigure {
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
