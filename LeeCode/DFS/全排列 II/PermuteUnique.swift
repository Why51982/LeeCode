//
//  PermuteUnique.swift
//  LeeCode
//
//  Created by Ocean on 2022/5/3.
//

/*
 给定一个可包含重复数字的序列 nums ，按任意顺序 返回所有不重复的全排列。

 示例 1：
 输入：nums = [1,1,2]
 输出：
 [[1,1,2],
  [1,2,1],
  [2,1,1]]
 示例 2：
 输入：nums = [1,2,3]
 输出：[[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]

 提示：
 1 <= nums.length <= 8
 -10 <= nums[i] <= 10

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/permutations-ii
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

class PermuteUnique {
    func permuteUnique(_ nums: [Int]) -> [[Int]] {
        // 保存结果
        var results: [[Int]] = []
        // 保存每一次深度遍历的结果
        var elements = nums
        dfs(0, nums, &elements, &results)
        return results
    }
    
    /// 深度优化搜索
    private func dfs(_ index: Int, _ nums: [Int], _ elements: inout [Int], _ results: inout [[Int]]) {
        if index == nums.count {
            results.append(elements)
            return
        }
        
        for i in index ..< nums.count  {
            
            //  如果前面有重复就不交换
            if hasRepeat(elements, index, i) { continue }
            
            // 交换数据
            swap(&elements, index, i)
            
            dfs(index + 1, nums, &elements, &results)
            
            // 还原现场
            swap(&elements, index, i)
        }
    }
    
    /// 判断是否有重复
    private func hasRepeat(_ nums: [Int], _ index: Int, _ j: Int) -> Bool {
        for i in index ..< j {
            if nums[i] == nums[j] {
                return true
            }
        }
        return false
    }
    
    /// 交换两个位置
    private func swap(_ nums: inout [Int], _ i: Int, _ j: Int) {
        let temp = nums[i]
        nums[i] = nums[j]
        nums[j] = temp
    }
}
