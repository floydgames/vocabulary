//
//  FYDVocabularyBox.m
//  vocabulary
//
//  Created by Florian Kaiser on 23.05.13.
//  Copyright (c) 2013 Floyd UG (haftungsbeschränkt). All rights reserved.
//

#import "FYDVocabularyBox.h"

#import "FYDStage.h"
#import "FYDVocable.h"
#import "FYDVocabularyTest.h"

@interface FYDVocabularyBox ()

@property (assign,nonatomic) NSInteger lastStageNo;
@property (strong,nonatomic) NSMutableArray *stages;
@property (strong,nonatomic) NSMutableArray *learned;

@end

@implementation FYDVocabularyBox

- (id) init
{
    if (self = [super init])
    {
        self.lastStageNo = 0;
        self.stages = [[NSMutableArray alloc] init];
    }
    return self;
}

- (FYDStage*) addStage
{
    FYDStage *stage = [[FYDStage alloc] initWithNo:++self.lastStageNo];
    [self.stages addObject:stage];
    return stage;
}

- (NSInteger) stageCount
{
    return self.stages.count;
}

- (FYDStage*) stageAt:(NSInteger)stageNo
{
    return self.stages[stageNo];
}

- (FYDVocabularyTest*) vocabularyTestForStage:(NSInteger)stageNo
{
    return [[self stageAt:stageNo] vocabularyTestWithBox:self];
}

- (void)putIntoFirstStage:(FYDVocable*)vocable
{
    if (vocable.stage != self.stages[0])
    {
        [vocable.stage removeVocable:vocable];
        [self.stages[0] addVocable:vocable];
    }
}

- (void)putIntoNextStage:(FYDVocable*)vocable
{
    NSUInteger nextStageNo = [self.stages indexOfObject:vocable.stage] + 1;
    
    [vocable.stage removeVocable:vocable];
    
    if (nextStageNo < self.stages.count)
    {
        [self.stages[nextStageNo] addVocable:vocable];
    }
    else
    {
        [self.learned addObject:vocable];
    }
}

@end
