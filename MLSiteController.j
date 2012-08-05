@import <Foundation/CPObject.j>

@import "MLSite.j"
@import "MLCategory.j"


@implementation MLSiteController : CPObject
{
	MLSite site @accessors;
}

- (id)init
{
	self = [super init]

	if (self)
	{
        site = nil;

    	var request = [CPURLRequest requestWithURL:"https://api.mercadolibre.com/sites/MLA/"],
        	connection = [CPURLConnection connectionWithRequest:request delegate:self];

	}

	return self;
}


- (void)connection:(CPURLConnection) connection didReceiveData:(CPString)data
{
    //This method is called when a connection receives a response. in a
    //multi-part request, this method will (eventually) be called multiple times,
    //once for each part in the response.

    site = [[MLSite alloc] initFromJSONObject: [data objectFromJSON]];
    console.log(site);
}

- (void)connection:(CPURLConnection)connection didFailWithError:(CPString)error
{
    //This method is called if the request fails for any reason.
    CPLog.info(error);
}
@end
