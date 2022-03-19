//
//  LIS.swift
//  LeeCode
//
//  Created by Ocean on 2022/3/19.
//

/*
 给你一个整数数组 nums ，找到其中最长严格递增子序列的长度。

 子序列 是由数组派生而来的序列，删除（或不删除）数组中的元素而不改变其余元素的顺序。例如，[3,6,2,7] 是数组 [0,3,1,6,2,2,7] 的子序列。

  
 示例 1：
 输入：nums = [10,9,2,5,3,7,101,18]
 输出：4
 解释：最长递增子序列是 [2,3,7,101]，因此长度为 4 。
 示例 2：
 输入：nums = [0,1,0,3,2,3]
 输出：4
 示例 3：
 输入：nums = [7,7,7,7,7,7,7]
 输出：1
 提示：
 1 <= nums.length <= 2500
 -104 <= nums[i] <= 104

 进阶：
 你能将算法的时间复杂度降低到 O(n log(n)) 吗?

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/longest-increasing-subsequence
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

class LIS {
    // MARK: 最优解
    func lengthOfLIS(_ nums: [Int]) -> Int {
        var dp: [Int] = []
        
        for num in nums {
            if dp.isEmpty || num > dp.last! {
                dp.append(num)
            } else {
                // 二分查找 https://www.cnblogs.com/kyoner/p/11080078.html
                var i = 0
                var j = dp.count
                
                while i < j {
                    let m = (i + j) / 2
                    if dp[m] < num {
                        i = m + 1
                    } else {
                        j = m
                    }
                }
                dp[i] = num
            }
        }
        return dp.count
        
    }
    
    // MARK: 动态规划 dp[i]是以num[i]结尾的最长上升子序列的长度
    func lengthOfLIS1(_ nums: [Int]) -> Int {
        var dp: [Int] = Array(repeating: 1, count: nums.count)
        dp[0] = 1
        var maximum = 1
        for index in 1 ..< nums.count {
            for j in 0 ..< index {
                if nums[index] <= nums[j] { continue }
                dp[index] = max(dp[index], dp[j] + 1)
            }
            maximum = max(dp[index], maximum)
        }
        return maximum
    }
}
