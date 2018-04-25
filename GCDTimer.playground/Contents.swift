/*:
 * NetworkTools.swift
 * Created by Weslie
 * Copyright © 2017 Weslie. All rights reserved.
 */

/*:
 ## Swift Timer
 
 ### Timer
 
 > A timer that fires after a certain time interval has elapsed, sending a specified message to a target object.
 
 * Callout(Feature):
 Timers work in conjunction with run loops.\
 Run loops maintain strong references to their timers.\
 A timer is not a real-time mechanism.

 - Important:
 With the effect of run loop, the effective resolution of the time interval is limited to on the order of 50-100 milliseconds.
 
 * Experiment:
 Most common use. For those needs which do not require strict accuracy or time interval.
 
 */

import UIKit
/// schedule a timer
//Timer.scheduledTimer(timeInterval: 0.1, invocation: NSInvocation, repeats: <#T##Bool#>)


