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
	var namedArguments = [sharedApplication namedArguments];

	var token = [namedArguments objectForKey:"access_token"];
	if(token != nil)
	{
		[self setAccessToken:token];
	}

	var expires_in = [namedArguments objectForKey:"expires_in"];
	if(expires_in != nil)
	{
		[self setExpiresIn:expires_in];
	}

	var user_id = [namedArguments objectForKey:"user_id"];
	if(user_id != nil)
	{
		[self setUserId:user_id];
	}

	var dms = [namedArguments objectForKey:"domains"];
	if(dms != nil)
	{
		[self setDomains:dms];
	}

	//TODO: Find it in CPCookie
	console.log(self);


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
