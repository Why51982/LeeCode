//
//  GenerateParenthesis.swift
//  LeeCode
//
//  Created by Ocean on 2022/5/3.
//
/*
 数字 n 代表生成括号的对数，请你设计一个函数，用于能够生成所有可能的并且 有效的 括号组合。

 示例 1：
 输入：n = 3
 输出：["((()))","(()())","(())()","()(())","()()()"]
 示例 2：
 输入：n = 1
 输出：["()"]
 
 提示：
 1 <= n <= 8
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/generate-parentheses
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

class GenerateParenthesis {
    func generateParenthesis(_ n: Int) -> [String] {
        // 结果
        var results: [String] = []
        // 一次深度遍历的结果
        var result: String = ""
        dfs(0, n, n, &result, &results)
        return results
    }
    
    /// 深度优化搜索
    /// - Parameters:
    ///   - index: 遍历层数
    ///   - leftRemain: 左括号剩余数量
    ///   - rightRemain: 右括号剩余数量
    ///   - result: 深度遍历依次的结果
    ///   - results: 总结果
    private func dfs(_ index: Int, _ leftRemain: Int, _ rightRemain: Int, _ result: inout String, _ results: inout [String]) {
        if 0 == leftRemain, 0 == rightRemain {
            results.append(result)
            return
        }
        
        // 当左括号和右括号相等的时候，只能选择左括号(因为第一个永远选择左括号，所以要转化成下面写法)
        // 换言之：当左括号大于0，可以选择左括号
        // 当右括号大于0 且 剩余左括号 不等于 右括号的时候，可以选择右括号
        
        if leftRemain > 0 {
            result.append("(")
            dfs(index + 1, leftRemain - 1, rightRemain, &result, &results)
            result.removeLast()
        }
        
        if rightRemain > 0, leftRemain != rightRemain {
            result.append(")")
            dfs(index + 1, leftRemain, rightRemain - 1, &result, &results)
            result.removeLast()
        }
    }
}

// MARK: 网上的最优解简便写法
class Parenthesis {
    func generateParenthesis(_ n: Int) -> [String] {
        var result = [String]()
        backtrack(n, n, "", &result)
        return result
    }
    func backtrack(_ left: Int, _ right: Int, _ curr: String, _ result: inout [String]) {
        if left == 0 && right == 0 {
            result.append(curr)
            return
        }
        if left > 0 {
            backtrack(left - 1, right, curr + "(", &result)
        }
        if right > left {
            backtrack(left, right - 1, curr + ")", &result)
        }
    }
}
