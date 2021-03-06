//
//  MaxSubArray.swift
//  LeeCode
//
//  Created by Ocean on 2022/3/19.
//

/*
 给你一个整数数组 nums ，请你找出一个具有最大和的连续子数组（子数组最少包含一个元素），返回其最大和。

 子数组 是数组中的一个连续部分。

 示例 1：
 输入：nums = [-2,1,-3,4,-1,2,1,-5,4]
 输出：6
 解释：连续子数组 [4,-1,2,1] 的和最大，为 6 。
 示例 2：
 输入：nums = [1]
 输出：1
 示例 3：
 输入：nums = [5,4,-1,7,8]
 输出：23

 提示：
 1 <= nums.length <= 105
 -104 <= nums[i] <= 104
 进阶：如果你已经实现复杂度为 O(n) 的解法，尝试使用更为精妙的 分治法 求解。

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/maximum-subarray
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

class MaxSubArray {
    
    // MARK: 最优解
    func maxSubArray(_ nums: [Int]) -> Int {
            var pre = 0
            var maxAns = nums[0]
            for x in nums {
                pre = max(pre + x, x)
                maxAns = max(maxAns, pre)
            }
            return maxAns
        }
    
    // MARK: 动态规划 dp[i]是以num[i]结尾的最大连续子序列的和
    func maxSubArray1(_ nums: [Int]) -> Int {
        guard !nums.isEmpty else { return 0 }
        var dp: [Int] = Array(repeating: 0, count: nums.count)
        var maximum = nums[0]
        dp[0] = nums[0]
        for index in 1 ..< nums.count {
            let pre = dp[index - 1]
            if pre <= 0 {
                dp[index] = nums[index]
            } else {
                dp[index] = pre + nums[index]
            }
            maximum = max(dp[index], maximum)
        }
        
        return maximum
    }
}
