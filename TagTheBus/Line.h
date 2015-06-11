//
//  Line.h
//  TagTheBus
//
//  Copyright (c) 2015 Gregory Molette. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Line : NSManagedObject

@property (nonatomic, retain) NSString * destination;
@property (nonatomic, retain) NSString * line;
@property (nonatomic, retain) NSString * origin;

@end
