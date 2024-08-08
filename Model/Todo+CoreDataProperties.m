//
//  Todo+CoreDataProperties.m
//  MRTodo-OC
//
//  Created by 南墙先生 on 2024/8/7.
//
//

#import "Todo+CoreDataProperties.h"

@implementation Todo (CoreDataProperties)

+ (NSFetchRequest<Todo *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Todo"];
}

@dynamic endTime;
@dynamic flag;
@dynamic image;
@dynamic isCompleted;
@dynamic note;
@dynamic position;
@dynamic priority;
@dynamic repeatCycle;
@dynamic repeatNumber;
@dynamic startTime;
@dynamic title;
@dynamic url;
@dynamic weather;
@dynamic createTime;
@dynamic folder;
@dynamic parentTodo;
@dynamic subTodos;
@dynamic tags;
@dynamic tomatoClocks;

@end
