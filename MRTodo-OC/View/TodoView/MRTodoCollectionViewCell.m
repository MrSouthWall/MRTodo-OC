//
//  MRTodoCollectionViewCell.m
//  MRTodo-OC
//
//  Created by 南墙先生 on 2024/8/5.
//

#import "MRTodoCollectionViewCell.h"

@interface MRTodoCollectionViewCell ()

@end

@implementation MRTodoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureCell];
    }
    return self;
}

- (void)configureCell {
    // 检查勾选按钮
    self.checkButton = [[UIButton alloc] init];
    self.checkButton.backgroundColor = UIColor.systemTealColor;
    self.checkButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.checkButton];
    [NSLayoutConstraint activateConstraints:@[
        [self.checkButton.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
        [self.checkButton.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:0],
        [self.checkButton.widthAnchor constraintEqualToConstant:60],
        [self.checkButton.heightAnchor constraintEqualToConstant:60],
    ]];

    // Todo 标题
    self.todoTitle = [[UILabel alloc] init];
    self.todoTitle.backgroundColor = UIColor.systemPinkColor;
    self.todoTitle.translatesAutoresizingMaskIntoConstraints = NO;
    self.todoTitle.textColor = UIColor.labelColor;
    [self.contentView addSubview:self.todoTitle];
    [NSLayoutConstraint activateConstraints:@[
        [self.todoTitle.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
        [self.todoTitle.leadingAnchor constraintEqualToAnchor:self.checkButton.trailingAnchor constant:0],
        [self.todoTitle.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-20]
    ]];
}

@end
