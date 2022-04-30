//
//  LongestPalindrome.swift
//  LeeCode
//
//  Created by Ocean on 2022/4/30.
//
/*
 给你一个字符串 s，找到 s 中最长的回文子串。

 示例 1：

 输入：s = "babad"
 输出："bab"
 解释："aba" 同样是符合题意的答案。
 示例 2：

 输入：s = "cbbd"
 输出："bb"

 提示：
 1 <= s.length <= 1000
 s 仅由数字和英文字母组成

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/longest-palindromic-substring
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

class LongestPalindrome {
    
    // MARK: Manacher马拉车算法
    /// 马拉车更高效的解法
    func longestPalindrome(_ s: String) -> String {
        var count = s.count
        if count < 2 { return s }
        
        // 1, construct Manacher string
        let constant: Character = "N"
        var chars: [Character] = [constant]
        for c in s {
            chars.append(c)
            chars.append(constant)
        }
        count = chars.count
        
        // 2, Manacher searching
        var maxRL = 0
        var maxIndex = 0
        var maxLength = 0
        var maxI = 0
        var dp = [Int](repeating:1, count:count)
        for i in 0..<count {
            if i < maxRL {
                dp[i] = min(maxRL - i + 1, dp[2 * maxIndex - i])
            }
            while i - dp[i] >= 0 && i + dp[i] < count && chars[i - dp[i]] == chars[i + dp[i]] {
                dp[i] += 1
            }
            let newRL = i + dp[i] - 1
            if newRL > maxRL {
                maxRL = newRL
                maxIndex = i
            }
            if maxLength < dp[i] {
                maxLength = dp[i]
                maxI = i
            }
        }
        
        // 3, fetch original string
        var left = maxI - maxLength + 1, right = maxI + maxLength - 1
        var res: String = ""
        while left <= right {
            if chars[left] != constant {
                res.append(chars[left])
            }
            left += 1
        }
        return res
    }
    
    /// 马拉车算法
    func longestPalindrome3(_ s: String) -> String {
        // 预处理数组
        let cs = preprogress(s)
        
        // 转化成数组
        let csArray = Array(cs)
        
        // 构建m数组
        var m: [Int] = Array(repeating: 0, count: cs.count)
        
        var center = 1, right = 1
        let lastIndex = csArray.count - 2
        var maxLength = 0, idx = 0
        for index in 2 ..< lastIndex {
            if right > index {
                // 计算index对称位置
                let leftIndex = center * 2 - index
                
                if index + m[leftIndex] <= right {
                    m[index] = m[leftIndex]
                } else {
                    m[index] = right - index
                }
            }
            
            // 以i为中心向两边扩展
            while csArray[index + m[index] + 1] == csArray[index - m[index] - 1] {
                m[index] += 1
            }
            
            // 如果超出更新center、 right
            if index + m[index] > right {
                center = index
                right = index + m[index]
            }
            
            // 找出最大的回文串
            if m[index] > maxLength {
                maxLength = m[index]
                idx = index
            }
        }
        
        // 计算原始字符串开始位置 (index - m[index]) / 2
        let begin = (idx - maxLength) / 2
        
        // 在原始字符串截取
        let startIndex = s.index(s.startIndex, offsetBy: begin)
        let endIndex = s.index(s.startIndex, offsetBy: begin + maxLength)
        return String(s[startIndex..<endIndex])
    }
    
    /// 预处理数组
    /// ^#b#a#n#a#n#a#s#$
    private func preprogress(_ s: String) -> String {
        var str: String = ""
        str.append("^")
        str.append("#")
        
        let sArray = Array(s)
        for c in sArray {
            str.append(c)
            str.append("#")
        }
        str.append("$")
        
        return str
    }
    
    
    // MARK: 扩展中心法
    /*
     遍历以相同字母作为中心，向两遍扩展，下一次遍历以上一次遍历的右边值为下一次i(省去很多遍历)
      l i       r
     "b a a a a b a d"
     遍历找到右边第一个不为a的字母，记为r
     i - 1 记为 l
     相当于以 aaaa为中心，向两遍扩展
     */
    func longestPalindrome2(_ s: String) -> String {
        
        let sArray = Array(s)
        
        var index = 0
        var maxLength = 1
        var start = 0
        while index < sArray.count {
            // 记录左边的index
            var left = index - 1
            
            // 寻找右边
            var right = index
            // 找出右边第一个不相等的index，记为right
            while right < sArray.count, sArray[right] == sArray[index] {
                right += 1
            }
            
            // right就位下一次循环的起始位置
            index = right
            
            // 确定left 和 right进行扩展
            while left >= 0, right < sArray.count, sArray[left] == sArray[right] {
                left -= 1
                right += 1
            }
            
            // 记录最大的长度
            // s[left + 1, right)就是这次的最大回文串
            left += 1
            let length = right - left
            if maxLength < length {
                start = left
                maxLength = length
            }
        }
        
        let startIndex = s.index(s.startIndex, offsetBy: start)
        let endIndex = s.index(s.startIndex, offsetBy: start + maxLength)
        return String(s[startIndex..<endIndex])
    }
    
    
    // MARK: 动态规划
    /*
     dp是大小n * n的二维数组，dp[i][j]表示s[i][j]是否为回文串，存储true，false
     如何求出dp[i][j]的值，分两种情况
     ① 如果s[i, j]的长度(j - i + 1) <= 2时
        如果s[i]等于s[j]，那么s[i, j]是回文串，所以dp[i][j] = s[i] == s[j]
     
     ② 如果s[i, j]的长度(j - i + 1) > 2时
        如果s[i + 1, j - 1]是回文串，并且s[i]等于s[j，那么s[i, j]是回文串
        所以dp[i][j] = dp[i + 1][j - 1] && (s[i] == s[j])
     */
    func longestPalindrome1(_ s: String) -> String {
        // 转成string
        let sArray = Array(s)
        
        var dp: [[Bool]] = Array(repeating: Array(repeating: false, count: s.count), count: s.count)
        var start: Int = 0
        var maxLength: Int = 0
        for i in (0 ..< sArray.count).reversed() {
            for j in i ..< sArray.count {
                // 字符串的长度
                let length: Int = j - i + 1
                dp[i][j] = sArray[i] == sArray[j] && (length <= 2 || dp[i + 1][j - 1])
                
                // 记录最长的串时的起始位置
                if dp[i][j], maxLength < length {
                    maxLength = length
                    start = i
                }
            }
        }
        
        
        let startIndex = s.index(s.startIndex, offsetBy: start)
        let endIndex = s.index(s.startIndex, offsetBy: start + maxLength)
        return String(s[startIndex..<endIndex])
    }
}
