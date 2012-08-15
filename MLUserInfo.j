@import <Foundation/CPObject.j>
@import "MLCategory.j"

@implementation MLUserInfo : CPObject
{
    int identifier @accessors;
    CPString nickname @accessors;
    CPString firstName @accessors;
    CPString lastName @accessors;
    CPString permalink @accessors;
}

- (id)init
{
	self = [super init]

	if (self)
	{
        identifier  = -1;
        nickname   = "";
        firstName = "";
        lastName = "";
        permalink = "";
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
        nickname   = aJSONObject.nickname;
        firstName   = aJSONObject.first_name;
        lastName   = aJSONObject.last_name;
        permalink   = aJSONObject.permalink;
    }

    return self;
}
@end
