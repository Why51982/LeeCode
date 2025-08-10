//
//  ProductExceptSelf.swift
//  LeeCode
//
//  Created by Ocean on 2025/8/10.
//
// https://leetcode.cn/problems/product-of-array-except-self/description/?envType=study-plan-v2&envId=leetcode-75
//中等
//
//相关标签
//premium lock icon
//相关企业
//
//提示
//给你一个整数数组 nums，返回 数组 answer ，其中 answer[i] 等于 nums 中除 nums[i] 之外其余各元素的乘积 。
//
//题目数据 保证 数组 nums之中任意元素的全部前缀元素和后缀的乘积都在  32 位 整数范围内。
//
//请 不要使用除法，且在 O(n) 时间复杂度内完成此题。
//
// 
//
//示例 1:
//
//输入: nums = [1,2,3,4]
//输出: [24,12,8,6]
//示例 2:
//
//输入: nums = [-1,1,0,-3,3]
//输出: [0,0,9,0,0]
// 
//
//提示：
//
//2 <= nums.length <= 105
//-30 <= nums[i] <= 30
//输入 保证 数组 answer[i] 在  32 位 整数范围内

import Foundation

class ProductExceptSelf {
    func productExceptSelf(_ nums: [Int]) -> [Int] {
        var result = Array(repeating: 1, count: nums.count)
        
        let count = nums.count
        
        // i 前面所有数乘积
        var prefix = 1
        for index in 0 ..< count {
            result[index] = prefix
            prefix *= nums[index]
        }
        
        // i 后面所有数乘积
        var suffix = 1
        for index in (0 ..< count).reversed() {
            result[index] *= suffix
            suffix *= nums[index]
        }
        
        return result
    }
    
    func productExceptSelf1(_ nums: [Int]) -> [Int] {
        var prefix = Array(repeating: 1, count: nums.count)
        var suffix = Array(repeating: 1, count: nums.count)
        var result = Array(repeating: 0, count: nums.count)
        
        for i in 1 ..< nums.count {
            prefix[i] = prefix[i - 1] * nums[i - 1]
        }
        
        for i in (0 ..< nums.count - 1).reversed() {
            suffix[i] = suffix[i + 1] * nums[i + 1]
        }
        
        for i in 0 ..< result.count {
            result[i] = prefix[i] * suffix[i]
        }
        
        return result
    }
}
