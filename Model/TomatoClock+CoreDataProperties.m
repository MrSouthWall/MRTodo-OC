//
//  TomatoClock+CoreDataProperties.m
//  MRTodo-OC
//
//  Created by 南墙先生 on 2024/8/7.
//
//

#import "TomatoClock+CoreDataProperties.h"

@implementation TomatoClock (CoreDataProperties)

+ (NSFetchRequest<TomatoClock *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"TomatoClock"];
}

@dynamic endTime;
@dynamic pauseTime;
@dynamic startTime;
@dynamic timingTime;
@dynamic todo;

@end
