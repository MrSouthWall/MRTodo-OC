//
//  MRStartSinglePreviewView.h
//  MRTodo-OC
//
//  Created by 南墙先生 on 2024/8/2.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MRStartSinglePreviewViewStyle) {
    MRStartSinglePreviewViewStyleDefault,
    MRStartSinglePreviewViewStyleAppIcon,
};

NS_ASSUME_NONNULL_BEGIN

@interface MRStartSinglePreviewView : UIView

@property (strong, nonatomic, nullable) UIImageView *previewImage;
@property (strong, nonatomic, nullable) UILabel *previewTitle;
@property (strong, nonatomic, nullable) UILabel *previewText;

@property (nonatomic) NSInteger currentPageNumber;
@property (nonatomic) MRStartSinglePreviewViewStyle previewStyle;

@property (nonatomic) CGFloat previewScrollViewHeight;

- (instancetype)initWithImage:(NSString *)imageName withTitle:(NSString *)title withText:(nullable NSString *)text withCurrentPageNumber:(NSInteger)currentPageNumber withHeight:(CGFloat)previewScrollViewHeight withType:(MRStartSinglePreviewViewStyle)style;

@end

NS_ASSUME_NONNULL_END
