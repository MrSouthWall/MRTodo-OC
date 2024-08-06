//
//  MRTodoViewController.m
//  MRTodo-OC
//
//  Created by 南墙先生 on 2024/7/31.
//

#import "MRTodoViewController.h"
//#import "MRTodoTableViewCell.h"
#import "MRTodoCollectionViewCell.h"
#import "MRAddTodoViewController.h"

@interface MRTodoViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

/* TableView 代码
 @interface MRTodoViewController ()<UITableViewDataSource, UITableViewDelegate>

 @property (nonatomic, strong) UITableView *todoTableView;
 */

@property (nonatomic, strong) UICollectionView *todoCollectionView;

@end

@implementation MRTodoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 设置导航栏标题
    self.title = @"待办事项";
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    // 设置导航栏右上角按钮
    UIBarButtonItem *addTodoButton = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"plus"] style:UIBarButtonItemStylePlain target:self action:@selector(presentAddTodoViewController)];
    self.navigationItem.rightBarButtonItem = addTodoButton;
    // 设置 Collection 视图布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 10;
    flowLayout.itemSize = CGSizeMake(self.view.frame.size.width - 40, 60);
    // 设置 COllection 视图
    self.todoCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.todoCollectionView.dataSource = self;
    self.todoCollectionView.delegate = self;
    [self.todoCollectionView registerClass:[MRTodoCollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.view addSubview:self.todoCollectionView];
    
    /* UITableView 代码
     // 添加右侧按钮
     UIBarButtonItem *addTodoButton = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"plus"] style:UIBarButtonItemStylePlain target:self action:@selector(addTodoItem)];
     self.navigationItem.rightBarButtonItem = addTodoButton;
     
     self.todoTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
     self.todoTableView.delegate = self;
     self.todoTableView.dataSource = self;
     self.todoTableView.separatorStyle = UITableViewCellSeparatorStyleNone; // 去掉分隔线
     [self.todoTableView registerClass:[MRTodoTableViewCell class] forCellReuseIdentifier:@"MRTodoTableViewCell"];
     self.todoTableView.translatesAutoresizingMaskIntoConstraints = NO;
     [self.view addSubview:self.todoTableView];
     [NSLayoutConstraint activateConstraints:@[
         [self.todoTableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20],
         [self.todoTableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20],
         [self.todoTableView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor],
     ]];
     
     NSLog(@"Navigation Controller: %@", self.navigationController);
     */
}


// MARK: - UICollectionViewDataSource

/// 行数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}

/// 设置 Cell
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MRTodoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.layer.cornerRadius = 20;
    cell.layer.masksToBounds = YES;
    cell.layer.borderWidth = 1;
    cell.layer.borderColor = UIColor.grayColor.CGColor;
    [cell.checkButton setImage:[UIImage systemImageNamed:@"circle"] forState:UIControlStateNormal];
    cell.todoTitle.text = [NSString stringWithFormat:@"Item %ld", (long)indexPath.item];
    return cell;
}

/// 点击进入 Todo 详情页
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // 创建一个视图
    UIViewController *controller = [UIViewController new];
    controller.title = [NSString stringWithFormat:@"%@", @(indexPath.row + 1)];
    controller.view.backgroundColor = UIColor.systemBackgroundColor;
    // 推送视图
    [self.navigationController pushViewController:controller animated:YES];
}


// MARK: - UICollectionViewDelegate

/// 当用户按下 Cell 时
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    MRTodoCollectionViewCell *cell = [self.todoCollectionView cellForItemAtIndexPath:indexPath];
    // Cell 缩小并设置灰色
    [UIView animateWithDuration:0.1 animations:^{
        cell.transform = CGAffineTransformMakeScale(0.98, 0.98);
        cell.backgroundColor = UIColor.systemGray3Color;
    }];
}

/// 当用户松开 Cell 时
- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    MRTodoCollectionViewCell *cell = [self.todoCollectionView cellForItemAtIndexPath:indexPath];
    [UIView animateWithDuration:0.1 animations:^{
        // Cell 回到正常大小
        cell.transform = CGAffineTransformMakeScale(1, 1);
        // 背景颜色延迟回到白色
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            cell.backgroundColor = UIColor.systemBackgroundColor;
        });
    }];
}


// MARK: - Button

/// 点击右上角按钮添加待办事项
- (void)addTodoItem {
    NSLog(@"用户点击了新增Todo按钮！");
}

/// 打开 AddTodo 页面
- (void)presentAddTodoViewController {
    MRAddTodoViewController * addTodoViewController = [[MRAddTodoViewController alloc] init];
    UINavigationController *addTodoNavigationController = [[UINavigationController alloc] initWithRootViewController:addTodoViewController];
    [self presentViewController:addTodoNavigationController animated:YES completion:nil];
}


/* UITableView 代码
 // MARK: - UITableViewDataSource

 /// 行数
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     return 30;
 }

 /// 设置 Cell
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     // 使用 dequeueReusableCellWithIdentifier 进行初始化，有助于提高性能和减少内存使用
     MRTodoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MRTodoTableViewCell" forIndexPath:indexPath];
     if (!cell) {
         cell = [[MRTodoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MRTodoTableViewCell"];
     }
     // 配置 cell
     cell.todoTitle.text = [NSString stringWithFormat:@"Todo Item %ld", indexPath.row + 1];
     [cell.checkButton setImage:[UIImage systemImageNamed:@"star"] forState:UIControlStateNormal];

 //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; // Cell 最右侧的箭头
     NSLog(@"MRTodoViewController Cell: %@", cell);
     return cell;
 }


 // MARK: - UITableViewDelegate

 /// 行高
 - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
     return 65;
 }

 /// 用户点击 Cell
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     // 创建一个视图
     UIViewController *controller = [UIViewController new];
     controller.title = [NSString stringWithFormat:@"%@", @(indexPath.row)];
     controller.view.backgroundColor = UIColor.whiteColor;
     // 推送视图
     [self.navigationController pushViewController:controller animated:YES];
 }


 // MARK: - Button

 // 点击右上角按钮添加待办事项
 - (void)addTodoItem {
     
 }
 */


// MARK: - System Presets

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


// MARK: - 设置 Cell 出现动画
/*
 /// 视图将要出现时执行
 - (void)viewWillAppear:(BOOL)animated {
     [super viewWillAppear:animated];
     [self animateTodoCollectionView];
 }

 /// TodoCollection 出现动画
 - (void)animateTodoCollectionView {
     NSArray *cells = [self.todoCollectionView visibleCells];
     NSArray *sortedCells = [cells sortedArrayUsingComparator:^NSComparisonResult(UICollectionViewCell *cell1, UICollectionViewCell *cell2) {
         NSIndexPath *indexPath1 = [self.todoCollectionView indexPathForCell:cell1];
         NSIndexPath *indexPath2 = [self.todoCollectionView indexPathForCell:cell2];
         return [indexPath1 compare:indexPath2];
     }];
     [sortedCells enumerateObjectsUsingBlock:^(UICollectionViewCell *cell, NSUInteger idx, BOOL *stop) {
         cell.transform = CGAffineTransformMakeTranslation(0, self.view.bounds.size.height);
         [UIView animateWithDuration:0.8 delay:0.02 * idx usingSpringWithDamping:0.8 initialSpringVelocity:0 options:0 animations:^{cell.transform = CGAffineTransformMakeTranslation(0, 0);} completion:nil];
     }];
 }
 */


@end
