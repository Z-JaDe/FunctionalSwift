//
//  At.swift
//  AppExtension
//
//  Created by 郑军铎 on 2018/10/18.
//  Copyright © 2018 ZJaDe. All rights reserved.
//

import Foundation

extension Collection {
    /// ZJaDe: 根据 indexes 获取对应元素
    func at(_ indexes:Int...) -> [Element] {
        return self.at(indexes)
    }
    /// ZJaDe: 根据 indexes 获取对应元素
    func at(_ indexes:[Int]) -> [Element] {
        return self.enumerated().filter({indexes.contains($0.offset)}).map({$0.element})
    }
}
extension Collection where Element:Equatable {
    /// ZJaDe: 删除 包含在 values 中的元素
    func pull(_ values:Element...) -> [Element] {
        return self.pull(values)
    }
    /// ZJaDe: 删除 包含在 values 中的元素
    func pull(_ values:[Element]) -> [Element] {
        return self.filter({!values.contains($0)})
    }
    /// ZJaDe: 根据 indexes 删除对应元素
    func pullAt(_ indexes:Int...) -> [Element] {
        return self.pullAt(indexes)
    }
    /// ZJaDe: 根据 indexes 删除对应元素
    func pullAt(_ indexes:[Int]) -> [Element] {
        return self.enumerated().filter({!indexes.contains($0.offset)}).map({$0.element})
    }
}
