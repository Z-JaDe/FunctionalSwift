//
//  Operator.swift
//  FunctionalSwift
//
//  Created by 郑军铎 on 2018/10/19.
//  Copyright © 2018 zjade. All rights reserved.
//

import Foundation

infix operator ???: NilCoalescingPrecedence

public func ??? <T>(optional: T?, defaultValue: @autoclosure () -> String) -> String {
    return optional.map { "\($0)" } ?? defaultValue()
}

infix operator <-
public func <- <T, E>(_ function: @escaping (T) -> E, parameters: T) -> () -> E {
    return Swifter.bind(function, parameters: parameters)
}
