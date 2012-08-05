require("browser/xhr").XMLHttpRequest

@implementation MLSiteTest : OJTestCase

- (void)testThatSomeTestWorks
{

  var request = [CPURLRequest requestWithURL: "https://api.mercadolibre.com/sites/MLA/search?q=ipod"];
  var data = [CPURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
  var str = [data description];
  CPLog.info(data);
  [self assertTrue:YES];
}

@end
