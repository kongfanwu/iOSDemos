//
//Created by ESJsonFormatForMac on 18/03/30.
//

#import <Foundation/Foundation.h>

@class ShengKaXuKaProData,ShengKaXuKaProDataList;
@interface ShengKaXuKaProModel : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) ShengKaXuKaProData *data;

@property (nonatomic, assign) NSInteger code;

@end
@interface ShengKaXuKaProData : NSObject

@property (nonatomic, strong) NSArray<ShengKaXuKaProDataList *> *list;

@end

@interface ShengKaXuKaProDataList : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, assign) NSInteger price;

@property (nonatomic, assign) NSInteger nums;

@property (nonatomic, assign) NSInteger is_have;

@property (nonatomic, assign) NSInteger money;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) BOOL selected;


@end

