//
//  Chunk.swift
//  AppExtension
//
//  Created by 郑军铎 on 2018/10/18.
//  Copyright © 2018 ZJaDe. All rights reserved.
//

import Foundation

extension Collection {
    /// ZJaDe: 根据 size 把 Collection 拆分
    public func chunk(_ size:Int) -> AnySequence<SubSequence> {
        var temp = self.dropFirst(0)
        return AnySequence { () -> AnyIterator<SubSequence> in
            return AnyIterator({
                guard temp.count > 0 else { return nil }
                defer { temp = temp.dropFirst(size) }
                return temp.prefix(size)
            })
        }
    }
    /// ZJaDe: 根据 sizes 把 Collection 拆分
    public func chunk(_ sizes:[Int]) -> AnySequence<SubSequence> {
        var temp = self.dropFirst(0)
        var sizeIterator = sizes.makeIterator()
        return AnySequence { () -> AnyIterator<SubSequence> in
            return AnyIterator({
                guard temp.count > 0 else { return nil }
                if let size = sizeIterator.next() {
                    defer { temp = temp.dropFirst(size) }
                    return temp.prefix(size)
                }else {
                    defer { temp = temp.dropFirst(temp.count) }
                    return temp
                }
            })
        }
    }
}
