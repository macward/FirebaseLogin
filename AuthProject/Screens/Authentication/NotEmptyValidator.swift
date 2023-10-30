//
//  NotEmptyValidator.swift
//  Modular
//
//  Created by Max Ward on 30/10/2023.
//

import Foundation
import SwiftCommonLibrary

public class NotEmptyValidator: Validatable {
    
    public var errorMessage: String = ""
    public init(errorMessage: String = "") {
        self.errorMessage = errorMessage
    }
    
    public func validate(_ str: String) -> Bool {
        if str.isEmpty {
            errorMessage = "The value is empty"
            return false
        }
        if str.count < 3 {
            errorMessage = "The value should be grather than 3"
            return false
        }
        return true
    }
}
