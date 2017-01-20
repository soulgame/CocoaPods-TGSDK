
#import <Foundation/Foundation.h>


@interface OWMetaData : NSObject

@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSMutableDictionary *entries;

- (instancetype)initWithCategory:(NSString *)category;
- (void)set:(NSString *)key value:(id)value;
- (void)commit;

@end