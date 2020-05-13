//
//  AudioFile+CoreDataProperties.m
//  XXkitProject
//
//  Created by VINSON on 2020/5/13.
//  Copyright © 2020 郭文轩. All rights reserved.
//
//

#import "AudioFile+CoreDataProperties.h"

@implementation AudioFile (CoreDataProperties)

+ (NSFetchRequest<AudioFile *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"AudioFile"];
}

@dynamic path;
@dynamic name;

@end
