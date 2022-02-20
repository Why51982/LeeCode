//
//  MoreNum.swift
//  LeeCode
//
//  Created by Ocean on 2022/2/18.
//

/*
 给定一个大小为 n 的数组，找到其中的多数元素。多数元素是指在数组中出现次数 大于 ⌊ n/2 ⌋ 的元素。

 你可以假设数组是非空的，并且给定的数组总是存在多数元素。

  

 示例 1：

 输入：[3,2,3]
 输出：3
 示例 2：

 输入：[2,2,1,1,1,2,2]
 输出：2
  

 进阶：

 尝试设计时间复杂度为 O(n)、空间复杂度为 O(1) 的算法解决此问题。

 作者：力扣 (LeetCode)
 链接：https://leetcode-cn.com/leetbook/read/top-interview-questions/xm77tm/
 来源：力扣（LeetCode）
 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
 */

import Foundation

struct MoreNum {
    static func majorityElement1(_ nums: [Int]) -> Int {
        // 摩尔投票法
        var major = nums[0]
        var count = 1
        for i in 1 ..< nums.count {
            if major == nums[i] {
                count += 1
            } else {
                count -= 1
            }
            
            if 0 == count {
                major = nums[i]
                count = 1
            }
        }
        return major
    }
    
    static func majorityElement2(_ nums: [Int]) -> Int {
        let numbers = nums.sorted()
        return numbers[numbers.count / 2]
    }
}
