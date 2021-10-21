//
//  Strings+Localisable.swift
//  SpaceXRockets
//
//  Created by Haider Ashfaq on 19/10/2021.
//

import Foundation

extension String {
    
    func localised() -> String {
        return NSLocalizedString(self, comment: self)
    }
    
    public func localised(with arguments: [CVarArg]) -> String {
        return String(format: self.localised(), locale: nil, arguments: arguments)
    }
}
