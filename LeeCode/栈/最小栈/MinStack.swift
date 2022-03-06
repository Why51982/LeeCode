//
//  MinStack.swift
//  LeeCode
//
//  Created by Ocean on 2022/3/6.
//

/*
 设计一个支持 push ，pop ，top 操作，并能在常数时间内检索到最小元素的栈。

 实现 MinStack 类:

 MinStack() 初始化堆栈对象。
 void push(int val) 将元素val推入堆栈。
 void pop() 删除堆栈顶部的元素。
 int top() 获取堆栈顶部的元素。
 int getMin() 获取堆栈中的最小元素。
  

 示例 1:
 输入：
 ["MinStack","push","push","push","getMin","pop","top","getMin"]
 [[],[-2],[0],[-3],[],[],[],[]]

 输出：
 [null,null,null,null,-3,null,0,-2]

 解释：
 MinStack minStack = new MinStack();
 minStack.push(-2);
 minStack.push(0);
 minStack.push(-3);
 minStack.getMin();   --> 返回 -3.
 minStack.pop();
 minStack.top();      --> 返回 0.
 minStack.getMin();   --> 返回 -2.
  

 提示：

 -231 <= val <= 231 - 1
 pop、top 和 getMin 操作总是在 非空栈 上调用
 push, pop, top, and getMin最多被调用 3 * 104 次

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/min-stack
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

class MinStack {
    
    var stack: [(element: Int,  min: Int)] = []

    init() {
        stack = [(element: Int,  min: Int)]()
    }
    
    func push(_ val: Int) {
        if stack.isEmpty {
            stack.append((val, val))
        } else {
            let top = getMin()
            stack.append((val, val > top ? top : val))
        }
    }
    
    func pop() {
        stack.popLast()
    }
    
    func top() -> Int {
        stack.last?.element ?? -1
    }
    
    func getMin() -> Int {
        stack.last?.min ?? -1
    }
}

// MARK: 第二种解法
class MinStack2 {
    var stack: [Int] = []
    var minStack: [Int] = []
    init() {
        
    }
    
    func push(_ val: Int) {
        stack.append(val)
        if minStack.isEmpty {
            minStack.append(val)
        } else {
            minStack.append(min(minStack.last!, val))
        }
    }
    
    func pop() {
        stack.removeLast()
        minStack.removeLast()
    }
    
    func top() -> Int {
        return stack.last!
    }
    
    func getMin() -> Int {
        return minStack.last!
    }
}

