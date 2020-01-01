{$mode objfpc}
{$modeswitch objectivec1}

program hello;
uses
  iPhoneAll,
  UAppDelegate;

var
  pool: NSAutoreleasePool;
begin
  pool := NSAutoreleasePool.alloc.init;
  UIApplicationMain(argc, pchar(argv), nil, NSSTR('TAppDelegate'));
  pool.release;
end.

