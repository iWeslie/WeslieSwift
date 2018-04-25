//: Playground - noun: a place where people can play

import UIKit
import Foundation
import CoreFoundation

/// get current run loop
RunLoop.current

/// get main run loop
RunLoop.main

/// main run loop is created automatically in main thread
/// sub thread do not create run loop automatically

/// core fundation run loop, different address(class)
CFRunLoopGetMain()
CFRunLoopGetCurrent()

/// get run loop mode
RunLoop.current.currentMode

/// run loop do not track (default mode)
RunLoopMode.defaultRunLoopMode
CFRunLoopMode.defaultMode

/// run loop track UI when user interacted (e.g. scroll view did scroll)
RunLoopMode.UITrackingRunLoopMode

/// run loop track both mode, placeholder mode (common = default + tracking)
RunLoopMode.commonModes

//: - Important:
//: run loop can only choose one mode when it runs.\
//: mode must have one `timer` or `source` at least.\
//: change mode must exit current mode first and create a new one.

//: ### run mode structrce
//: ![runloop](RunLoop_0.png)

//: > ### Timer is affected by RunLoop
Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (_) in
    /// timer will be schedled on the current run loop in the default mode
    /// it will not run when it is not initialized in the main thread which did
    /// not created a run loop manually
}

//: > ### GCD is not affected by RunLoop

/// make a strong reference to avoid the timer falling out of scope
var gcdTimer: DispatchSourceTimer?
/// GCD Timer is absolute accurate
func startGcdTimer() {
    let queue = DispatchQueue(label: "com.playground.timer.GcdTimer", attributes: .concurrent)
    /// cancel previous timer if any
    gcdTimer?.cancel()
    
    gcdTimer = DispatchSource.makeTimerSource(queue: queue)

    /// `never` means absolute accurate
    gcdTimer?.schedule(deadline: .now(), repeating: .seconds(5), leeway: .never)
    
    gcdTimer?.setEventHandler(handler: {
        print(Date())
    })
    
    gcdTimer?.resume()
    
}

func stopGcdTimer() {
    gcdTimer?.cancel()
    gcdTimer = nil
}

/// add observe, timer, source to run loop
RunLoop.current.add(Port.init(), forMode: .defaultRunLoopMode)
let aTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (_) in
    
}
RunLoop.current.add(aTimer, forMode: .defaultRunLoopMode)

//: ## Background Thread

class ThreadTest: NSObject {
    /// make a strong reference to avoid the thread being terminated
    var aThread: Thread?
    /// initialize the thread and start it
    func initThread() {
        self.aThread = Thread.init(target: self, selector: #selector(run), object: nil)
        aThread?.start()
    }
    /// launch the run loop
    @objc func run() {
        autoreleasepool {
            /// add port to initialize the lazy var current run loop
            RunLoop.current.add(Port.init(), forMode: .defaultRunLoopMode)
            /// launch the aThread run loop
            RunLoop.current.run()
            /// aThread will exist contiously
        }
    }
    
    func performTask() {
        precondition(aThread != nil)
        /// ask aThread to do something
        self.perform(#selector(task), on: self.aThread!, with: nil, waitUntilDone: true)
    }
    
    @objc func task() {
        print("task")
    }
}

