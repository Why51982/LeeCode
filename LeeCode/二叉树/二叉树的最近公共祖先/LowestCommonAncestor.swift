//
//  LowestCommonAncestor.swift
//  LeeCode
//
//  Created by Ocean on 2022/5/1.
//

import Foundation

class LowestCommonAncestor {
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        if root == nil || root === p || root === q { return root }
        let leftNode = lowestCommonAncestor(root?.left, p, q)
        let rightNode = lowestCommonAncestor(root?.right, p, q)
        
        if leftNode != nil, rightNode != nil {
            return root
        }
        return leftNode != nil ? leftNode : rightNode
    }
}
