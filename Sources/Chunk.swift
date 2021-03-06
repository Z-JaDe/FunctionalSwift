//
//  Chunk.swift
//  AppExtension
//
//  Created by ZJaDe on 2018/10/18.
//  Copyright © 2018 ZJaDe. All rights reserved.
//

import Foundation

extension Collection {
    /// ZJaDe: 根据 size 把 Collection 拆分 相当于 chunk(size, 0)
    public func chunk(_ size: UInt) -> AnySequence<SubSequence> {
        return AnySequence { () -> AnyIterator<SubSequence> in
            var temp = self.dropFirst(0)
            let size = Int(size)
            return AnyIterator({
                guard temp.isEmpty == false else { return nil }
                let size: Int = size > 0 ? size : temp.count
                defer { temp = temp.dropFirst(size) }
                return temp.prefix(size)
            })
        }
    }

    /** ZJaDe:
        根据 sizes 把 Collection 拆分,
        如果数组里面有 0：
            如果 0 不在数组末尾，对应位置相当于数组上一个有效元素
            如果 0 在数组末尾，数组后面都以数组最后一个元素有效元素拆分
            如果找不到上一个有效元素，返回整个剩余集合;
        例子："11111".chunk([1,2,0]) == ["1","11","11"]
             "11111".chunk([1,0,2]) == ["1","1","11","1"]
             "11111".chunk([0]) == ["11111"]
             "11111".chunk([1]) == ["1","1111"]
             "11111".chunk([1,0]) == ["1", "1", "1", "1", "1"]
     */
    public func chunk(sizes: [UInt]) -> AnySequence<SubSequence> {
        return AnySequence { () -> AnyIterator<SubSequence> in
            var temp = self.dropFirst(0)
            var sizeIterator = sizes.makeIterator()
            var preSize: Int?
            return AnyIterator({
                guard temp.isEmpty == false else { return nil }
                let size: Int = {
                    if let tempSize = sizeIterator.next() {
                        return tempSize > 0 ? Int(tempSize) : preSize
                    } else {
                        return sizes.last.flatMap({$0 > 0 ? nil : preSize})
                    }
                }() ?? temp.count
                defer {
                    temp = temp.dropFirst(size)
                    preSize = size
                }
                return temp.prefix(size)
            })
        }
    }
    /// ZJaDe: 详见 chunk(_ sizes:[UInt])
    public func chunk(sizes: UInt...) -> AnySequence<SubSequence> {
        return chunk(sizes: sizes)
    }
}
