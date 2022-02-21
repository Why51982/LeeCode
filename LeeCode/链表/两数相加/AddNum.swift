//
//  AddNum.swift
//  LeeCode
//
//  Created by Ocean on 2022/2/21.
//

/*
 给你两个 非空 的链表，表示两个非负的整数。它们每位数字都是按照 逆序 的方式存储的，并且每个节点只能存储 一位 数字。

 请你将两个数相加，并以相同形式返回一个表示和的链表。

 你可以假设除了数字 0 之外，这两个数都不会以 0 开头。

 示例 1：
 输入：l1 = [2,4,3], l2 = [5,6,4]
 输出：[7,0,8]
 解释：342 + 465 = 807.
 
 示例 2：
 输入：l1 = [0], l2 = [0]
 输出：[0]
 
 示例 3：
 输入：l1 = [9,9,9,9,9,9,9], l2 = [9,9,9,9]
 输出：[8,9,9,9,0,0,0,1]
 
 提示：
 每个链表中的节点数在范围 [1, 100] 内
 0 <= Node.val <= 9
 题目数据保证列表表示的数字不含前导零

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/add-two-numbers
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

struct AddNum {
    static func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        
        let dummpNode = ListNode(0)
        var carryNum = 0
        var currentNode = dummpNode
        
        // node转化为var
        var node1 = l1
        var node2 = l2
        
        // 注意：遍历完链表，一定要检查进位
        while node1 != nil || node2 != nil || carryNum != 0 {
            let value1 = node1?.val ?? 0
            let value2 = node2?.val ?? 0
            
            let totalNum = value1 + value2 + carryNum
            // 个位
            let num = totalNum % 10
            // 进位(注意个位和进位都要加carry)
            carryNum = totalNum / 10
            currentNode.next = ListNode(num)
            currentNode = currentNode.next!
            
            node1 = node1?.next
            node2 = node2?.next
        }
        
        return dummpNode.next
    }
    
    // MARK: 方法2
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        return addTwoNumbers(l1, l2, 0);
    }
    
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?, _ bit: Int) -> ListNode? {
        if (l1 == nil && l2 == nil && bit == 0) {
            return nil;
        }
        let node = ListNode(0);
        node.val = ((l1?.val ?? 0) + (l2?.val ?? 0) + bit) % 10;
        node.next = addTwoNumbers(l1?.next, l2?.next, ((l1?.val ?? 0) + (l2?.val ?? 0) + bit) / 10);
        return node;
    }
}
