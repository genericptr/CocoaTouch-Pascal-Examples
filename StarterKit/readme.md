## Requirements

- ARM and iPhone Simulator compilers
  - download at https://freepascal.org/down/i386/macosx.var or build from trunk using the *ppcarm.command* script which is included in the repo.
- Objective Pascal iOS Headers
  - git clone https://github.com/genericptr/iOS_8_0.git (the makefile expects this to be in the same directory but you probably want to change this to be a standard location). Currently stable FPC releases don't come with iPhoneAll.pas.
- ios-deploy
  ```
  sudo npm uninstall -g ios-deploy  
  brew install ios-deploy
  ```
  - https://github.com/ios-control/ios-deploy
  
## About

The makefile has one target or launching on the simulator (**iphonesim**) and another target for deploying to an iOS device (**iphoneos**).

In the Xcode project **Build Phases > Run Script** injects FPC binary into the .app bundle after Xcode does the steps for code signing. 

## Launching in Simulator.app

The makefile target **launch** runs the following commands which use Xcode build tools to install the .app bundle on the currently booted device. 

  open -a Simulator.app
  xcrun simctl terminate booted ${BUNDLE_ID}
  xcrun simctl install booted ${BUNDLE}
  xcrun simctl launch booted ${BUNDLE_ID}
  tail -f `xcrun simctl getenv booted SIMULATOR_LOG_ROOT`/system.log

## Deploying to device

Deploying to a device without opening Xcode requires the aforementioned ios-deploy and xcodebuild (which is handled in the **iphoneos** target in the makefile).

The **deploy** makefile target simply calls the command below and starts the LLDB debugger.

  ios-deploy --debug --bundle ${XCODE_DEPLOY_PRODUCT}

## Xcode project template

Because dealing with code signing and provisioning is so complicated it's best to let Xcode do this for you. For future use an empty template project called **__XCODE_RROJECT_TEMPLATE** is contained in the repo. 

To use the template copy the directory to a new location and replace all instances of the following words (in all file names and file contents) which names which match your current project.

- __FPCPROJ_NAME
- __FPCPROJ_ORG_NAME
- __FPCPROJ_BUNDLE_IDENTIFIER
- __FPCPROJ_SHELL_SCRIPT

## FAQ

- *"error: process launch failed: Security"* from iOS-deploy. In your device go to **Settings > General > Device Management** and give permission to the developer profile.

- *"No code signature found."* from iOS-deploy. The **iphoneos** makefile target calls **touch** on the *hello.app/_CodeSignature* file which lets the code sign tool know to replace it but if this fails you may need to delete the _CodeSignature directory manually.