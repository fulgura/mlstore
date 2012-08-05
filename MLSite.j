@import <Foundation/CPObject.j>
@import "MLCategory.j"

@implementation MLSite : CPObject
{
    int identifier @accessors;
    CPString name @accessors;
    CPArray categories @accessors;
}

- (id)init
{
	self = [super init]

	if (self)
	{
        identifier  = -1;
        name   = @"";
        categories = [[CPArray alloc] init];
	}

	return self;
}

/*!
    Initializes it with the data from a JSON Object

*/
- (id)initFromJSONObject:(JSObject)aJSONObject
{
    self = [self init];

    if (self)
    {
        identifier  = aJSONObject.id;
        name   = aJSONObject.name;
        categories = [MLCategory initFromJSONObjects: aJSONObject.categories];
    }

    return self;
}
@end
