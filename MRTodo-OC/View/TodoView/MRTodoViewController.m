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
#import "../../CoreDataManager.h"
#import "../../../Model//Todo+CoreDataClass.h"

@interface MRTodoViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

// CoreData
@property (nonatomic, strong) NSArray<Todo *> *todoArray;

@property (nonatomic, strong) UICollectionView *todoCollectionView;

@end

@implementation MRTodoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 从 CoreData 获取 Todo 条目信息
    NSManagedObjectContext *context = [CoreDataManager sharedManager].persistentContainer.viewContext;
    // 创建一个获取请求，fetchRequest 是 Xcode 在 Todo 类中预设好的获取请求方法
    NSFetchRequest *todoFetchRequest = [Todo fetchRequest];
    // 创建一个排序描述，根据 createTime 排序，ascending 的值为 YES 则按升序排序
    NSSortDescriptor *createTimeSort = [[NSSortDescriptor alloc] initWithKey:@"createTime" ascending:YES];
    // 把排序描述赋予这个获取的请求，换言之就是，以创建时间升序的顺序获取 CoreData 内 Todo 的条目数据
    todoFetchRequest.sortDescriptors = @[createTimeSort];
    NSError *error = nil; // 由于这个过程可能会抛出错误，所以需要一个 error
    // 执行从 context 中获取关于 Todo 条目，赋值给 todoArry，executeFetchRequest 意为执行获取请求
    self.todoArray = [context executeFetchRequest:todoFetchRequest error:&error];
    // 检查是否报错
    if (error) {
        [NSException raise:@"Fetch Error" format:@"%@", error.localizedDescription];
    }
    // 在控制台打印 todoArray 中所有条目
    for (Todo *todo in self.todoArray) {
        NSLog(@"Title: %@", todo.title);
        NSLog(@"Is Completed: %@", todo.isCompleted ? @"YES" : @"NO");
        NSLog(@"Due Date: %@", todo.createTime);
        NSLog(@"");
    }
    NSLog(@"--- Core Data Done ---");
    
    // 设置导航栏标题
    self.title = @"待办事项";
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    // 设置导航栏右上角按钮
    UIBarButtonItem *addTodoButton = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"plus"] style:UIBarButtonItemStylePlain target:self action:@selector(presentAddTodoViewController)];
    self.navigationItem.rightBarButtonItem = addTodoButton;
    // 设置导航栏左上角刷新按钮
    UIBarButtonItem *reloadTodoButton = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"arrow.triangle.2.circlepath"] style:UIBarButtonItemStylePlain target:self action:@selector(reloadView)];
    self.navigationItem.leftBarButtonItem = reloadTodoButton;
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
}


// MARK: - UICollectionViewDataSource

/// 行数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.todoArray.count;
}

/// 设置 Cell
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MRTodoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.layer.cornerRadius = 20;
    cell.layer.masksToBounds = YES;
    cell.layer.borderWidth = 1;
    cell.layer.borderColor = UIColor.systemGray3Color.CGColor;
    
    // 从 todoArray 获取每一个条目的数据
    Todo *todo = self.todoArray[indexPath.item];
    cell.todoTitle.text = [NSString stringWithFormat:@"%@", todo.title];
    // 设置 check 图标
    if (todo.isCompleted) {
        [cell.checkButton setImage:[UIImage systemImageNamed:@"checkmark.circle"] forState:UIControlStateNormal];
    } else {
        [cell.checkButton setImage:[UIImage systemImageNamed:@"circle"] forState:UIControlStateNormal];
    }
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

/// 刷新页面
- (void)reloadView {
    [self.todoCollectionView reloadData];
}


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
