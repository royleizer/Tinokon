//
//  DBManager.h
//  NoravMobileECG
//
//  Created by Roy on 15/03/2017.
//  Copyright © 2017 norav medical. All rights reserved.
//


#import <Foundation/Foundation.h>
@import Firebase;

@interface DBManager : NSObject

-(instancetype)initWithDatabaseFilename:(NSString *)dbFilename;

@property (nonatomic, strong) NSMutableArray *arrColumnNames;

@property (nonatomic) int affectedRows;

@property (nonatomic) long long lastInsertedRowID;

-(NSArray *)loadDataFromDB:(NSString *)query;

-(void)executeQuery:(NSString *)query;

@property (strong, nonatomic) FIRDatabaseReference *ref;

@end
