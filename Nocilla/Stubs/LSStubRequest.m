#import "LSStubRequest.h"

@interface LSStubRequest ()
@property (nonatomic, assign, readwrite) NSString *method;
@property (nonatomic, strong, readwrite) NSURL *url;
@property (nonatomic, strong, readwrite) NSMutableDictionary *mutableHeaders;
@property (nonatomic, strong, readwrite) NSMutableDictionary *mutableParameters;

-(BOOL)matchesMethod:(id<LSHTTPRequest>)request;
-(BOOL)matchesURL:(id<LSHTTPRequest>)request;
-(BOOL)matchesHeaders:(id<LSHTTPRequest>)request;
-(BOOL)matchesBody:(id<LSHTTPRequest>)request;
@end

@implementation LSStubRequest
- (id)initWithMethod:(NSString *)method url:(NSString *)url {
    self = [super init];
    if (self) {
        _method = method;
        _url = [NSURL URLWithString:url];
        _mutableHeaders = [NSMutableDictionary dictionary];
        _mutableParameters = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)setHeader:(NSString *)header value:(NSString *)value {
    [self.mutableHeaders setValue:value forKey:header];
}

- (NSDictionary *)headers {
    return [NSDictionary dictionaryWithDictionary:self.mutableHeaders];
}

- (void)setParameter:(NSString *)parameter value:(NSString *)value {
    [self.mutableParameters setValue:value forKey:parameter];
}

- (NSDictionary *)parameters {
    return [NSDictionary dictionaryWithDictionary:self.mutableParameters];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"StubRequest:\nMethod: %@\nURL: %@\nHeaders: %@\nParameters: %@\nBody: %@\nResponse: %@",
            self.method,
            self.url,
            self.headers,
            self.parameters,
            self.body,
            self.response];
}

- (LSStubResponse *)response {
    if (!_response) {
        _response = [[LSStubResponse alloc] initDefaultResponse];
    }
    return _response;
    
}

- (BOOL)matchesRequest:(id<LSHTTPRequest>)request {
    if ([self matchesMethod:request]
        && [self matchesURL:request]
        && [self matchesHeaders:request]
        && [self matchesParameters:request]
        && [self matchesBody:request]
        ) {
        return YES;
    }
    return NO;
}

-(BOOL)matchesMethod:(id<LSHTTPRequest>)request {
    if (!self.method || [self.method isEqualToString:request.method]) {
        return YES;
    }
    return NO;
}

-(BOOL)matchesURL:(id<LSHTTPRequest>)request {
    NSString *a = [self.url absoluteString];
    NSString *b = [request.url absoluteString];
    if ([a isEqualToString:b]) {
        return YES;
    }
    return NO;
}

-(BOOL)matchesHeaders:(id<LSHTTPRequest>)request {
    for (NSString *header in self.headers) {
        if (![[request.headers objectForKey:header] isEqualToString:[self.headers objectForKey:header]]) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)matchesParameters:(id<LSHTTPRequest>)request {
    for (NSString *parameter in self.parameters) {
        if (![[request.parameters objectForKey:parameter] isEqualToString:[self.parameters objectForKey:parameter]]) {
            return NO;
        }
    }
    return YES;
}

-(BOOL)matchesBody:(id<LSHTTPRequest>)request {
    NSData *selfBody = self.body;
    NSData *reqBody = request.body;
    if (!selfBody || [selfBody isEqualToData:reqBody]) {
        return YES;
    }
    return NO;
}
@end


