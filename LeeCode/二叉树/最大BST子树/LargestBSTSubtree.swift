//
//  LargestBSTSubtree.swift
//  LeeCode
//
//  Created by Ocean on 2022/5/2.
//
/*
 给定一个二叉树，找到其中最大的二叉搜索树(BST)子树，其中最大指的是子树节点数最多的
 注意：子树必须包含其所有后代
 */

import Foundation

class LargestBSTSubtree {
    
    // MARK: 最大BST子树的信息
    class Info {
        /// 根节点
        var root: TreeNode?
        /// 节点总数
        var size: Int = 1
        /// 最大值
        var max: Int = 0
        /// 最小值
        var min: Int = 0
        
        init(root: TreeNode, size: Int, max: Int, min: Int) {
            self.root = root
            self.size = size
            self.max = max
            self.min = min
        }
    }
    
    // MARK: 最大BST子树
    func largestBSTSubtree(_ root: TreeNode?) -> Int {
        guard let root = root else {
            return 0
        }
        return getInfo(root)?.size ?? 0
    }
    
    /// 返回以root为根节点的二叉树的最大BST子树信息
    func getInfo(_ root: TreeNode?) -> Info? {
        /*
         有四种情况，以root为根节点的二叉树就是一棵BST，最大BST子树就是其本身
         ① leftInfo != nil && rightInfo != nil
            && leftInfo.root = root.left && root.val > leftInfo.max
            && rightInfo.root = root.right && root.val < rightInfo.min
         
         ② leftInfo != nil && rightInfo == nil
            && leftInfo.root = root.left && root.val > leftInfo.max
         
         ③ leftInfo == nil && rightInfo != nil
            && rightInfo.root = root.right && root.val < rightInfo.min
         
         ④ leftInfo == nil && rightInfo == nil
         */
        guard let root = root else {
            return nil
        }

        // leftInfo: 左子树的最大BST子树信息
        let leftInfo = getInfo(root.left)
        // rightInfo: 右子树的最大BST子树信息
        let rightInfo = getInfo(root.right)
        
        // 初始化变量
        // 左子树的size
        var leftBstSize = -1
        // 右子树的size
        var rightBstSize = -1
        // 最大值
        var max = root.val
        // 最小值
        var min = root.val
        
        if leftInfo == nil {
            leftBstSize = 0
        } else if let leftInfo = leftInfo, leftInfo.root === root.left, leftInfo.max < root.val {
            leftBstSize = leftInfo.size
            min = leftInfo.min
        }
        
        if rightInfo == nil {
            rightBstSize = 0
        } else if let rightInfo = rightInfo, rightInfo.root === root.right, rightInfo.min > root.val {
            rightBstSize = rightInfo.size
            max = rightInfo.max
        }
        
        // 以root为根节点的二叉树就是BST
        if leftBstSize >= 0, rightBstSize >= 0 {
            return Info(root: root, size: 1 + leftBstSize + rightBstSize, max: max, min: min)
        }
        
        // 以root为根节点的二叉树不是BST
        // 左右子树都存在
        if let leftInfo = leftInfo, let rightInfo = rightInfo {
            return (leftInfo.size > rightInfo.size) ? leftInfo : rightInfo
        }
        
        // 左右子树只有一个存在（同时为空，就是以root为根节点的二叉树就是BST，已经被第一种情况排除）
        return leftInfo != nil ? leftInfo : rightInfo
    }
}
