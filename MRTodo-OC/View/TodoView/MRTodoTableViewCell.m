//
//  MRTodoTableViewCell.m
//  MRTodo-OC
//
//  Created by 南墙先生 on 2024/8/4.
//

#import "MRTodoTableViewCell.h"

@interface MRTodoTableViewCell ()

@end

@implementation MRTodoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configureCell];
    }
    return self;
}

/// 配置 Cell
- (void)configureCell {
    self.contentView.backgroundColor = UIColor.systemTealColor;
    self.contentView.layer.borderColor = UIColor.systemGray6Color.CGColor;
    self.contentView.layer.borderWidth = 1.0;
    self.contentView.layer.cornerRadius = 20;
    self.contentView.layer.masksToBounds = YES;
    
    // 检查勾选按钮
    self.checkButton = [[UIButton alloc] init];
    self.checkButton.backgroundColor = UIColor.blueColor;
    self.checkButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.checkButton];
    [NSLayoutConstraint activateConstraints:@[
        [self.checkButton.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
        [self.checkButton.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:20],
        [self.checkButton.widthAnchor constraintEqualToConstant:60],
        [self.checkButton.heightAnchor constraintEqualToConstant:60],
//        [self.checkButton.imageView.widthAnchor constraintEqualToConstant:50],
//        [self.checkButton.imageView.heightAnchor constraintEqualToConstant:50],
    ]];

    // Todo 标题
    self.todoTitle = [[UILabel alloc] init];
    self.todoTitle.backgroundColor = UIColor.redColor;
    self.todoTitle.translatesAutoresizingMaskIntoConstraints = NO;
    self.todoTitle.textColor = UIColor.labelColor;
    [self.contentView addSubview:self.todoTitle];
    [NSLayoutConstraint activateConstraints:@[
        [self.todoTitle.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
        [self.todoTitle.leadingAnchor constraintEqualToAnchor:self.checkButton.trailingAnchor constant:0],
        [self.todoTitle.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-20]
    ]];
}


// MARK: - Button

- (void)checkTodo {
    NSLog(@"CheckTodo!");
}


// MARK: - System Presets

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
