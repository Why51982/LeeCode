//
//  RecoverTree.swift
//  LeeCode
//
//  Created by Ocean on 2022/5/1.
//
/*
 给你二叉搜索树的根节点 root ，该树中的 恰好 两个节点的值被错误地交换。请在不改变其结构的情况下，恢复这棵树 。

 示例 1：
 输入：root = [1,3,null,null,2]
 输出：[3,1,null,null,2]
 解释：3 不能是 1 的左孩子，因为 3 > 1 。交换 1 和 3 使二叉搜索树有效。
 示例 2：
 输入：root = [3,1,4,null,null,2]
 输出：[2,1,4,null,null,3]
 解释：2 不能在 3 的右子树中，因为 2 < 3 。交换 2 和 3 使二叉搜索树有效。

 提示：
 树上节点的数目在范围 [2, 1000] 内
 -231 <= Node.val <= 231 - 1
  

 进阶：使用 O(n) 空间复杂度的解法很容易实现。你能想出一个只使用 O(1) 空间的解决方案吗？

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/recover-binary-search-tree
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

class RecoverTree {
    
    /// 前一个节点
    var preNode: TreeNode?
    /// 第一个错误节点
    var firstNode: TreeNode?
    /// 第二个错误节点
    var secondNode: TreeNode?
    
    // MARK: 优化空间复杂度，空间为O(1)
    func recoverTree(_ root: TreeNode?) {
        inorder(root)
        
        // 交换节点的值
        let temp = firstNode?.val
        firstNode?.val = secondNode?.val ?? 0
        secondNode?.val = temp ?? 0
    }
    
    /// 利用Morris进行中序遍历
    private func inorder(_ root: TreeNode?) {
        var node = root
        while node != nil {
            if let leftNode = node?.left {
                // 找到前驱节点 (前驱: predecessor, 后继: successor)
                var predNode = leftNode
                while predNode.right != nil && predNode.right !== node {
                    predNode = predNode.right!
                }
                
                if predNode.right == nil {
                    predNode.right = node
                    node = node?.left
                } else { // predNode.right === node
                    // 处理(print)
                    find(node)
                    predNode.right = nil
                    node = node?.right
                }
                
            } else {
                // 处理(print)
                find(node)
                node = node?.right
            }
        }
    }
    
    /// 处理数据
    private func find(_ node: TreeNode?) {
        guard let node = node else {
            return
        }

        // 处理(print), 寻找错误的逆序对
        if let preNode = preNode, preNode.val > node.val { // 第一次出现反向的
            secondNode = node
            
//            if firstNode == nil {
//                firstNode = preNode
//            }
            
            // 优化，因为不为空肯定为第二次的逆序对，也就是最后一个，不需要继续遍历了
            if firstNode != nil { return }
            firstNode = preNode
        }
        preNode = node
    }
}

extension RecoverTree {
    // MARK: 使用中序遍历(递归,空间为O(1))
    func recoverTree1(_ root: TreeNode?) {
        findWrongNodes(root)
        
        // 交换节点的值
        let temp = firstNode?.val
        firstNode?.val = secondNode?.val ?? 0
        secondNode?.val = temp ?? 0
    }
    
    /// 中序遍历找到相反的两个节点
    private func findWrongNodes(_ root: TreeNode?) {
        guard let  root = root else {
            return
        }

        findWrongNodes(root.left)
        
        // 处理(print), 寻找错误的逆序对
        if let preNode = preNode, preNode.val > root.val { // 第一次出现反向的
            secondNode = root
            
//            if firstNode == nil {
//                firstNode = preNode
//            }
            
            // 优化，因为不为空肯定为第二次的逆序对，也就是最后一个，不需要继续遍历了
            if firstNode != nil { return }
            firstNode = preNode
        }
        preNode = root
        
        findWrongNodes(root.right)
    }
}
