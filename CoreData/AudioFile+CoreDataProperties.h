//
//  AudioFile+CoreDataProperties.h
//  XXkitProject
//
//  Created by VINSON on 2020/5/30.
//  Copyright © 2020 郭文轩. All rights reserved.
//
//

#import "AudioFile+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface AudioFile (CoreDataProperties)

+ (NSFetchRequest<AudioFile *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *path;
@property (nonatomic) float duration;

@end

NS_ASSUME_NONNULL_END
