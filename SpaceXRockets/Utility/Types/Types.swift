//
//  Types.swift
//  SpaceXRockets
//
//  Created by Haider Ashfaq on 19/10/2021.
//

import Foundation
import UIKit

typealias ErrorHandler = (Error) -> Void
typealias ModelCallback<T> = (T) -> Void
typealias VoidCallback = () -> Void
typealias AlertActionHandler = (UIAlertAction) -> Void
typealias ModelReturnCallback<T> = () -> T

