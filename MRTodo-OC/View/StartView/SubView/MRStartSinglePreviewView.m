//
//  MRStartSinglePreviewView.m
//  MRTodo-OC
//
//  Created by 南墙先生 on 2024/8/2.
//

#import "MRStartSinglePreviewView.h"

@interface MRStartSinglePreviewView ()

@end

@implementation MRStartSinglePreviewView

- (instancetype)initWithImage:(NSString *)imageName withTitle:(NSString *)title withText:(nullable NSString *)text withCurrentPageNumber:(NSInteger)currentPageNumber withHeight:(CGFloat)previewScrollViewHeight withType:(MRStartSinglePreviewViewStyle)style {
    self = [super init];
    if (self) {
        self.previewImage = [[UIImageView alloc] init];
        self.previewImage.image = [UIImage imageNamed:imageName];
        self.previewTitle = [[UILabel alloc] init];
        self.previewTitle.text = title;
        self.previewText = [[UILabel alloc] init];
        self.previewText.text = text;
        self.currentPageNumber = currentPageNumber;
        self.previewScrollViewHeight = previewScrollViewHeight;
        self.previewStyle = style;
        [self viewConfigure];
    }
    return self;
}

/// 视图配置
- (void)viewConfigure {
    // 设置视图框架
    self.frame = CGRectMake(UIScreen.mainScreen.bounds.size.width * self.currentPageNumber, 0, UIScreen.mainScreen.bounds.size.width, self.previewScrollViewHeight);
    switch (self.previewStyle) {
        case MRStartSinglePreviewViewStyleDefault:
            [self startSinglePreviewViewStyleDefault];
            break;
        case MRStartSinglePreviewViewStyleAppIcon:
            [self startSinglePreviewViewStyleAppIcon];
            break;
        default:
            break;
    }

}

- (void)startSinglePreviewViewStyleDefault {
    // 图片
    self.previewImage.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.previewImage];
    [NSLayoutConstraint activateConstraints:@[
        [self.previewImage.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
        [self.previewImage.topAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.topAnchor constant:100],
    ]];
    
    // 说明文字
    self.previewText.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.previewText.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.previewText];
    [NSLayoutConstraint activateConstraints:@[
        [self.previewText.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
        [self.previewText.bottomAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.bottomAnchor constant:-25],
    ]];
    
    // 标题文字
    self.previewTitle.font = [UIFont preferredFontForTextStyle:UIFontTextStyleExtraLargeTitle2];
    self.previewTitle.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.previewTitle];
    [NSLayoutConstraint activateConstraints:@[
        [self.previewTitle.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
        [self.previewTitle.bottomAnchor constraintEqualToAnchor:self.previewText.topAnchor constant:-20],
    ]];
}

- (void)startSinglePreviewViewStyleAppIcon {
    // AppIcon 图片
    [self setAppIconLightOrDarkMode];
    [self registerForTraitChanges:@[UITraitUserInterfaceStyle.self] withAction:@selector(setAppIconLightOrDarkMode)];
    self.previewImage.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.previewImage];
    [NSLayoutConstraint activateConstraints:@[
        [self.previewImage.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
        [self.previewImage.topAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.topAnchor constant:100],
        [self.previewImage.widthAnchor constraintEqualToConstant:175],
        [self.previewImage.heightAnchor constraintEqualToConstant:175],
    ]];
    
    // 标题文字
    self.previewTitle.font = [UIFont preferredFontForTextStyle:UIFontTextStyleExtraLargeTitle2];
    self.previewTitle.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.previewTitle];
    [NSLayoutConstraint activateConstraints:@[
        [self.previewTitle.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
        [self.previewTitle.topAnchor constraintEqualToAnchor:self.previewImage.bottomAnchor constant:60],
    ]];
}

/// 设置 AppIcon 浅色或深色
- (void)setAppIconLightOrDarkMode {
    if (@available(iOS 13.0, *)) {
        if (self.traitCollection.userInterfaceStyle != UIUserInterfaceStyleDark) {
            // 浅色模式
            self.previewImage.image = [UIImage imageNamed:@"MRTodo App Logo V1 - 1024x1024 - Light - RoundShadow"];
        } else {
            // 深色模式
            self.previewImage.image = [UIImage imageNamed:@"MRTodo App Logo V1 - 1024x1024 - Dark - RoundShadow"];
        }
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
