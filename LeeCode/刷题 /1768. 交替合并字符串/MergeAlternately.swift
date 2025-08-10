//
//  MergeString.swift
//  LeeCode
//
//  Created by Ocean on 2025/8/10.
//
//给你两个字符串 word1 和 word2 。请你从 word1 开始，通过交替添加字母来合并字符串。如果一个字符串比另一个字符串长，就将多出来的字母追加到合并后字符串的末尾。
//
//返回 合并后的字符串 。
//
// 
//
//示例 1：
//
//输入：word1 = "abc", word2 = "pqr"
//输出："apbqcr"
//解释：字符串合并情况如下所示：
//word1：  a   b   c
//word2：    p   q   r
//合并后：  a p b q c r
//示例 2：
//
//输入：word1 = "ab", word2 = "pqrs"
//输出："apbqrs"
//解释：注意，word2 比 word1 长，"rs" 需要追加到合并后字符串的末尾。
//word1：  a   b
//word2：    p   q   r   s
//合并后：  a p b q   r   s
//示例 3：
//
//输入：word1 = "abcd", word2 = "pq"
//输出："apbqcd"
//解释：注意，word1 比 word2 长，"cd" 需要追加到合并后字符串的末尾。
//word1：  a   b   c   d
//word2：    p   q
//合并后：  a p b q c   d
//
// https://leetcode.cn/problems/merge-strings-alternately/?envType=study-plan-v2&envId=leetcode-75
//
//提示：
//
//1 <= word1.length, word2.length <= 100
//word1 和 word2 由小写英文字母组成

import Foundation

class MergeAlternately {
    func mergeAlternately(_ word1: String, _ word2: String) -> String {
        let word1Array = Array(word1)
        let word2Array = Array(word2)
        var solution: [Character] = []
        let maxLength = max(word1Array.count, word2Array.count)
        for i in 0..<maxLength {
            if word1Array.count > i {
                solution.append(word1Array[i])
            }
            if word2Array.count > i {
                solution.append(word2Array[i])
            }
        }
        return String(solution)
    }
    
    func mergeAlternately1(_ word1: String, _ word2: String) -> String {
        let count1 = word1.count
        let count2 = word2.count
        
        var word1Array = Array(word1)
        var word2Array = Array(word2)
        var resultArray: [Character] = []
        
        let count = count1 > count2 ? count2 : count1
        for index in 0 ..< count {
            resultArray.append(word1Array[index])
            resultArray.append(word2Array[index])
        }
        if count1 > count2 {
            for index in count2 ..< count1 {
                resultArray.append(word1Array[index])
            }
        } else {
            for index in count1 ..< count2{
                resultArray.append(word2Array[index])
            }
        }
        return String(resultArray)
    }
}
