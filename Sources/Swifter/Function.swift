//
//  Function.swift
//  FunctionalSwift
//
//  Created by ZJaDe on 2018/10/19.
//  Copyright © 2018 zjade. All rights reserved.
//

import Foundation

extension Swifter {
    /// ZJaDe: functions从头到尾执行一次
    open class func compose<T>(_ functions: ((T) -> T)...) -> (T) -> T {
        return { (result: T) -> T in
            return functions.reduce(result, { $1($0)})
        }
    }
    /// ZJaDe: 把参数绑定 返回一个无参函数
    open class func bind<T, E>(_ function: @escaping (T) -> E, parameters: T) -> () -> E {
        return { function(parameters) }
    }
    /// ZJaDe: 绑定部分参数，返回包含剩余参数的函数
    open class func partial<T1, T2, E>(_ function: @escaping (T1, T2) -> E, parameters: T1) -> (T2) -> E {
        return { function(parameters, $0) }
    }
    /// ZJaDe: 绑定部分参数，返回包含剩余参数的函数
    open class func partial<T1, T2, E>(_ function: @escaping (T1, T2) -> E, parameters: T2) -> (T1) -> E {
        return { function($0, parameters) }
    }
}
