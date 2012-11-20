#import <Foundation/Foundation.h>

@class LSStubRequestDSL;
@class LSStubResponseDSL;
@class LSStubRequest;

typedef LSStubRequestDSL *(^WithHeaderMethod)(NSString *, NSString *);
typedef LSStubRequestDSL *(^WithHeadersMethod)(NSDictionary *);
typedef LSStubRequestDSL *(^WithParameterMethod)(NSString *, NSString *);
typedef LSStubRequestDSL *(^WithParametersMethod)(NSDictionary *);
typedef LSStubRequestDSL *(^AndBodyMethod)(NSString *);
typedef LSStubResponseDSL *(^AndReturnMethod)(NSInteger);

@interface LSStubRequestDSL : NSObject
- (id)initWithRequest:(LSStubRequest *)request;
- (WithHeaderMethod)withHeader;
- (WithHeadersMethod)withHeaders;
- (WithParameterMethod)withParameter;
- (WithParametersMethod)withParameters;
- (AndBodyMethod)withBody;
- (AndReturnMethod)andReturn;
@end

LSStubRequestDSL * stubRequest(NSString *method, NSString *url);