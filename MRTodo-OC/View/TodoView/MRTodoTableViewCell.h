//
//  MRTodoTableViewCell.h
//  MRTodo-OC
//
//  Created by 南墙先生 on 2024/8/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MRTodoTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *todoTitle;
@property (nonatomic, strong) UIButton *checkButton;

@end

NS_ASSUME_NONNULL_END
