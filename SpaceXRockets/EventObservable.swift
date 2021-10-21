//
//  EventObservable.swift
//  SpaceXRockets
//
//  Created by Haider Ashfaq on 19/10/2021.
//

import Foundation

open class EventObservable<EventType:Hashable>{
    
    public typealias ActionCallback<T> = (T) -> Void
    
    class Action<T>{
        let action: ActionCallback<T>
        let event:EventType
        
        init(with event: EventType, callback: @escaping ActionCallback<T>){
            self.event = event
            self.action = callback
        }
    }
    
    public init(){}
    
    private var targets = NSMapTable<AnyObject, NSMutableArray>.weakToStrongObjects()
    
    public func addAction<T>(for target: AnyObject, event: EventType, callback: @escaping ActionCallback<T>){
        let model = Action(with: event, callback: callback)
        if let callbacks = targets.object(forKey: target){
            callbacks.add(model)
            targets.setObject(callbacks, forKey: target)
        }
        else{
            targets.setObject(NSMutableArray(array: [model]), forKey: target)
        }
    }
    
    public func sendEvent(_ event: EventType){
        sendEvent(event, object: ())
    }
    
    public func sendEvent<Object>(_ event: EventType, object:Object){
        guard let objects = targets
                .objectEnumerator()?
                .allObjects
                .compactMap({$0 as? NSMutableArray}) else{return}
        objects.forEach { (events) in
            events
                .compactMap({$0 as? Action<Object>})
                .filter({$0.event == event})
                .forEach({$0.action(object)})
        }
    }
}
