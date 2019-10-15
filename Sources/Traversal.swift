//
//  Traversal.swift
//  FunctionalSwift
//
//  Created by ZJaDe on 2018/10/19.
//  Copyright © 2018 zjade. All rights reserved.
//

import Foundation

extension Sequence {
    public typealias Pair = (Element, Element)
    /// ZJaDe: 遍历序列 每次取相邻的两个元素
    public func eachPair() -> AnySequence<Pair> {
        return AnySequence({ () -> AnyIterator<Pair> in
            var iterator = self.makeIterator()
            guard var previous = iterator.next() else { return AnyIterator { return nil } }
            return AnyIterator {
                guard let next = iterator.next() else { return nil }
                defer { previous = next }
                return (previous, next)
            }
        })
    }
}
extension Sequence where Element == Bool {
    public func isTrue() -> Bool {
        return allSatisfy({$0})
    }
}

extension Sequence {
    /// ZJaDe: 元素出现的频率
    public func frequencies<T>(_ function: (Element) -> T) -> [T: Int] {
        return self.reduce(into: [T: Int](), { (counts, element) in
            counts[function(element), default: 0] += 1
        })
    }
}
