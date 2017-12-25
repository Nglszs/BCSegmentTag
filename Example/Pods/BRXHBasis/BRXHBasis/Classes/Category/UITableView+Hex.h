//
//  UITableView+Hex.h
//  AFNetworking
//
//  Created by apple on 2017/11/30.
//

#import <Foundation/Foundation.h>

@interface UITableView (Hex)

///没有数据的时候显示
- (void) tableViewDisplayWitMsg:(NSString *) message ifNecessaryForRowCount:(NSUInteger) rowCount;

@end
