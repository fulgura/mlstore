@import <Foundation/CPObject.j>
@import "MLUserInfo.j"


@implementation MLAPIController : CPObject
{

	CPString accessToken @accessors;
	CPString expiresIn @accessors;
	CPString userId @accessors;
	CPString domains @accessors;
 	CPString baseURL @accessors;
}

- (id)init
{
	self = [super init]

	if (self)
	{
		baseURL	= "https://api.mercadolibre.com/";
		accessToken = nil;
		expiresIn = nil;
		userId = nil;
		domains = nil;
		[self findAccessToken];
	}

	return self;
}
/**
 *
 *
 */
-(void)findAccessToken
{
	var sharedApplication = [CPApplication sharedApplication];

	var hash = [[sharedApplication arguments] firstObject],
        args = [hash componentsSeparatedByString:"&"];

    if (args != null)
    {
        [self setAccessToken:[args[0] componentsSeparatedByString:"="][1]];
        [self setExpiresIn:[args[1] componentsSeparatedByString:"="][1]];
        [self setUserId:[args[2] componentsSeparatedByString:"="][1]];
        [self setDomains:[args[3] componentsSeparatedByString:"="][1]];
        //TODO: Validate token!!!
        //TODO: Save info in cokies
        //

    }else
    {
        [[CPNotificationCenter defaultCenter] postNotificationName:@"SessionExpired" object:nil];
    }
}

-(void)userInfo:(Function)aCallback
{

   var request = new CFHTTPRequest();

   request.open("GET", baseURL + "users/me" +  [self credentialsString], true);

    request.oncomplete = function()
    {

        if (request.success())
        {
            try {

            	 if (aCallback)
            	 {
            		aCallback([[MLUserInfo alloc] initFromJSONObject:JSON.parse(request.responseText())])
            	}
            }
            catch (e) {
                CPLog.error("Unable to find user info: " + " -- " + e);
            }
        }

        [[CPRunLoop currentRunLoop] performSelectors];
    }

    request.send("");
}

-(void)categories:(Function)aCallback
{
    var request = new CFHTTPRequest();
    request.open(@"GET", "https://api.mercadolibre.com/sites/MLA/categories/", true);

    request.oncomplete = function()
    {
         console.log("Answer: ", JSON.parse(request.responseText())) ;
    };

    request.send(@"");
}

- (CPString)credentialsString
{
    return  "?access_token=" + encodeURIComponent(accessToken);
}

@end
