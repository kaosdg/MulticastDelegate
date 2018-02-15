//
//  MulticastDelegate.swift
//  MulticastDelegate
//
//  Created by Catigbe, Karl on 5/2/17.
//  Copyright © 2017 Karl Catigbe. All rights reserved.
//

import Foundation

/**
    MulticastDelegate - A linked list of delegates, also called an invocation list.
    
    - When a multicast delegate is invoked, the delegates in the list are called synchronously in the order in which they've been added to the delegate table.
 
    - Delegate invocation will run on the caller's thread.
 
*/
public class MulticastDelegate<T> {
    public typealias Delegate = T
    private var delegates: NSHashTable<AnyObject>
    
    
    //MARK: - Initializers
    
    /**
        Initializes the MulticastDelegate
    */
    public init(strongReference: Bool = false) {
        delegates = strongReference ? NSHashTable<AnyObject>() : NSHashTable<AnyObject>.weakObjects()
    }
    
    //MARK: - Properties
    
    /**
        An array of `T` representing all currently added delegates.
    */
    public var allDelegates: [Delegate] {
        return delegates.allObjects as! [Delegate]
    }
    
    /**
        `true` if there are no delegates contained in the delegate table.
    */
    public var isEmpty: Bool {
        return allDelegates.count == 0
    }
    
    //MARK: - Public API
    
    //MARK: Data accessors
    
    internal func contains(_ delegate: Delegate) -> Bool {
        return delegates.contains(delegate as AnyObject)
    }
    
    //MARK: Adding and removing delegates
    /**
        Adds a delegate `T` to the delegate table.
     
        - parameter delegate: The delegate, conforming to `T`, that should be added.
     
    */
    public func add(_ delegate: Delegate) {
        delegates.add(delegate as AnyObject)
    }
    
    /**
        Removes a delegate `T` from the delegate table.
     
        - parameter delegate: The delegate, conforming to `T`, that should be removed.
    */
    public func remove(_ delegate: Delegate) {
        delegates.remove(delegate as AnyObject)
    }
    
    /**
     Convenience operator overload for `add()`
     - parameter left: The instance of `MulticastDelegate` that `right` will be added to.
     - parameter right: The delegate, conforming to `T`, that will be added o `left`.
     */
    static public func +=(left: MulticastDelegate<Delegate>, right: Delegate) {
        left.add(right)
    }
    
    /**
     Convenience operator overload for `remove()`
     - parameter left: The instance of `MulticastDelegate` that `right` will be removed from.
     - parameter right: The delegate, conforming to `T`, that will be removed from `right`.
     */
    static public func -=(left: MulticastDelegate<Delegate>, right: Delegate) {
        left.remove(right)
    }

    /**
        Removes all delegates from the delegate table.
    */
    public func removeAll() {
        delegates.removeAllObjects()
//        delegates = NSHashTable<AnyObject>.weakObjects()
    }
    
    
    //MARK: Invoking delegate methods
    /**
        Invokes the closure on each delegate in the delegate table.
        
        - parameter invocation: The closure to execute.
    */
    public func invoke(_ invocation: (Delegate) -> ()) {
        let _ = allDelegates.map { invocation($0) }
    }
    
    /**
         Convenience operator overload for `invoke()`
         - parameter left: The instance of `MulticastDelegate` that `right` be executed against.
         - parameter right: The invocation closure to be executed.
    */
    public static func ~>(left: MulticastDelegate<Delegate>, right: (Delegate) -> ()) {
        left.invoke(right)
    }
    
}
