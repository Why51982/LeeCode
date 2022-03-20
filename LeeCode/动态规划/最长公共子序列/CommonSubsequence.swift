//
//  CommonSubsequence.swift
//  LeeCode
//
//  Created by Ocean on 2022/3/20.
//

/*
 给定两个字符串 text1 和 text2，返回这两个字符串的最长 公共子序列 的长度。如果不存在 公共子序列 ，返回 0 。

 一个字符串的 子序列 是指这样一个新的字符串：它是由原字符串在不改变字符的相对顺序的情况下删除某些字符（也可以不删除任何字符）后组成的新字符串。
 例如，"ace" 是 "abcde" 的子序列，但 "aec" 不是 "abcde" 的子序列。
 两个字符串的 公共子序列 是这两个字符串所共同拥有的子序列。

 示例 1：
 输入：text1 = "abcde", text2 = "ace"
 输出：3
 解释：最长公共子序列是 "ace" ，它的长度为 3 。
 示例 2：
 输入：text1 = "abc", text2 = "abc"
 输出：3
 解释：最长公共子序列是 "abc" ，它的长度为 3 。
 示例 3：
 输入：text1 = "abc", text2 = "def"
 输出：0
 解释：两个字符串没有公共子序列，返回 0 。

 提示：
 1 <= text1.length, text2.length <= 1000
 text1 和 text2 仅由小写英文字符组成。

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/longest-common-subsequence
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation


class CommonSubsequence {
    // MARK: 动态规划原始 最小长度一维数组(优化空间复杂度)
    func longestCommonSubsequence(_ text1: String, _ text2: String) -> Int {
        if 0 == text1.count || 0 == text2.count { return 0 }
        
        // 把长度最短的作为列
        var rowStr = text1.utf8.map({ $0 }), columnStr = text2.utf8.map({ $0 })
        if text1.count < text2.count {
            rowStr = text2.utf8.map({ $0 })
            columnStr = text1.utf8.map({ $0 })
        }
        
        var dp: [Int] = Array(repeating: 0, count: columnStr.count + 1)
        
        for i in 1 ... rowStr.count {
            var current = 0
            for j in 1 ... columnStr.count {
                let leftTop = current
                current = dp[j]
                if rowStr[i - 1] == columnStr[j - 1] {
                    dp[j] = leftTop + 1
                } else {
                    dp[j] = max(dp[j - 1], dp[j])
                }
            }
        }
        return dp[columnStr.count]
    }
    
    // MARK: 动态规划原始 一维数组(优化空间复杂度)
    func longestCommonSubsequence3(_ text1: String, _ text2: String) -> Int {
        if 0 == text1.count || 0 == text2.count { return 0 }
        
        var dp: [Int] = Array(repeating: 0, count: text2.count + 1)
        
        let text1Str = text1.utf8.map({ $0 })
        let text2Str = text2.utf8.map({ $0 })
        
        for i in 1 ... text1Str.count {
            var current = 0
            for j in 1 ... text2Str.count {
                let leftTop = current
                current = dp[j]
                if text1Str[i - 1] == text2Str[j - 1] {
                    dp[j] = leftTop + 1
                } else {
                    dp[j] = max(dp[j - 1], dp[j])
                }
            }
        }
        return dp[text2.count]
    }
    
    // MARK: 动态规划原始 滚动数组(优化空间复杂度)
    func longestCommonSubsequence2(_ text1: String, _ text2: String) -> Int {
        if 0 == text1.count || 0 == text2.count { return 0 }
        
        var dp: [[Int]] = Array(repeating: Array(repeating: 0, count: text2.count + 1), count: 2)
        
        let text1Str = text1.utf8.map({ $0 })
        let text2Str = text2.utf8.map({ $0 })
        for i in 1 ... text1Str.count {
            for j in 1 ... text2Str.count {
                let preRow = (i - 1) % 2
                let row = i % 2
                if text1Str[i - 1] == text2Str[j - 1] {
                    dp[row][j] = dp[preRow][j - 1] + 1
                } else {
                    dp[row][j] = max(dp[preRow][j], dp[row][j - 1])
                }
            }
        }
        return dp[text1.count % 2][text2.count]
    }
    
    // MARK: 动态规划原始
    func longestCommonSubsequence1(_ text1: String, _ text2: String) -> Int {
        if 0 == text1.count || 0 == text2.count { return 0 }
        
        var dp: [[Int]] = Array(repeating: Array(repeating: 0, count: text2.count + 1), count: text1.count + 1)
        
        let text1Str = text1.utf8.map({ $0 })
        let text2Str = text2.utf8.map({ $0 })
        for i in 1 ... text1Str.count {
            for j in 1 ... text2Str.count {
                if text1Str[i - 1] == text2Str[j - 1] {
                    dp[i][j] = dp[i - 1][j - 1] + 1
                } else {
                    dp[i][j] = max(dp[i - 1][j], dp[i][j - 1])
                }
            }
        }
        return dp[text1.count][text2.count]
    }
}

// MARK: 递归
class CommonSubsequence1 {
    func longestCommonSubsequence1(_ text1: String, _ text2: String) -> Int {
        return commonSubsequence1(text1, text1.count, text2, text2.count)
    }
    
    private func commonSubsequence1(_ text1: String, _ length1: Int, _ text2: String, _ length2: Int) -> Int {
        if 0 == length1 || 0 == length2 { return 0 }
        let text1Str = text1.utf8.map({ $0 })
        let text2Str = text2.utf8.map({ $0 })
        if text1Str[length1 - 1] != text2Str[length2 - 1] {
            return max(commonSubsequence1(text1, length1 - 1, text2, length2), commonSubsequence1(text1, length1, text2, length2 - 1))
        }
        
        return  commonSubsequence1(text1, length1 - 1, text2, length2 - 1) + 1
    }
}
