#import "OWMetaData.h"

@interface OWMediationMetaData : OWMetaData

- (void)setName:(NSString *)mediationNetworkName;
- (void)setVersion:(NSString *)mediationSdkVersion;
- (void)setOrdinal:(int)mediationOrdinal;

@end