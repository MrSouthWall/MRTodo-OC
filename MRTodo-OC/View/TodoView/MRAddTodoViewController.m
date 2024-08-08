//
//  MRAddTodoViewController.m
//  MRTodo-OC
//
//  Created by 南墙先生 on 2024/8/6.
//

#import "MRAddTodoViewController.h"
#import "../../CoreDataManager.h"
#import "../../../Model//Todo+CoreDataClass.h"

@interface MRAddTodoViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *addTodoTableView;
@property (nonatomic, strong) UITextField *todoTitle;
@property (nonatomic, strong) UITextField *note;
@property (nonatomic) BOOL isCompleted;
@property (nonatomic, strong) NSDate *startTime;
@property (nonatomic, strong) NSDate *endTime;
@property (nonatomic) NSInteger repeatCycle;
@property (nonatomic) NSInteger repeatNumber;
@property (nonatomic) BOOL flag;
@property (nonatomic) NSInteger priority;
@property (nonatomic, strong) NSString *position;
@property (nonatomic, strong) NSString *weather;
@property (nonatomic, strong) NSURL *url;

@end

@implementation MRAddTodoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 视图相关
    self.title = @"添加代办事项";
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(doneButton)];
    self.navigationItem.rightBarButtonItem = doneButton;
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButton)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    self.view.backgroundColor = UIColor.systemBackgroundColor;

    // 配置列表
    self.addTodoTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleInsetGrouped];
    self.addTodoTableView.dataSource = self;
    self.addTodoTableView.delegate = self;
    [self.view addSubview:self.addTodoTableView];
    
    // 配置标题
    self.todoTitle = [[UITextField alloc] init];
    self.todoTitle.placeholder = @"待办事项";
    
    // 配置备注
    self.note = [[UITextField alloc] init];
    self.note.placeholder = @"备注";
}


// MARK: - UITableViewDataSource

/// 章节数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

/// 配置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else if (section == 1) {
        return 2;
    }
    return 1;
}

/// addTodoTableView 的 Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addTodoTableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"addTodoTableViewCell"];
    }
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    [cell.contentView addSubview:self.todoTitle];
                    self.todoTitle.frame = cell.contentView.bounds;
                    self.todoTitle.translatesAutoresizingMaskIntoConstraints = NO;
                    [NSLayoutConstraint activateConstraints:@[
                        [self.todoTitle.centerYAnchor constraintEqualToAnchor:cell.contentView.centerYAnchor],
                        [self.todoTitle.leadingAnchor constraintEqualToAnchor:cell.contentView.leadingAnchor constant:20],
                        [self.todoTitle.trailingAnchor constraintEqualToAnchor:cell.contentView.trailingAnchor constant:-20],
                        [self.todoTitle.heightAnchor constraintEqualToAnchor:cell.contentView.heightAnchor],
                    ]];
                    break;
                case 1:
                    [cell.contentView addSubview:self.note];
                    self.note.frame = cell.contentView.bounds;
                    self.note.translatesAutoresizingMaskIntoConstraints = NO;
                    [NSLayoutConstraint activateConstraints:@[
                        [self.note.centerYAnchor constraintEqualToAnchor:cell.contentView.centerYAnchor],
                        [self.note.leadingAnchor constraintEqualToAnchor:cell.contentView.leadingAnchor constant:20],
                        [self.note.trailingAnchor constraintEqualToAnchor:cell.contentView.trailingAnchor constant:-20],
                        [self.note.heightAnchor constraintEqualToAnchor:cell.contentView.heightAnchor],
                    ]];
                default:
                    break;
            }
            break;
        case 1:
            break;
        case 2:
            break;
        default:
            break;
    }
    return cell;
}


// MARK: - UITableViewDelegate

/// 配置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

/// 配置 Section 章节标题高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section) {
        return 0; // 列表其他部分无间隔
    }
    return 10; // 列表顶部空间隔 10
}

/// 配置 Section 章节标题视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil; // 返回nil以隐藏头部视图
}


// MARK: - Button

/// 完成按钮
- (void)doneButton {
    // CoreData
    NSManagedObjectContext *context = [CoreDataManager sharedManager].persistentContainer.viewContext;
    // 创建一个来自 CoreData 的 Todo 实体在 context 中
    Todo *newTodo = (Todo *)[NSEntityDescription insertNewObjectForEntityForName:@"Todo" inManagedObjectContext:context];
    // 给 Todo 赋值
    newTodo.title = @"新TodoTitle";
    newTodo.note = @"新Note";
    newTodo.isCompleted = YES;
    newTodo.createTime = [NSDate now];
    // 有可能出错，所以需要设置 error
    NSError *error = nil;
    // 保存数据的同时，检查有没有返回错误
    if (![context save:&error]) {
        NSLog(@"Todo 数据保存失败：%@", error); // 输出错误信息
    } else {
        NSLog(@"Todo 数据保存成功：%@", newTodo); // 输出保存成功信息
    }
    
    // 关闭新建 Todo 视图
    [self dismissViewController];
}

/// 取消按钮
- (void)cancelButton {
    [self dismissViewController];
}


// MARK: - Custom

/// 关闭视图
- (void)dismissViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
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
