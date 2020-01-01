{$mode objfpc}
{$modeswitch objectivec1}

unit UAppDelegate;
interface
uses
  iPhoneAll;

type
  TAppDelegate = objcclass(UIResponder, UIApplicationDelegateProtocol)
  private
    window: UIWindow;
  public
    function application_didFinishLaunchingWithOptions(application: UIApplication; launchOptions: NSDictionary): boolean; message 'application:didFinishLaunchingWithOptions:';
    procedure applicationWillResignActive(application: UIApplication); message 'applicationWillResignActive:';
    procedure applicationDidEnterBackground(application: UIApplication); message 'applicationDidEnterBackground:';
    procedure applicationWillEnterForeground(application: UIApplication); message 'applicationWillEnterForeground:';
    procedure applicationDidBecomeActive(application: UIApplication); message 'applicationDidBecomeActive:';
    procedure applicationWillTerminate(application: UIApplication); message 'applicationWillTerminate:';
  end;
  
implementation

function TAppDelegate.application_didFinishLaunchingWithOptions (application: UIApplication; launchOptions: NSDictionary): boolean;
var
  viewController: UIViewController;
  textField: UITextField;
  timeStamp: NSString;
begin
  NSLog(NSSTR('application_didFinishLaunchingWithOptions'));
  timeStamp := NSDateFormatter.localizedStringFromDate_dateStyle_timeStyle(NSDate.date, NSDateFormatterShortStyle, NSDateFormatterFullStyle);

  window := UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds);
  
  viewController := UIViewController.alloc.init;
  
  viewController.view.setBackgroundColor(UIColor.blueColor);

  textField := UITextField.Alloc.init;
  textField.setBackgroundColor(UIColor.greenColor);
  textField.setText(NSSTR('Hello World '+timeStamp.UTF8String));
  textField.setFrame(CGRectMake(10, 200, 300, 20));
  viewController.view.addSubView(textField);
  textField.release;
  
  window.setRootViewController(viewController);
  window.makeKeyAndVisible;
  
  result := true;
end;


procedure TAppDelegate.applicationWillResignActive(application: UIApplication);
begin
end;

procedure TAppDelegate.applicationDidEnterBackground(application: UIApplication);
begin
  NSLog(NSSTR('applicationDidEnterBackground'));
end;

procedure TAppDelegate.applicationWillEnterForeground(application: UIApplication);
begin
  NSLog(NSSTR('applicationWillEnterForeground'));
end;

procedure TAppDelegate.applicationDidBecomeActive(application: UIApplication);
begin
end;

procedure TAppDelegate.applicationWillTerminate(application: UIApplication);
begin
end;

end.