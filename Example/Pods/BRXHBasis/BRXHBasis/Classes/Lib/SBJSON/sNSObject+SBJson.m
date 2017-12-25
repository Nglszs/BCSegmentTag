//
//  sNSObject+SBJson.m
//  partCP
//
//  Created by 鹏举 罗 on 12-5-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "sNSObject+SBJson.h"
#import "sSBJsonWriter.h"
#import "sSBJsonParser.h"

@implementation NSObject (NSObject_SBJsonWriting)

- (NSString *)JSONRepresentation {
    sSBJsonWriter *writer = [[sSBJsonWriter alloc] init];    
    NSString *json = [writer stringWithObject:self];
    if (!json)
        NSLog(@"-JSONRepresentation failed. Error is: %@", writer.error);
    return json;
}

@end



@implementation NSString (NSString_SBJsonParsing)

- (id)JSONValue {
    sSBJsonParser *parser = [[sSBJsonParser alloc] init];
    id repr = [parser objectWithString:self];
    if (!repr)
        NSLog(@"-JSONValue failed. Error is: %@", parser.error);
    return repr;
}

@end



@implementation NSData (NSData_SBJsonParsing)

- (id)JSONValue {
    sSBJsonParser *parser = [[sSBJsonParser alloc] init];
    id repr = [parser objectWithData:self];
    if (!repr)
        NSLog(@"-JSONValue failed. Error is: %@", parser.error);
    return repr;
}
@end
