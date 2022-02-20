//
//  ListNode.swift
//  LeeCode
//
//  Created by Ocean on 2022/2/20.
//

import Foundation

class ListNode {
    var val: Int
    var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
    
}
