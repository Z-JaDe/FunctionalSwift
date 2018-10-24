//
//  Traversal.swift
//  FunctionalSwift
//
//  Created by 郑军铎 on 2018/10/19.
//  Copyright © 2018 zjade. All rights reserved.
//

import Foundation

extension Sequence {
    public typealias Pair = (Element, Element)
    /// ZJaDe: 遍历序列 每次取相邻的两个元素
    public func eachPair() -> AnySequence<Pair> {
        var iterator = self.makeIterator()
        guard var previous = iterator.next() else { return AnySequence([]) }
        return AnySequence({ () -> AnyIterator<Pair> in
            return AnyIterator({
                guard let next = iterator.next() else { return nil }
                defer { previous = next }
                return (previous, next)
            })
        })
    }
    /// ZJaDe: 序列中所有元素都满足 function返回true 时 返回结果为true
    public func all(_ function: (Element) -> Bool) -> Bool {
        // ZJaDe: 语解 找不到一个元素为false时说明所有元素都为true
        return contains(where: {function($0) == false}) == false
    }
    /// ZJaDe: 序列中至少一个元素满足 function返回true 时 返回结果为true
    public func any(_ function: (Element) -> Bool) -> Bool {
        return contains(where: function)
    }
}
extension Sequence where Element == Bool {
    public func isTrue() -> Bool {
        return all({$0})
    }
}

extension Sequence {
    /// ZJaDe: 元素出现的频率
    public func frequencies<T>(_ function: (Element) -> T) -> [T:Int] {
        return self.reduce(into: [T:Int](), { (counts, element) in
            counts[function(element), default: 0] += 1
        })
    }
}
