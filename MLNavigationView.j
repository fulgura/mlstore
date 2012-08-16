@import <AppKit/CPView.j>
@import <AppKit/CPTreeNode.j>

var UseCaseGroupHeightOfRow = 20,
    UseCaseHeightOfRow = 16;

@implementation MLNavigationView : CPView
{
    /*!
    *
    */

    CPTreeNode root @accessors;

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
            outlineView = [[CPOutlineView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([self bounds]) - 20 , CGRectGetHeight([self bounds]))];

        [self createDatasource];
        [outlineView setBackgroundColor:[CPColor colorWithHexString:@"e0ecfa"]];
        [scrollView setAutohidesScrollers:YES];

        [column setDataView:[[MLNavigationViewElement alloc] initWithFrame:CGRectMakeZero()]];

        setTimeout(function(){
                    [column setWidth:200];
                },0);

        [outlineView addTableColumn:column];
        [outlineView setHeaderView:nil];
        [outlineView setCornerView:nil];
        [outlineView setAllowsMultipleSelection:NO];
        [outlineView setDataSource:self];
        [outlineView setDelegate:self];
        [outlineView setAllowsMultipleSelection:YES];
        [outlineView expandItem:nil expandChildren:YES];
        //[self setRowHeight:50.0];
        //[outlineView setIntercellSpacing:CPSizeMake(0.0, 10.0)]

        [scrollView setDocumentView:outlineView];

        //[self setBackgroundColor:[CPColor colorWithHexString:@"DDE4E4"]];
        [self addSubview:scrollView];


    }
    return self;
}

-(void)createDatasource
{
    root = [CPTreeNode treeNodeWithRepresentedObject:"Root"];

    var messagesNode = [self createUseCaseTreeNode:"MESSAGES" font:[CPFont boldSystemFontOfSize:12.0] textColor:[CPColor grayColor] heightOfRow:UseCaseGroupHeightOfRow pathForResource:nil];
    var eventsNode = [self createUseCaseTreeNode:"EVENTS" font:[CPFont boldSystemFontOfSize:12.0] textColor:[CPColor grayColor] heightOfRow:UseCaseGroupHeightOfRow pathForResource:nil];
    var sellerNode = [self createUseCaseTreeNode:"SELLER" font:[CPFont boldSystemFontOfSize:12.0] textColor:[CPColor grayColor] heightOfRow:UseCaseGroupHeightOfRow pathForResource:nil];

    var leaveFeedback = [self createUseCaseTreeNode:"Leave Feedback" font:[CPFont boldSystemFontOfSize:10.0] textColor:[CPColor blackColor] heightOfRow:UseCaseHeightOfRow pathForResource:"folder.png"];
    var readyToShip = [self createUseCaseTreeNode:"Ready to ship" font:[CPFont boldSystemFontOfSize:10.0] textColor:[CPColor blackColor] heightOfRow:UseCaseHeightOfRow pathForResource:"smart-folder.png"];
    [[sellerNode mutableChildNodes] addObject:leaveFeedback];
    [[sellerNode mutableChildNodes] addObject:readyToShip];

    var buyerNode = [self createUseCaseTreeNode:"BUYER" font:[CPFont boldSystemFontOfSize:12.0] textColor:[CPColor grayColor] heightOfRow:UseCaseGroupHeightOfRow pathForResource:nil];
    var reportsNode = [self createUseCaseTreeNode:"REPORTS" font:[CPFont boldSystemFontOfSize:12.0] textColor:[CPColor grayColor] heightOfRow:UseCaseGroupHeightOfRow pathForResource:nil];

    [[root mutableChildNodes] addObject:messagesNode];
    [[root mutableChildNodes] addObject:eventsNode];
    [[root mutableChildNodes] addObject:sellerNode];
    [[root mutableChildNodes] addObject:buyerNode];
    [[root mutableChildNodes] addObject:reportsNode];
}

