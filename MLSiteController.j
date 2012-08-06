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
            connection = [CPJSONPConnection sendRequest:request callback:"callback" delegate:self];

	}

	return self;
}



- (void)connection:(CPJSONPConnection)aConnection didReceiveData:(Object)data
{
    //console.log("Data:", data);
    site = [[MLSite alloc] initFromJSONObject: data[2]];
    //console.log("Site:", site);
}

- (void)connection:(CPJSONPConnection)aConnection didFailWithError:(CPString)error
{
    //Ideally, we would do something smarter here.
    alert(error);
}
@end
