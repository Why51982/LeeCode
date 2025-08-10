//
//  CanPlaceFlowers.swift
//  LeeCode
//
//  Created by Ocean on 2025/8/10.
//
// https://leetcode.cn/problems/can-place-flowers/description/?envType=study-plan-v2&envId=leetcode-75
//假设有一个很长的花坛，一部分地块种植了花，另一部分却没有。可是，花不能种植在相邻的地块上，它们会争夺水源，两者都会死去。
//
//给你一个整数数组 flowerbed 表示花坛，由若干 0 和 1 组成，其中 0 表示没种植花，1 表示种植了花。另有一个数 n ，能否在不打破种植规则的情况下种入 n 朵花？能则返回 true ，不能则返回 false 。
//
// 
//
//示例 1：
//
//输入：flowerbed = [1,0,0,0,1], n = 1
//输出：true
//示例 2：
//
//输入：flowerbed = [1,0,0,0,1], n = 2
//输出：false
// 
//
//提示：
//
//1 <= flowerbed.length <= 2 * 104
//flowerbed[i] 为 0 或 1
//flowerbed 中不存在相邻的两朵花
//0 <= n <= flowerbed.length

import Foundation

class CanPlaceFlowers {
    func canPlaceFlowers(_ flowerbed: [Int], _ n: Int) -> Bool {
        if flowerbed.isEmpty {
            return false
        }
        
        let startFlower = flowerbed[0]
        
        if 1 == flowerbed.count {
            if 0 == n {
                return true
            }
            
            if 0 == startFlower {
                return n <= 1
            }
            
            if 1 == startFlower {
                return n == 0
            }
        }
        
        var canFlowerNum = 0
        let totalIndex = flowerbed.count - 1
        var copyFlowerbed = flowerbed
        
        // [0, 0]开头
        if 0 == startFlower, copyFlowerbed[1] == 0 {
            canFlowerNum += 1
            copyFlowerbed[0] = 1
        }
        
        for index in 1 ..< totalIndex {
            let preFlower = copyFlowerbed[index - 1]
            let nextFlower = copyFlowerbed[index + 1]
            let flower = copyFlowerbed[index]
            
            if flower == 0, preFlower == 0, nextFlower == 0 {
                canFlowerNum += 1
                copyFlowerbed[index] = 1
            }
        }
        
        // [0 0]结尾
        if let flower = copyFlowerbed.last, copyFlowerbed[totalIndex - 1] == 0, flower == 0 {
            canFlowerNum += 1
        }
        
        return n <= canFlowerNum
    }
}