-(CPTreeNode)createUseCaseTreeNode:(CPString)aLabel font:(CPFont)aFont textColor:(CPColor)aColor heightOfRow:(int)aHeightOfRow pathForResource:(CPString)aResourcePath
{
    var representedObject = [[CPDictionary alloc] init];

    [representedObject setValue:aLabel forKey:"label"];
    [representedObject setValue:aFont forKey:"font"];
    [representedObject setValue:aColor forKey:"textColor"];
    [representedObject setValue:aHeightOfRow forKey:"heightOfRow"];

    if(aResourcePath != nil)
    {
        var image = [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:aResourcePath] size:CPSizeMake(16, 16)];
        [representedObject setValue:image forKey:"icon"];
    }

    return  [CPTreeNode treeNodeWithRepresentedObject:representedObject];
}
@end

@implementation MLNavigationView (OutlineViewDataSource)

- (id)outlineView:(CPOutlineView)theOutlineView child:(int)theIndex ofItem:(id)theItem
{
    if (theItem === nil)
    	theItem = [self root];

    return [[theItem childNodes] objectAtIndex:theIndex];
}

- (BOOL)outlineView:(CPOutlineView)theOutlineView isItemExpandable:(id)theItem
{
    if (theItem === nil)
    	theItem = [self root];
    return [[theItem childNodes] count] > 0;
}

- (int)outlineView:(CPOutlineView)theOutlineView numberOfChildrenOfItem:(id)theItem
{
    if (theItem === nil)
        theItem = [self root] ;
    return [[theItem childNodes] count];
}

- (id)outlineView:(CPOutlineView)anOutlineView objectValueForTableColumn:(CPTableColumn)theColumn byItem:(id)theItem
{
    if (theItem === nil)
    	theItem = [self root];

    return [theItem representedObject];
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
    if (theItem === nil)
        [anOutlineView setDropItem:nil dropChildIndex:theIndex];

    [anOutlineView setDropItem:theItem dropChildIndex:theIndex];

    return CPDragOperationEvery;
}

- (BOOL)outlineView:(CPOutlineView)outlineView acceptDrop:(id < CPDraggingInfo >)theInfo item:(id)theItem childIndex:(int)theIndex
{
    return NO;
}


@end
/*!
 *
 *
 *
 */
@implementation MLNavigationView (OutlineViewDelegate)

- (int)outlineView:(CPOutlineView)outlineView heightOfRowByItem:(id)anItem
{
    return [[anItem representedObject] objectForKey:"heightOfRow"];
}

- (BOOL)outlineView:(CPOutlineView)anOutlineView shouldEditTableColumn:(CPTableColumn)aColumn item:(int)aRow
{
    return YES;
}
@end

@implementation MLNavigationViewElement : CPView
{
}

- (void)setObjectValue:(id)anObject
{
    var subviews = [self subviews];
    for (var i=0; i < subviews.length; i++) {
        [subviews[i] removeFromSuperview];
    };


    var icon = [anObject objectForKey:"icon"];

    if(icon != nil)
    {

        var iconView = [[CPImageView alloc] initWithFrame:CGRectMake(0, 0, 16, 16)];
        //[iconView setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable];
        [iconView setHasShadow:NO];
        [iconView setImageScaling:CPScaleProportionally];

        var iconSize = [icon size];
        [iconView setFrameSize:iconSize];
        [iconView setImage:icon];

        [self addSubview:iconView];

        var label = [[CPTextField alloc] initWithFrame:CGRectMake(16, 0, 200 - 16, CGRectGetHeight([self bounds]))];
        [label setAlignment:CPLeftTextAlignment];
        [label setTextColor:[anObject objectForKey:"textColor"]];
        [label setFont:[anObject objectForKey:"font"]];
        [label setStringValue:[anObject objectForKey:"label"]];
        //[label setBackgroundColor:[CPColor grayColor]];

        [self addSubview:label];
        [label sizeToFit];
        console.log([self bounds],[iconView bounds],[label bounds]);

    }
    else
    {
        var label = [[CPTextField alloc] initWithFrame:CGRectMake(10, 0, CGRectGetWidth([self bounds]), CGRectGetHeight([self bounds]))];
        [label setAlignment:CPLeftTextAlignment];
        [label setTextColor:[anObject objectForKey:"textColor"]];
        [label setFont:[anObject objectForKey:"font"]];
        [label setStringValue:[anObject objectForKey:"label"]];

        [self addSubview:label];
        [label sizeToFit];
    }



    [self setNeedsDisplay: YES];
}
@end
