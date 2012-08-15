@import <AppKit/CPWindow.j>



@implementation MLPreferencesView : CPWindow
{
}

- (id)init
{
    self = [self initWithContentRect:CGRectMake(100.0, 50.0, 800.0, 400.0)
                           styleMask: CPClosableWindowMask |
                                     CPResizableWindowMask];

    if (self)
    {
    	var contentView = [self contentView],
            bounds = [contentView bounds];

        [self setTitle:"Preferences"];

	    var box = [[CPBox alloc] initWithFrame:CGRectMake(10, 10, CGRectGetWidth([contentView bounds]) - 20 , CGRectGetHeight([contentView bounds]) - 20)];

	    [box setBorderType:CPLineBorder];
	    [box setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable];

	    var toolbar = [CPToolbar new];
        [toolbar setDisplayMode:CPToolbarDisplayModeIconAndLabel];

        var toolbarDelegate = [ToolbarDelegate new],
            items = [@"general"];

        [items addObject:@"accounts"];
        [items addObject:@"categories"];
        [items addObject:@"traking"];
        [items addObject:@"advanced"];

        [toolbarDelegate setItems:items];
        [toolbar setDelegate:toolbarDelegate];

        [self setToolbar:toolbar];
	    [contentView addSubview:box];

    }

    return self;
}
@end

@implementation ToolbarDelegate : CPObject
{
    CPArray items @accessors;
}

- (CPArray)toolbarDefaultItemIdentifiers:(CPToolbar)toolbar
{
    return items;
}

- (CPArray)toolbarAllowedItemIdentifiers:(CPToolbar)toolbar
{
    return items;
}

- (CPToolbarItem)toolbar:(CPToolbar)toolbar itemForItemIdentifier:(CPString)itemIdentifier willBeInsertedIntoToolbar:(BOOL)flag
{
    var toolbarItem = [[CPToolbarItem alloc] initWithItemIdentifier:itemIdentifier];

    if (itemIdentifier == "general")
    {
        var mainBundle = [CPBundle mainBundle];
        var image = [[CPImage alloc] initWithContentsOfFile:[mainBundle pathForResource:@"switch.png"] size:CPSizeMake(256, 256)];
        var highlighted = [[CPImage alloc] initWithContentsOfFile:[mainBundle pathForResource:@"switch.png"] size:CPSizeMake(256, 256)];

        [toolbarItem setImage:image];
        [toolbarItem setAlternateImage:highlighted];

        [toolbarItem setTarget:self];
        //[toolbarItem setAction:@selector(browserItemCategories:)];
        [toolbarItem setLabel:"General"];

        [toolbarItem setMinSize:CGSizeMake(32, 32)];
        [toolbarItem setMaxSize:CGSizeMake(32, 32)];
    }
    else if (itemIdentifier == "categories")
    {
        var mainBundle = [CPBundle mainBundle];
        var image = [[CPImage alloc] initWithContentsOfFile:[mainBundle pathForResource:@"categories-browser.png"] size:CPSizeMake(256, 256)];
        var highlighted = [[CPImage alloc] initWithContentsOfFile:[mainBundle pathForResource:@"categories-browser.png"] size:CPSizeMake(256, 256)];

        [toolbarItem setImage:image];
        [toolbarItem setAlternateImage:highlighted];

        [toolbarItem setTarget:self];
        //[toolbarItem setAction:@selector(browserItemCategories:)];
        [toolbarItem setLabel:"Categories"];

        [toolbarItem setMinSize:CGSizeMake(32, 32)];
        [toolbarItem setMaxSize:CGSizeMake(32, 32)];
    }
    else if (itemIdentifier == "traking")
    {
        var mainBundle = [CPBundle mainBundle];
        var image = [[CPImage alloc] initWithContentsOfFile:[mainBundle pathForResource:@"traking.png"] size:CPSizeMake(256, 256)];
        var highlighted = [[CPImage alloc] initWithContentsOfFile:[mainBundle pathForResource:@"traking.png"] size:CPSizeMake(256, 256)];

        [toolbarItem setImage:image];
        [toolbarItem setAlternateImage:highlighted];

        [toolbarItem setTarget:self];
        //[toolbarItem setAction:@selector(browserItemCategories:)];
        [toolbarItem setLabel:"Traking"];

        [toolbarItem setMinSize:CGSizeMake(32, 32)];
        [toolbarItem setMaxSize:CGSizeMake(32, 32)];
    }
    else if (itemIdentifier == "advanced")
    {
        var mainBundle = [CPBundle mainBundle];
        var image = [[CPImage alloc] initWithContentsOfFile:[mainBundle pathForResource:@"advanced.png"] size:CPSizeMake(256, 256)];
        var highlighted = [[CPImage alloc] initWithContentsOfFile:[mainBundle pathForResource:@"advanced.png"] size:CPSizeMake(256, 256)];

        [toolbarItem setImage:image];
        [toolbarItem setAlternateImage:highlighted];

        [toolbarItem setTarget:self];
        //[toolbarItem setAction:@selector(browserItemCategories:)];
        [toolbarItem setLabel:"Advanced"];

        [toolbarItem setMinSize:CGSizeMake(32, 32)];
        [toolbarItem setMaxSize:CGSizeMake(32, 32)];
    }

    return toolbarItem;
}

@end
