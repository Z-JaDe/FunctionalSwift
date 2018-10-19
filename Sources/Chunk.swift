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
    func chunk(_ size:Int) -> [Self.SubSequence] {
        var result = [Self.SubSequence]()
        var temp = self.dropFirst(0)
        while temp.count > 0 {
            result.append(temp.prefix(size))
            temp = temp.dropFirst(size)
        }
        return result
    }
    /// ZJaDe: 根据 sizes 把 Collection 拆分
    func chunk(_ sizes:[Int]) -> [Self.SubSequence] {
        var result = [Self.SubSequence]()
        var temp = self.dropFirst(0)
        for size in sizes {
            guard temp.count > 0 else {
                break
            }
            result.append(temp.prefix(size))
            temp = temp.dropFirst(size)
        }
        return result
    }
}
