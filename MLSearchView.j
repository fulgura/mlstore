@import <AppKit/CPWindow.j>



@implementation MLSearchView : CPWindow
{
}

- (id)init
{
    self = [self initWithContentRect:CGRectMake(50.0, 50.0, 800.0, 600.0)
                           styleMask: CPClosableWindowMask |
                                     CPResizableWindowMask];

    if (self)
    {
    	var contentView = [self contentView],
            bounds = [contentView bounds];

        [self setTitle:"Search"];

	    var box = [[CPBox alloc] initWithFrame:CGRectMake(10, 10,
	    				CGRectGetWidth([contentView bounds]) - 20 , CGRectGetHeight([contentView bounds]) - 20)];

	    [box setBorderType:CPLineBorder];
	    [box setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable];

	    [contentView addSubview:box];

    }

    return self;
}
@end
