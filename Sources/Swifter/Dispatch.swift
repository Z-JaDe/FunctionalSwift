//
//  Dispatch.swift
//  FunctionalSwift
//
//  Created by ZJaDe on 2018/10/19.
//  Copyright © 2018 zjade. All rights reserved.
//

import Foundation
#if os(Linux)
import Dispatch
#endif

extension Swifter {
    /// ZJaDe: 在延时间隔内 每次调用时自动关闭上次的任务
    public static func debounce(delayBy: DispatchTimeInterval, queue: DispatchQueue = .main, _ function: @escaping (() -> Void)) -> () -> Void {
        var currentWorkItem: DispatchWorkItem?
        return {
            currentWorkItem?.cancel()
            currentWorkItem = DispatchWorkItem(block: function)
            queue.asyncAfter(deadline: .now() + delayBy, execute: currentWorkItem!)
        }
    }
    /// ZJaDe: 单位时间内只执行一次
    public static func throttle(limitTo: DispatchTimeInterval, queue: DispatchQueue = .main, _ function: @escaping (() -> Void)) -> () -> Void {
        var allowFunction: Bool = true
        return {
            guard allowFunction else { return }
            allowFunction = false
            function()
            queue.asyncAfter(deadline: .now() + limitTo, qos: .background) {
                allowFunction = true
            }
        }
    }
    /// ZJaDe: 方法只执行一次 并把结果缓存
    public static func cache<T, E>(_ function: @escaping (T) -> E) -> (T) -> E {
        var result: E?
        return { (params) -> E in
            if let result = result {
                return result
            } else {
                result = function(params)
                return result!
            }
        }
    }
}
