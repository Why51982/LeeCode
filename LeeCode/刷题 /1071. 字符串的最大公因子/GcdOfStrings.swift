//
//  GcdOfStrings.swift
//  LeeCode
//
//  Created by Ocean on 2025/8/10.
//
//对于字符串 s 和 t，只有在 s = t + t + t + ... + t + t（t 自身连接 1 次或多次）时，我们才认定 “t 能除尽 s”。
//
//给定两个字符串 str1 和 str2 。返回 最长字符串 x，要求满足 x 能除尽 str1 且 x 能除尽 str2 。
//
// https://leetcode.cn/problems/greatest-common-divisor-of-strings/description/?envType=study-plan-v2&envId=leetcode-75
//
//示例 1：
//
//输入：str1 = "ABCABC", str2 = "ABC"
//输出："ABC"
//示例 2：
//
//输入：str1 = "ABABAB", str2 = "ABAB"
//输出："AB"
//示例 3：
//
//输入：str1 = "LEET", str2 = "CODE"
//输出：""
// 
//
//提示：
//
//1 <= str1.length, str2.length <= 1000
//str1 和 str2 由大写英文字母组成

import Foundation

class GcdOfStrings {
    func gcdOfStrings(_ str1: String, _ str2: String) -> String {
        guard str1 + str2 == str2 + str1 else {
            return ""
        }
        
        let gcd = gcd(x: str1.count, y: str2.count)
        return String(str1.prefix(gcd))
    }
    
    // 求最大公约数
    func gcd(x: Int, y: Int) -> Int {
        if 0 == y {
            return x
        } else {
            return gcd(x: y, y: x % y)
        }
    }
}
