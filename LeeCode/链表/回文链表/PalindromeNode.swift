//
//  PalindromeNode.swift
//  LeeCode
//
//  Created by Ocean on 2022/2/22.
//

/*
 给你一个单链表的头节点 head ，请你判断该链表是否为回文链表。如果是，返回 true ；否则，返回 false 。

 示例 1：
 输入：head = [1,2,2,1]
 输出：true
 
 示例 2：
 输入：head = [1,2]
 输出：false
 
 提示：
 链表中节点数目在范围[1, 105] 内
 0 <= Node.val <= 9
 
 进阶：你能否用 O(n) 时间复杂度和 O(1) 空间复杂度解决此题？

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/palindrome-linked-list
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

struct PalindromeNode {
    // MARK: 解法1
    static func isPalindrome(_ head: ListNode?) -> Bool {
        if head == nil || head?.next == nil { return true }
        if head?.next?.next == nil { return head?.val == head?.next?.val }
        
        // 找到中间节点
        let middleNode = middleNode(head)
        // 翻转右半部分
        var rHead = reverseList(middleNode?.next)
        var lHead = head
        
        while rHead != nil {
            if lHead?.val != rHead?.val {
                return false
            }
            rHead = rHead?.next
            lHead = lHead?.next
        }
        return true
    }
    
    // 找到中间节点
    static private func middleNode(_ head: ListNode?) -> ListNode? {
        var fast = head
        var slow = head
        
        while fast?.next != nil && fast?.next?.next != nil {
            slow = slow?.next
            fast = fast?.next?.next
        }
        
        return slow
    }
    
    // 旋转链表
    static private func reverseList(_ head: ListNode?) -> ListNode? {
        var newHead: ListNode? = nil
        var currentNode = head
        
        while currentNode != nil {
            let temp = currentNode?.next
            currentNode?.next = newHead
            newHead = currentNode
            currentNode = temp
        }
        
        return newHead
    }
    
    // MARK: 解法2
    func isPalindrome(_ head: ListNode?) -> Bool {
            if head == nil {
                return false
            }

            var nextNode = head
            var array = [ListNode]()
            //循环遍历转换到数组中
            while nextNode != nil {
                array.append(nextNode!)
                nextNode = nextNode?.next
            }

            //声明首位双指针
            var left = 0, right = array.count - 1
            //循环遍历数组首位比较
            while left < right {
                let leftNode = array[left]
                let rightNode = array[right]
                if (leftNode.val != rightNode.val) {
                    return false
                }
                left += 1
                right -= 1
            }

            return true
        }
}
