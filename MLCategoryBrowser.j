@import <AppKit/CPPanel.j>

@implementation MLCategoryBrowser : CPPanel
{
}

- (id)init
{
    self = [self initWithContentRect:CGRectMake(100.0, 50.0, 800.0, 600.0)
                           styleMask:CPHUDBackgroundWindowMask |
                                     CPClosableWindowMask |
                                     CPResizableWindowMask];

    if (self)
    {
    	var contentView = [self contentView],
            bounds = [contentView bounds];

        bounds.size.height -= 20.0;

        [self setTitle:"Item Categories"];
	    //[self setBackgroundColor:[CPColor colorWithHexString:@"DDE4E4"]];
	    [self setFloatingPanel:YES];

	    var box = [[CPBox alloc] initWithFrame:bounds],
	        browser = [[CPBrowser alloc] initWithFrame:bounds];

	    [browser setWidth:300 ofColumn:1];
	    [box setContentView:browser];
	    [box setBorderType:CPLineBorder];
	    [box setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable];
	    [box setCenter:[contentView center]];

	    [contentView addSubview:box];

    }

    return self;
}

@end
