//
//  ReverseVowels.swift
//  LeeCode
//
//  Created by Ocean on 2025/8/10.
//
// https://leetcode.cn/problems/reverse-vowels-of-a-string/description/?envType=study-plan-v2&envId=leetcode-75
//给你一个字符串 s ，仅反转字符串中的所有元音字母，并返回结果字符串。
//
//元音字母包括 'a'、'e'、'i'、'o'、'u'，且可能以大小写两种形式出现不止一次。
//
// 
//
//示例 1：
//
//输入：s = "IceCreAm"
//
//输出："AceCreIm"
//
//解释：
//
//s 中的元音是 ['I', 'e', 'e', 'A']。反转这些元音，s 变为 "AceCreIm".
//
//示例 2：
//
//输入：s = "leetcode"
//
//输出："leotcede"
//
// 
//
//提示：
//
//1 <= s.length <= 3 * 105
//s 由 可打印的 ASCII 字符组成

import Foundation

class ReverseVowels {
    func reverseVowels(_ s: String) -> String {
        let vowels: [Character] = ["A", "a", "E", "e", "I", "i", "O", "o", "U", "u"]
        var left = 0
        var right = s.count - 1
        
        var str = Array(s)
        while left < right {
            let leftChar = str[left]
            let rightChar = str[right]
            
            let leftContain = vowels.contains(leftChar)
            let rightContain = vowels.contains(rightChar)
            if !leftContain {
                left += 1
            } else if !rightContain {
                right -= 1
            } else if leftContain, rightContain {
                str.swapAt(left, right)
                left += 1
                right -= 1
            }
        }
        return String(str)
    }
}
