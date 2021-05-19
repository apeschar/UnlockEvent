import Foundation
import Cocoa

let unlockScript = NSAppleScript(source: """
    tell application "Keyboard Maestro Engine"
        do script "D00E7CCF-0E8E-40D0-88B2-7106C0AB6D84"
    end tell
""")!

func main() {
    let dnc = DistributedNotificationCenter.default()

    dnc.addObserver(
        forName: .init("com.apple.screenIsUnlocked"),
        object: nil,
        queue: .main
    ) {
        notification in
        NSLog("Screen was unlocked")
        runMacro()
    }
    
    NSLog("Start loop")
    RunLoop.main.run()
}

func runMacro() {
    var error: NSDictionary?
    unlockScript.executeAndReturnError(&error)
    if error != nil {
        NSLog("Couldn't run AppleScript: \(error)")
    }
}

main()
