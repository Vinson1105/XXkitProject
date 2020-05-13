//
//  Person+CoreDataProperties.m
//  XXkitProject
//
//  Created by VINSON on 2020/5/13.
//  Copyright © 2020 郭文轩. All rights reserved.
//
//

#import "Person+CoreDataProperties.h"

@implementation Person (CoreDataProperties)

+ (NSFetchRequest<Person *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Person"];
}

@dynamic name;
@dynamic detail;
@dynamic id;
@dynamic phone;

@end
