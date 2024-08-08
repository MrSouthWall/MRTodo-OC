//
//  Folder+CoreDataProperties.h
//  MRTodo-OC
//
//  Created by 南墙先生 on 2024/8/7.
//
//

#import "Folder+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Folder (CoreDataProperties)

+ (NSFetchRequest<Folder *> *)fetchRequest NS_SWIFT_NAME(fetchRequest());

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSSet<Todo *> *todos;

@end

@interface Folder (CoreDataGeneratedAccessors)

- (void)addTodosObject:(Todo *)value;
- (void)removeTodosObject:(Todo *)value;
- (void)addTodos:(NSSet<Todo *> *)values;
- (void)removeTodos:(NSSet<Todo *> *)values;

@end

NS_ASSUME_NONNULL_END
