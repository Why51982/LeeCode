//
//  MaximumBinaryTree.swift
//  LeeCode
//
//  Created by Ocean on 2022/3/11.
//

/*
 给定一个不重复的整数数组 nums 。 最大二叉树 可以用下面的算法从 nums 递归地构建:

 创建一个根节点，其值为 nums 中的最大值。
 递归地在最大值 左边 的 子数组前缀上 构建左子树。
 递归地在最大值 右边 的 子数组后缀上 构建右子树。
 返回 nums 构建的 最大二叉树 。

 示例 1：
 输入：nums = [3,2,1,6,0,5]
 输出：[6,3,5,null,2,0,null,null,1]
 解释：递归调用如下所示：
 - [3,2,1,6,0,5] 中的最大值是 6 ，左边部分是 [3,2,1] ，右边部分是 [0,5] 。
     - [3,2,1] 中的最大值是 3 ，左边部分是 [] ，右边部分是 [2,1] 。
         - 空数组，无子节点。
         - [2,1] 中的最大值是 2 ，左边部分是 [] ，右边部分是 [1] 。
             - 空数组，无子节点。
             - 只有一个元素，所以子节点是一个值为 1 的节点。
     - [0,5] 中的最大值是 5 ，左边部分是 [0] ，右边部分是 [] 。
         - 只有一个元素，所以子节点是一个值为 0 的节点。
         - 空数组，无子节点。
 示例 2：
 输入：nums = [3,2,1]
 输出：[3,null,2,null,1]
  
 提示：
 1 <= nums.length <= 1000
 0 <= nums[i] <= 1000
 nums 中的所有整数 互不相同

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/maximum-binary-tree
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}

import Foundation

class MaximumBinaryTree {
    
    // MARK: 递归
    func constructMaximumBinaryTree(_ nums: [Int]) -> TreeNode? {
        if nums.count == 0 {
            return nil
        }
        return findRoot(nums, left: 0, right: nums.count)
    }
    
    private func findRoot(_ nums: [Int], left: Int, right: Int) -> TreeNode? {
        if left == right {
            return nil
        }
        
        var maxIndex = left
        for index in left ..< right {
            if nums[index] > nums[maxIndex] {
                maxIndex = index
            }
        }
        
        let root  = TreeNode(nums[maxIndex])
        root.left = findRoot(nums, left: left, right: maxIndex)
        root.right = findRoot(nums, left: maxIndex + 1, right: right)
        return root
    }
    
    // MARK: 变种
    // 返回一个数组，数组里面存着每个节点的父节点的索引(如果没有父节点 就存-1)
    func parentIndex(_ nums: [Int]) -> [Int] {
        /*
         1. 扫描一遍所有元素
         2. 保持栈从栈底到栈顶是单调递减的
         */
        // 保存左边第一个比它大的元素
        var leftIndexs: [Int] = Array(repeating: -1, count: nums.count)
        // 保存右边第一个比它大的元素
        var rightIndexs: [Int] = Array(repeating: -1, count: nums.count)
        // 保存父节点的索引
        var parentIndexs: [Int] = Array(repeating: -1, count: nums.count)
        
        // 栈
        var stack: [Int] = []
        for (index, num) in nums.enumerated() {
            while (!stack.isEmpty && num > nums[stack.last!]) {
                let currentIndex = stack.popLast()!
                // 右边第一个最大值的索引
                rightIndexs[currentIndex] = index
            }
            
            // 左边第一个最大值的索引
            leftIndexs[index] = stack.isEmpty ? -1 : stack.last!
            stack.append(index)
        }
        
        debugPrint(leftIndexs)
        debugPrint(rightIndexs)
        
        // 取出较小的那个就是父节点的索引
        for index in 0 ..< nums.count {
            if -1 == leftIndexs[index], -1 == rightIndexs[index] {
                parentIndexs[index] = -1
                continue
            }
            
            let leftIndex = leftIndexs[index]
            let rightIndex = rightIndexs[index]
            if -1 == leftIndex {
                parentIndexs[index] = rightIndex
            } else if -1 == rightIndex {
                parentIndexs[index] = leftIndex
            } else if nums[leftIndex] > nums[rightIndex] {
                parentIndexs[index] = rightIndex
            } else {
                parentIndexs[index] = leftIndex
            }
        }
        
        return parentIndexs
    }
}
