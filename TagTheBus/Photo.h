//
//  Photo.h
//  TagTheBus
//
//  Copyright (c) 2015 Gregory Molette. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Photo : NSManagedObject

@property (nonatomic, retain) NSString * busName;
@property (nonatomic, retain) NSString * imgPath;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * date;

+ (NSArray *)getPhotosByBus:(NSString *) busLine;
+(void)addPhoto :(NSString *)name :(NSString *)imgPath :(NSString *)busNumber;


@end
