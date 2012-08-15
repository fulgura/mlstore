@import <AppKit/CPView.j>


@implementation MLNavigationView : CPView
{
    /*!
    *
    */

    MLNavigationComponent root @accessors;

}
- (id)initWithFrame:(CGRect)aFrame
{
    self = [super initWithFrame:aFrame];
    if (self)
    {
        var width = [[self bounds].size.width],
            height = [[self bounds].size.height],
            column = [[CPTableColumn alloc] initWithIdentifier:@"One"],
            scrollView = [[CPScrollView alloc] initWithFrame:[self bounds]],
            outlineView = [[CPOutlineView alloc] initWithFrame:[self bounds]];

        root = [[MLNavigationComponent alloc] init];
        [root addChild: [[MLNavigationComponent alloc] init]];

        [outlineView addTableColumn:column];
        [outlineView setAllowsMultipleSelection:NO];
        [outlineView setDataSource:self];
        [outlineView setDelegate:self];
        [outlineView setAllowsMultipleSelection:YES];
        [outlineView expandItem:nil expandChildren:YES];
        //[self setRowHeight:50.0];
        //[outlineView setIntercellSpacing:CPSizeMake(0.0, 10.0)]

        [scrollView setDocumentView:outlineView];

        //[self setBackgroundColor:[CPColor colorWithHexString:@"DDE4E4"]];



    }
    return self;
}
@end

/*!
*       PaletteDataSource
*
*               - Datasource to use in Palette View in Form Builder.
*
*/
@implementation MLNavigationView (OutlineViewDataSource)

- (id)outlineView:(CPOutlineView)theOutlineView child:(int)theIndex ofItem:(id)theItem
{
    if (theItem === nil)
    	theItem = [self root];
    return [[theItem children] objectAtIndex:theIndex];
}

- (BOOL)outlineView:(CPOutlineView)theOutlineView isItemExpandable:(id)theItem
{
    if (theItem === nil)
    	theItem = [self root];
    return [[theItem children] count] > 0;
}

- (int)outlineView:(CPOutlineView)theOutlineView numberOfChildrenOfItem:(id)theItem
{
    if (theItem === nil)
        theItem = [self root];
    return [[theItem children] count];
}

- (id)outlineView:(CPOutlineView)anOutlineView objectValueForTableColumn:(CPTableColumn)theColumn byItem:(id)theItem
{
    if (theItem === nil)
    	theItem = [self root];

    return theItem;
}

- (BOOL)outlineView:(CPOutlineView)anOutlineView writeItems:(CPArray)theItems toPasteboard:(CPPasteBoard)thePasteBoard
{
//    _draggedItems = theItems;
//    [thePasteBoard declareTypes:[CustomOutlineViewDragType] owner:self];
//    [thePasteBoard setData:[CPKeyedArchiver archivedDataWithRootObject:theItems] forType:CustomOutlineViewDragType];

    return YES;
}

- (CPDragOperation)outlineView:(CPOutlineView)anOutlineView validateDrop:(id < CPDraggingInfo >)theInfo proposedItem:(id)theItem proposedChildIndex:(int)theIndex
{
    CPLog.debug(@"validate item: %@ at index: %i", theItem, theIndex);

    if (theItem === nil)
        [anOutlineView setDropItem:nil dropChildIndex:theIndex];

    [anOutlineView setDropItem:theItem dropChildIndex:theIndex];

    return CPDragOperationEvery;
}

- (BOOL)outlineView:(CPOutlineView)outlineView acceptDrop:(id < CPDraggingInfo >)theInfo item:(id)theItem childIndex:(int)theIndex
{
    // if (theItem === nil)
    //     theItem = [self menu];
    //
    // // CPLog.debug(@"drop item: %@ at index: %i", theItem, theIndex);
    //
    // var menuIndex = [_draggedItems count];
    //
    // while (menuIndex--)
    // {
    //     var menu = [_draggedItems objectAtIndex:menuIndex];
    //
    //     // CPLog.debug(@"move item: %@ to: %@ index: %@", menu, theItem, theIndex);
    //
    //     if (menu === theItem)
    //         continue;
    //
    //     [menu removeFromMenu];
    //     [theItem insertSubmenu:menu atIndex:theIndex];
    //     theIndex += 1;
    // }
    //
    // return YES;
    return NO;
}


@end
/*!
*           IOFormBuilderPaletteView
*                   -
*
*
*/
@implementation MLNavigationView (OutlineViewDelegate)

- (int)outlineView:(CPOutlineView)outlineView heightOfRowByItem:(id)anItem
{
    return 30;//[anItem heightOfRowByItem];
}

- (BOOL)outlineView:(CPOutlineView)anOutlineView shouldEditTableColumn:(CPTableColumn)aColumn item:(int)aRow
{
    CPLog.trace("......Diego.....");
    return YES;
}
@end

@implementation CPColor (OutlineView)
+ (CPColor)selectionColor
{
        //return [CPColor colorWithPatternImage:[[CPImage alloc]
        //initByReferencingFile:@"Resources/gradient.png" size:CGSizeMake (1,20)]];
        return [CPColor colorWithHexString:@"5f83b9"];
}

+ (CPColor)selectionColorSourceView {
        //return [CPColor colorWithPatternImage:[[CPImage alloc] initByReferencingFile:@"Resources/tableviewselection.png" size:CGSizeMake(6,22)]];
        return [CPColor greenColor];
}

@end

@implementation MLNavigationComponent : CPObject
{
    /*!
    *
    */
    CPMutableArray     children @accessors;
}

- (id)init
{
    if (self = [super init])
    {
		children = [[CPArray alloc] init];
    }
    return self;
}

- (CPString)description
{
    return [super description];
}
-(void)addChild:(MLNavigationComponent)aChildComponent
{
	[children addObject:aChildComponent];
}
@end
