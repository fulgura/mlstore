@import <AppKit/CPPanel.j>


@implementation Node : CPObject
{
    id value;
}

+ (id)withValue:(id)aValue
{
    var a = [[self alloc] init];
    a.value = aValue;
    return a;
}

- (id)value
{
    return value;
}

- (CPArray)children
{
    return [[Node withValue:1],
            [Node withValue:2],
            [Node withValue:3],
            [Node withValue:2],
            [Node withValue:3],
            [Node withValue:2],
            [Node withValue:3],
            [Node withValue:2],
            [Node withValue:3],
            [Node withValue:2],
            [Node withValue:3],
            [Node withValue:2],
            [Node withValue:3],
            [Node withValue:4]];
}

@end

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
	    [self setBackgroundColor:[CPColor whiteColor]];
	    [self setFloatingPanel:YES];

	    var box = [[CPBox alloc] initWithFrame:bounds],
	        browser = [[CPBrowser alloc] initWithFrame:bounds];

	    [box setBorderType:CPLineBorder];
	    [box setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable];
	    [box setCenter:[contentView center]];
	    [browser setWidth:300 ofColumn:1];
	    [box setContentView:browser];

		[browser setDelegate:self];
	    [browser setTarget:self];
	    [browser setAction:@selector(browserClicked:)];
	    [browser setDoubleAction:@selector(dblClicked:)];
	    [browser registerForDraggedTypes:["Type"]];
	    [contentView addSubview:box];

    }

    return self;
}
- (void)browserClicked:(id)aBrowser
{
    console.log("selected column: " + [aBrowser selectedColumn] + " row: " + [aBrowser selectedRowInColumn:[aBrowser selectedColumn]]);
}

- (void)dblClicked:(id)sender
{
    alert("DOUBLE");
}
- (id)browser:(id)aBrowser numberOfChildrenOfItem:(id)anItem
{
    if (anItem === nil)
        return 4;
    return [[anItem children] count];
}

- (id)browser:(id)aBrowser child:(int)index ofItem:(id)anItem
{
    if (!anItem)
        return [[[Node withValue:0] children] objectAtIndex:index];

    return [[anItem children] objectAtIndex:index];
}

- (id)browser:(id)aBrowser imageValueForItem:(id)anItem
{
    return [[CPImage alloc] initWithContentsOfFile:"http://cappuccino.org/images/favicon.png" size:CGSizeMake(16, 16)];
}

- (id)browser:(id)aBrowser objectValueForItem:(id)anItem
{
    return [anItem value];
}

- (id)browser:(id)aBrowser isLeafItem:(id)anItem
{
    return ![[anItem children] count] || [anItem value] === 4;
}
@end
