//
//  IntersectNode.swift
//  LeeCode
//
//  Created by Ocean on 2022/2/21.
//

/*
 给你两个单链表的头节点 headA 和 headB ，请你找出并返回两个单链表相交的起始节点。如果两个链表不存在相交节点，返回 null 。

 图示两个链表在节点 c1 开始相交：



 题目数据 保证 整个链式结构中不存在环。

 注意，函数返回结果后，链表必须 保持其原始结构 。

 自定义评测：

 评测系统 的输入如下（你设计的程序 不适用 此输入）：

 intersectVal - 相交的起始节点的值。如果不存在相交节点，这一值为 0
 listA - 第一个链表
 listB - 第二个链表
 skipA - 在 listA 中（从头节点开始）跳到交叉节点的节点数
 skipB - 在 listB 中（从头节点开始）跳到交叉节点的节点数
 评测系统将根据这些输入创建链式数据结构，并将两个头节点 headA 和 headB 传递给你的程序。如果程序能够正确返回相交节点，那么你的解决方案将被 视作正确答案 。

 示例 1：
 输入：intersectVal = 8, listA = [4,1,8,4,5], listB = [5,6,1,8,4,5], skipA = 2, skipB = 3
 输出：Intersected at '8'
 解释：相交节点的值为 8 （注意，如果两个链表相交则不能为 0）。
 从各自的表头开始算起，链表 A 为 [4,1,8,4,5]，链表 B 为 [5,6,1,8,4,5]。
 在 A 中，相交节点前有 2 个节点；在 B 中，相交节点前有 3 个节点。
 
 示例 2：
 输入：intersectVal = 2, listA = [1,9,1,2,4], listB = [3,2,4], skipA = 3, skipB = 1
 输出：Intersected at '2'
 解释：相交节点的值为 2 （注意，如果两个链表相交则不能为 0）。
 从各自的表头开始算起，链表 A 为 [1,9,1,2,4]，链表 B 为 [3,2,4]。
 在 A 中，相交节点前有 3 个节点；在 B 中，相交节点前有 1 个节点。
 
 示例 3：
 输入：intersectVal = 0, listA = [2,6,4], listB = [1,5], skipA = 3, skipB = 2
 输出：null
 解释：从各自的表头开始算起，链表 A 为 [2,6,4]，链表 B 为 [1,5]。
 由于这两个链表不相交，所以 intersectVal 必须为 0，而 skipA 和 skipB 可以是任意值。
 这两个链表不相交，因此返回 null 。
  

 提示：

 listA 中节点数目为 m
 listB 中节点数目为 n
 1 <= m, n <= 3 * 104
 1 <= Node.val <= 105
 0 <= skipA <= m
 0 <= skipB <= n
 如果 listA 和 listB 没有交点，intersectVal 为 0
 如果 listA 和 listB 有交点，intersectVal == listA[skipA] == listB[skipB]
  

 进阶：你能否设计一个时间复杂度 O(m + n) 、仅用 O(1) 内存的解决方案？

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/intersection-of-two-linked-lists
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

struct IntersectNode {
    static func getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
        guard let headA = headA else { return  nil }
        guard let headB = headB else { return nil }
        
        // 定义两个指针(不能破坏原链表), 第一轮让两个到达末尾的节点指向另一个链表的头部, 最后如果相遇则为交点(在第一轮移动中恰好抹除了长度差)
        // 两个指针等于移动了相同的距离, 有交点就返回, 无交点就是各走了两条指针的长度
        var newHeadA: ListNode? = headA
        var newHeadB: ListNode? = headB
        
        // 在这里第一轮体现在newHeadA和newHeadB第一次到达尾部会移向另一链表的表头, 而第二轮体现在如果newHeadA或newHeadB相交就返回交点, 不相交最后就是null==null
        
        
        /*
         特别注意，不是这个(无交点死循环)
         newHeadA = newHeadA.next != nil ? newHeadA.next! : headB
         newHeadB = newHeadB.next != nil ? newHeadB.next! : headA
         */
        
        while newHeadA !== newHeadB {
            newHeadA = (newHeadA != nil) ? newHeadA?.next : headB
            newHeadB = (newHeadB != nil) ? newHeadB?.next : headA
        }
        return newHeadA
    }
}
