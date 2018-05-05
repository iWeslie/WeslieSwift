/*:
 * NetworkTools.swift
 * Created by Weslie
 * Copyright © 2017 Weslie. All rights reserved.
 */

/*:
 ## Timers in Swift
 
 ### Timer
 
 > A timer that fires after a certain time interval has elapsed, sending a specified message to a target object.
 
 * Callout(Feature):
 Timers work in conjunction with run loops.\
 Run loops maintain strong references to their timers.\
 A timer is not a real-time mechanism.

 - Important:
 With the effect of run loop, the effective resolution of the time interval is limited to on the order of 50-100 milliseconds.\
 You must always invalidate the timer object yourself to remove the timer from the current run loop(the same thread on which the timer was installed).\
 The timer doesn't attempt to compensate for any missed firings that would have occurred while calling the specified selector or invocation.
 
 * Experiment:
 Most common use. For those needs which do not require strict accuracy or time interval.
 
 */

import UIKit
/// schedule a timer to the current run loop
var timer: Timer? = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
    /// timer block
}
/// Causes the timer's message to be sent to its target.
timer?.fire()
/// Fire the timer at the secheduled date.
timer?.fireDate = Date.init(timeIntervalSinceNow: 1.0)
/// Set the timers tolerance, not accurate relatively when the tolenrance is under 0.1 second.
timer?.tolerance = 0.1
/// Temporarily stop the timer for future use.
timer?.fireDate = Date.distantFuture
/// Fire the timer again.
timer?.fireDate = Date.distantPast
/// Make the timer not affected by the scroll view or any other UI changes.
RunLoop.current.add(timer!, forMode: .commonModes)
/// Stops the timer from ever firing again and requests its removal from its run loop.
/// Once invalidated, timer objects cannot be reused.
/// Set the timer to nil to release the timer object.
timer?.invalidate()
timer = nil



/*:
 
 ### GCD
 
 > DispatchSource provides an interface for monitoring low-level system objects.
 
 * Callout(Feature):
 A dedicated background-queue-friendly timer.\
 Absolutely accurate without the effect of run loop.
 
  - Important:
 If you try and resume/suspend an already resumed/suspended timer, you will get a crash.
 
 */

let gcdTimer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
gcdTimer.schedule(deadline: .now(), repeating: 1.0, leeway: .never)
gcdTimer.setEventHandler {
    /// timer handler
}

/// RepeatingTimer mimics the API of DispatchSourceTimer but in a way that prevents
/// crashes that occur from calling resume multiple times on a timer that is already resumed.
class RepeatingTimer {
    
    /// create a gcd timer object
    private lazy var timer: DispatchSourceTimer = {
        let timer = DispatchSource.makeTimerSource()
        timer.schedule(deadline: .now(), repeating: 3.0, leeway: .never)
        timer.setEventHandler { [weak self] in
            self?.eventHandler?()
        }
        
        return timer
    }()
    
    /// handler for the timer
    var eventHandler: (() -> Void)?
    
    /// timer status enum type
    private enum State {
        case suspended
        case resumed
    }
    /// timer status
    private var state: State = .suspended
    
    /// Prevent deallocation crashes and release timer.
    deinit {
        timer.setEventHandler {}
        timer.cancel()
        
        resume()
        eventHandler = nil
        suspend()
        
    }
    /// resume the timer if it is suspended
    func resume() {
        if state == .suspended {
            state = .resumed
            timer.resume()
        }
    }
    /// Suspend the timer, but the current block being excuted will not suspend.
    /// - Warning:
    func suspend() {
        if state == .resumed {
            state = .suspended
            timer.suspend()
        }
    }
}

/*:
 ### PerformSelector
 
 > Simple way to call a selector method after delay.
 
 * Callout(Feature):
 The same as Timer.
 
 - Important:
 afterDelay will not work in the subThread as there is no run loop in it by default
 
 */

NSObject.perform(<#T##aSelector: Selector##Selector#>, with: <#T##Any?#>, afterDelay: <#T##TimeInterval#>)


/*:
 ### CADisplayLink
 
 > A timer object that allows your application to synchronize its drawing to the refresh rate of the display.
 
 * Callout(Feature):
 Once the display link is associated with a run loop, the selector on the target is called when the screen’s contents need to be updated.\
 You can control a display link's frame rate.
 
 
 */

let displayLink = CADisplayLink(target: <#T##Any#>, selector: <#T##Selector#>)
displayLink.add(to: .current, forMode: .defaultRunLoopMode)



/*:
 ### Runloop
 ### Timer
 ### PerformSelector
 ### CADisplayLink
 ### GCD
 
 */

