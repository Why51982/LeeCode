//
//  Anagram.swift
//  LeeCode
//
//  Created by Ocean on 2022/3/13.
//
/*
 给定两个字符串 s 和 t ，编写一个函数来判断 t 是否是 s 的字母异位词。

 注意：若 s 和 t 中每个字符出现的次数都相同，则称 s 和 t 互为字母异位词。

 示例 1:
 输入: s = "anagram", t = "nagaram"
 输出: true
 示例 2:
 输入: s = "rat", t = "car"
 输出: false
 
 提示:
 1 <= s.length, t.length <= 5 * 104
 s 和 t 仅包含小写字母
 
 进阶: 如果输入字符串包含 unicode 字符怎么办？你能否调整你的解法来应对这种情况？

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/valid-anagram
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

class Anagram {
    // MARK: 最优解
    func isAnagram(_ s: String, _ t: String) -> Bool {
        guard s.count == t.count else { return false }
        
        var tmp = [Int](repeating: 0, count: 26)
        let b = Int("a".utf8.first!) // 97

        for c in Array(s.utf8) {
            tmp[Int(c) - b] += 1
        }
        
        for c in Array(t.utf8) {
            tmp[Int(c) - b] -= 1
            if tmp[Int(c) - b] < 0 {
                return false
            }
        }
        
        return true
    }
}
    
    // MARK: 运用字典
    func isAnagram0(_ s: String, _ t: String) -> Bool {
        guard s.count == t.count else { return false }
        
        var map: [Character: Int] = [:]
        
        s.forEach({ map[$0, default: 0] += 1 })
        t.forEach({ map[$0, default: 0] -= 1 })
        
        return map.filter({ $0.value != 0 }).count == 0
    }
    
    // MARK: 可行，但是耗时太长，估计string.index计算耗时长
    func isAnagram1(_ s: String, _ t: String) -> Bool {
        guard s.count == t.count else { return false }
        // 初始化空间为26的数组(26个小写英文字母)
        var countArray: [Int] = Array(repeating: 0, count: 26)
        let aASCII = Character("a").asciiValue!
        for index in 0 ..< s.count {
            let sCharIndex = s.index(s.startIndex, offsetBy: index)
            let sChar = s[sCharIndex]
            countArray[Int(sChar.asciiValue! - aASCII)] += 1
        }
        
        for index in 0 ..< t.count {
            let tCharIndex = t.index(t.startIndex, offsetBy: index)
            let tChar = t[tCharIndex]
            countArray[Int(tChar.asciiValue! - aASCII)] -= 1
            if countArray[Int(tChar.asciiValue! - aASCII)] < 0 {
                return false
            }
        }
        return true
    }
}
