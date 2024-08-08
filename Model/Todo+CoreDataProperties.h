//
//  Todo+CoreDataProperties.h
//  MRTodo-OC
//
//  Created by 南墙先生 on 2024/8/7.
//
//

#import "Todo+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Todo (CoreDataProperties)

+ (NSFetchRequest<Todo *> *)fetchRequest NS_SWIFT_NAME(fetchRequest());

@property (nullable, nonatomic, copy) NSDate *endTime;
@property (nonatomic) BOOL flag;
@property (nullable, nonatomic, retain) NSData *image;
@property (nonatomic) BOOL isCompleted;
@property (nullable, nonatomic, copy) NSString *note;
@property (nullable, nonatomic, copy) NSString *position;
@property (nonatomic) int16_t priority;
@property (nonatomic) int32_t repeatCycle;
@property (nonatomic) int32_t repeatNumber;
@property (nullable, nonatomic, copy) NSDate *startTime;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSURL *url;
@property (nullable, nonatomic, copy) NSString *weather;
@property (nullable, nonatomic, copy) NSDate *createTime;
@property (nullable, nonatomic, retain) Folder *folder;
@property (nullable, nonatomic, retain) Todo *parentTodo;
@property (nullable, nonatomic, retain) NSSet<Todo *> *subTodos;
@property (nullable, nonatomic, retain) NSSet<Tag *> *tags;
@property (nullable, nonatomic, retain) NSSet<TomatoClock *> *tomatoClocks;

@end

@interface Todo (CoreDataGeneratedAccessors)

- (void)addSubTodosObject:(Todo *)value;
- (void)removeSubTodosObject:(Todo *)value;
- (void)addSubTodos:(NSSet<Todo *> *)values;
- (void)removeSubTodos:(NSSet<Todo *> *)values;

- (void)addTagsObject:(Tag *)value;
- (void)removeTagsObject:(Tag *)value;
- (void)addTags:(NSSet<Tag *> *)values;
- (void)removeTags:(NSSet<Tag *> *)values;

- (void)addTomatoClocksObject:(TomatoClock *)value;
- (void)removeTomatoClocksObject:(TomatoClock *)value;
- (void)addTomatoClocks:(NSSet<TomatoClock *> *)values;
- (void)removeTomatoClocks:(NSSet<TomatoClock *> *)values;

@end

NS_ASSUME_NONNULL_END
