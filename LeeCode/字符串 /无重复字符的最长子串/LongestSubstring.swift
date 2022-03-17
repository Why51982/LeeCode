//
//  LongestSubstring.swift
//  LeeCode
//
//  Created by Ocean on 2022/3/17.
//

/*
 给定一个字符串 s ，请你找出其中不含有重复字符的 最长子串 的长度。

 示例 1:
 输入: s = "abcabcbb"
 输出: 3
 解释: 因为无重复字符的最长子串是 "abc"，所以其长度为 3。
 示例 2:

 输入: s = "bbbbb"
 输出: 1
 解释: 因为无重复字符的最长子串是 "b"，所以其长度为 1。
 示例 3:

 输入: s = "pwwkew"
 输出: 3
 解释: 因为无重复字符的最长子串是 "wke"，所以其长度为 3。
      请注意，你的答案必须是 子串 的长度，"pwke" 是一个子序列，不是子串。
  

 提示：

 0 <= s.length <= 5 * 104
 s 由英文字母、数字、符号和空格组成

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/longest-substring-without-repeating-characters
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

class LongestSubstring {
    // MARK: 完全自己实现
    func lengthOfLongestSubstring(_ s: String) -> Int {
        guard !s.isEmpty else { return 0 }
        
        // 记录每一个字符出现的位置(单字节ASCII码，最多就是128个)
        var preIndexs: [Int] = Array(repeating: -1, count: 128)
        // 记录i - 1无重复字符串的长度的左边index
        var leftIndex: Int = 0
        // 转array
        let strArray = s.utf8.map({ $0 })
        // 存储最长的字符串长度
        var maxLegth = 0
        for index in 0 ..< strArray.count {
            // 获取该字符的上一次出现的index
            let preIndex = preIndexs[Int(strArray[index])]
            
            if preIndex >= leftIndex {
                leftIndex = preIndex + 1
            }
            
            // 存储这个位置的值
            preIndexs[Int(strArray[index])] = index
            
            // 记录最大值
            maxLegth = max(maxLegth, index - leftIndex + 1)
        }
        return maxLegth
    }
    
    // MARK: 借助系统函数
    func lengthOfLongestSubstring0(_ s: String) -> Int {
            var curChars = [Character]()
            var maxCount = 0
            for c in s{
                if curChars.contains(c) {
                    curChars.removeFirst(curChars.firstIndex(of: c)! + 1)
                }
                curChars.append(c)
                if curChars.count > maxCount{
                    maxCount = curChars.count
                }
            }
            return maxCount;

        }
}
