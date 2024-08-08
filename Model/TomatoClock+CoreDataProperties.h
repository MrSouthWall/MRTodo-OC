//
//  TomatoClock+CoreDataProperties.h
//  MRTodo-OC
//
//  Created by 南墙先生 on 2024/8/7.
//
//

#import "TomatoClock+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface TomatoClock (CoreDataProperties)

+ (NSFetchRequest<TomatoClock *> *)fetchRequest NS_SWIFT_NAME(fetchRequest());

@property (nullable, nonatomic, copy) NSDate *endTime;
@property (nonatomic) int32_t pauseTime;
@property (nullable, nonatomic, copy) NSDate *startTime;
@property (nonatomic) int32_t timingTime;
@property (nullable, nonatomic, retain) Todo *todo;

@end

NS_ASSUME_NONNULL_END
