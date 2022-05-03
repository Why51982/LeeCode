//
//  ThreeSum.swift
//  LeeCode
//
//  Created by Ocean on 2022/5/4.
//
/*
 给你一个包含 n 个整数的数组 nums，判断 nums 中是否存在三个元素 a，b，c ，使得 a + b + c = 0 ？请你找出所有和为 0 且不重复的三元组。

 注意：答案中不可以包含重复的三元组。
 示例 1：
 输入：nums = [-1,0,1,2,-1,-4]
 输出：[[-1,-1,2],[-1,0,1]]
 示例 2：
 输入：nums = []
 输出：[]
 示例 3：
 输入：nums = [0]
 输出：[]

 提示：
 0 <= nums.length <= 3000
 -105 <= nums[i] <= 105

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/3sum
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

class ThreeSum {
    func threeSum(_ nums: [Int]) -> [[Int]] {
        // 异常判断
        if nums.isEmpty || nums.count < 3 {
            return []
        }
        
        var results: [[Int]] = []
        // 排序
        let sorts = nums.sorted()
        
        // 运用三个参数记录他们的位置
        // 开始left记录i + 1
        // right 记录 nums.count - 1
        // 然后相加跟0比较， 比零大就右移right，比零小就左移left
        
        for index in 0 ... sorts.count - 3 {
            // 去重
            let currentNum = sorts[index]
            if index > 0, currentNum == sorts[index - 1] {
                continue
            }
            
            var left = index + 1
            var right = sorts.count - 1
            while left < right {
                if currentNum + sorts[left] + sorts[right] > 0 {
                    right -= 1
                } else if currentNum + sorts[left] + sorts[right] < 0 {
                    left += 1
                } else {
                    
                    // 去重
                    while left < right, sorts[left] == sorts[left + 1] {
                        left += 1
                    }
                    
                    while left < right, sorts[right] == sorts[right - 1] {
                        right -= 1
                    }
                    
                    var result: [Int] = []
                    result.append(currentNum)
                    result.append(sorts[left])
                    result.append(sorts[right])
                    results.append(result)
                    left += 1
                    right -= 1
                }
            }
        }
        
        return results
    }
}

// MARK: 最优解思路一致
extension ThreeSum {
    func threeSum1(_ nums: [Int]) -> [[Int]] {
        var result: [[Int]] = []
        let sorted = nums.sorted() // [-1, -1, 0, 1, 2, 4]
        if sorted.count < 3 {
            return result
        }
        
        for (idx, num) in sorted.enumerated() {
            if num > 0 {
                break
            }
            if idx > 0 && num == sorted[idx - 1] {
                continue
            }
            
            var L = idx + 1
            var R = sorted.count - 1
            while L < R {
                let sum = num + sorted[L] + sorted[R]
                if sum == 0 {
                    result.append([num, sorted[L], sorted[R]])
                    while L < R && sorted[L] == sorted[L + 1] {
                        L += 1
                    }
                    while L < R && sorted[R] == sorted[R - 1] {
                        R -= 1
                    }
                    L += 1
                    R -= 1
                }
                else if sum < 0 {
                    L += 1
                }
                else if sum > 0 {
                    R -= 1
                }
            }
        }
        return result
    }
}
