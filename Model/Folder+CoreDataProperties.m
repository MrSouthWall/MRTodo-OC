//
//  Folder+CoreDataProperties.m
//  MRTodo-OC
//
//  Created by 南墙先生 on 2024/8/7.
//
//

#import "Folder+CoreDataProperties.h"

@implementation Folder (CoreDataProperties)

+ (NSFetchRequest<Folder *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Folder"];
}

@dynamic name;
@dynamic todos;

@end
