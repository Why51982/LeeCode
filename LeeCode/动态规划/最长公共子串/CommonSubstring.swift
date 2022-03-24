//
//  CommonSubString.swift
//  LeeCode
//
//  Created by Ocean on 2022/3/24.
//
/*
 最长公共子串(Longest Common Substring)
 子串是连续的子序列
 
 求两个字符串的最长公共子串长度
 ABCBA 和 BABCA 的最长公共子串是 ABC，长度为3
 */

import Foundation

// dp[i][j]表示str1[i - 1]、str2[j - 1]结尾的最长公共子串长度
class CommonSubstring {
    // MARK: 动态规划，反向遍历完美解决leftTop问题
    func lcs(str1: String, str2: String) -> Int {
        guard !str1.isEmpty, !str2.isEmpty else { return 0 }
        var dp: [Int] =  Array(repeating: 0, count: str2.count + 1)
        
        let str1Array = str1.utf8.map({ $0 })
        let str2Array = str2.utf8.map({ $0 })
        var maximum = 0
        for i in 1 ... str1.count {
            for j in (1 ... str2.count).reversed() {
                // 获取lefTop
                let leftTop = dp[j - 1]
                if str1Array[i - 1] == str2Array[j - 1] {
                    dp[j] = leftTop + 1
                    maximum = max(maximum, dp[j])
                } else {
                    dp[j] = 0
                }
            }
        }
        return maximum
    }
    
    // MARK: 动态规划（-维数组：还可以优化空间把最短的作为数组长度）
    func lcs2(str1: String, str2: String) -> Int {
        guard !str1.isEmpty, !str2.isEmpty else { return 0 }
        
        var dp: [Int] =  Array(repeating: 0, count: str2.count + 1)
        
        let str1Array = str1.utf8.map({ $0 })
        let str2Array = str2.utf8.map({ $0 })
        var maximum = 0
        for i in 1 ... str1.count {
            var current = 0
            for j in 1 ... str2.count {
                // 获取lefTop
                let leftTop = current
                current = dp[j]
                
                if str1Array[i - 1] == str2Array[j - 1] {
                    dp[j] = leftTop + 1
                    maximum = max(maximum, dp[j])
                } else {
                    dp[j] = 0
                }
            }
        }
        return maximum
    }
    
    // MARK: 动态规划
    func lcs1(str1: String, str2: String) -> Int {
        guard !str1.isEmpty, !str2.isEmpty else { return 0 }
        
        var dp: [[Int]] =  Array(repeating: Array(repeating: 0, count: str2.count + 1), count: str1.count + 1)
        
        let str1Array = str1.utf8.map({ $0 })
        let str2Array = str2.utf8.map({ $0 })
        var maximum = 0
        for i in 1 ... str1.count {
            for j in 1 ... str2.count {
                if str1Array[i - 1] != str2Array[j - 1] { continue }
                dp[i][j] = dp[i - 1][j - 1] + 1
                maximum = max(maximum, dp[i][j])
            }
        }
        return maximum
    }
}
