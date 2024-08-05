//
//  MRTodoCollectionViewCell.h
//  MRTodo-OC
//
//  Created by 南墙先生 on 2024/8/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MRTodoCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *todoTitle;
@property (nonatomic, strong) UIButton *checkButton;

@end

NS_ASSUME_NONNULL_END
