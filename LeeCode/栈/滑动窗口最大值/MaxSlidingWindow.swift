//
//  MaxSlidingWindow.swift
//  LeeCode
//
//  Created by Ocean on 2022/3/7.
//

/*
 给你一个整数数组 nums，有一个大小为 k 的滑动窗口从数组的最左侧移动到数组的最右侧。你只可以看到在滑动窗口内的 k 个数字。滑动窗口每次只向右移动一位。

 返回 滑动窗口中的最大值 。

  

 示例 1：

 输入：nums = [1,3,-1,-3,5,3,6,7], k = 3
 输出：[3,3,5,5,6,7]
 解释：
 滑动窗口的位置                最大值
 ---------------               -----
 [1  3  -1] -3  5  3  6  7       3
  1 [3  -1  -3] 5  3  6  7       3
  1  3 [-1  -3  5] 3  6  7       5
  1  3  -1 [-3  5  3] 6  7       5
  1  3  -1  -3 [5  3  6] 7       6
  1  3  -1  -3  5 [3  6  7]      7
 示例 2：

 输入：nums = [1], k = 1
 输出：[1]
 
 提示：
 1 <= nums.length <= 105
 -104 <= nums[i] <= 104
 1 <= k <= nums.length

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/sliding-window-maximum
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

class MaxSlidingWindow {
    // MARK: 双端队列
    static func maxSlidingWindow(_ nums: [Int], _ k: Int) -> [Int] {
        guard !nums.isEmpty else { return [] }
        
        var maxs: [Int] = [Int]()
        
        // 遍历首个窗口
        // 记录最大的index值
        var maxIndex = 0
        for i in 1 ..< k {
            if nums[i] > nums[maxIndex] {
                maxIndex = i
            }
        }
        
        // 遍历数组
        let length = nums.count - k
        for i in 0 ... length {
            // 右边的index
            let rightIndex = i + k
            
            // maxIndex滑出窗口
            if maxIndex < i {
                maxIndex = i
                for i in (i + 1) ..< rightIndex {
                    if nums[i] > nums[maxIndex] {
                        maxIndex = i
                    }
                }
            } else { // maxIndex在窗口
                if nums[rightIndex - 1] > nums[maxIndex] {
                    maxIndex = rightIndex - 1
                }
            }
            
            maxs.append(nums[maxIndex])
        }
        
        return maxs
    }
    
    // MARK: 双端队列
    static func maxSlidingWindow1(_ nums: [Int], _ k: Int) -> [Int] {
        guard !nums.isEmpty else { return [] }
        
        var maxs: [Int] = [Int]()
        
        var deque: [Int] = [Int]()
        for (index, value) in nums.enumerated() {
            // 判断队列中保存后面遍历过程中小于的元素
            while !deque.isEmpty, value >= nums[deque.last ?? 0] {
                let _ = deque.popLast()
            }
            deque.append(index)
            
            // 检查窗口是否合法 index - (k - 1)
            let firstWindowIndex = index - k + 1
            if firstWindowIndex < 0 { continue }
            
            // 检查对头的合法性
            guard let first = deque.first else { break }
            if first < firstWindowIndex {
                deque.removeFirst()
            }
            
            // 设置窗口的最大值
            let numInDequeIndex = deque.first ?? 0
            maxs.append(nums[numInDequeIndex])
        }
        
        return maxs
    }
    
    // MARK: 解法2
    func maxSlidingWindow2(_ nums: [Int], _ k: Int) -> [Int] {
        var index: [Int] = []
        var left = 0
        var right = 0
        var result: [Int] = []
        
        for i in 0..<k {
            while left < right && nums[i] >= nums[index[right-1]] {
                index.removeLast()
                right -= 1;
            }
            index.append(i)
            right += 1
        }
        
        result.append(nums[index[left]])
        for i in k..<nums.count {
            while left < right && nums[i] >= nums[index[right-1]] {
                index.removeLast()
                right -= 1;
            }
            index.append(i)
            right += 1
            while index[left] <= i - k {
                left += 1;
            }
            result.append(nums[index[left]])
        }
        return result
    }
}
