//
//  Bindable.swift
//  RandomUser
//
//  Created by Efrén Pérez Bernabe on 23/03/21.
//

import Foundation

/* Generic bindable class
 This class will handle to bind and unbind the view model data with views
 It will use Listener to listen and do the binding and unbinding
 */
class Bindable<T> {
    
    typealias Listener = ((T) -> Void)
    
    var listener: Listener?

    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ v: T) {
        self.value = v
    }

    func bind(_ listener: Listener?) {
        self.listener = listener
    }

    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }

}
