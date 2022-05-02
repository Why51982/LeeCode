//
//  Permute.swift
//  LeeCode
//
//  Created by Ocean on 2022/5/2.
//
/*
 给定一个不含重复数字的数组 nums ，返回其 所有可能的全排列 。你可以 按任意顺序 返回答案。

 示例 1：
 输入：nums = [1,2,3]
 输出：[[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]
 示例 2：
 输入：nums = [0,1]
 输出：[[0,1],[1,0]]
 示例 3：
 输入：nums = [1]
 输出：[[1]]

 提示：
 1 <= nums.length <= 6
 -10 <= nums[i] <= 10
 nums 中的所有整数 互不相同

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/permutations
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

// MARK: 优化空间复杂度，对自己进行数据交换位置
class Permute {
    func permute(_ nums: [Int]) -> [[Int]] {
        
        // 记录最终结果
        var results: [[Int]] = []
        // 记录深度遍历一次的结果
        var element: [Int] = []
        element = nums
        dfs(0, &results, nums, &element)
        return results
    }
    
    private func dfs(_ index: Int, _ results: inout [[Int]], _ nums: [Int], _ element: inout [Int]) {
        
        if index == nums.count {
            results.append(element)
            return
        }
        
        // 每次的 nums 都是从头遍历
        for i in index ..< nums.count {
            // 交换
            swap(index, i, &element)
            
            // 此index要接着dfs代表下一次的一个数组组合
            dfs(index + 1, &results, nums, &element)
            
            // 还原现场
            swap(i, index, &element)
        }
    }
    
    private func swap(_ i: Int, _ j: Int, _ nums: inout [Int]) {
        let temp = nums[i]
        nums[i] = nums[j]
        nums[j] = temp
    }
}

// MARK: 正常的深度优先搜索
extension Permute {
    func permute1(_ nums: [Int]) -> [[Int]] {
        
        // 记录最终结果
        var results: [[Int]] = []
        // 记录深度遍历一次的结果
        var element: [Int] = []
        // 记录数据是否使用过
        var used: [Bool] = Array(repeating: false, count: nums.count)
        dfs1(0, &results, nums, &element, &used)
        return results
    }
    
    private func dfs1(_ index: Int, _ results: inout [[Int]], _ nums: [Int], _ element: inout [Int], _ used: inout [Bool]) {
        
        if index == nums.count {
            results.append(element)
            return
        }
        
        // 每次的 nums 都是从头遍历
        for i in 0 ..< nums.count {
            if used[i] { continue }
            element.append(nums[i])
            used[i] = true
            
            // 此index要接着dfs代表下一次的一个数组组合
            dfs1(index + 1, &results, nums, &element, &used)
            
            // 还原现场
            element.removeLast()
            used[i] = false
        }
    }
}
