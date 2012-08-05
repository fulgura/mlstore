@import <Foundation/CPObject.j>

@implementation MLCategory : CPObject
{
	 // the id (I don't call it "id" because that's a type in Objective-J)
    int identifier @accessors;
    CPString name @accessors;
}

- (id)init
{
	self = [super init]

	if (self)
	{
        identifier  = -1;
        name   = @"";
	}

	return self;
}

/*!
    Initializes it with the data from a JSON Object


*/
- (id) initFromJSONObject:(JSObject)aJSONObject
{
    self = [self init];

    if (self)
    {
        identifier  = aJSONObject.id;
        name   = aJSONObject.name;
    }

    return self;
}
/**


 */
+ (CPArray)initFromJSONObjects:(JSObject)aJSONObject
{
    var categories = [[CPArray alloc] init];

    if (aJSONObject) {
        for (var i=0; i < aJSONObject.length; i++) {
            var category    = [[MLCategory alloc] initFromJSONObject:aJSONObject[i]];
            [categories addObject:category];
        };
    }

    return categories;
}

@end
