//
//  FlipedString.swift
//  LeeCode
//
//  Created by Ocean on 2022/3/12.
//

/*
 字符串轮转。给定两个字符串s1和s2，请编写代码检查s2是否为s1旋转而成（比如，waterbottle是erbottlewat旋转后的字符串）。
 示例1:
  输入：s1 = "waterbottle", s2 = "erbottlewat"
  输出：True
 示例2:
  输入：s1 = "aa", s2 = "aba"
  输出：False
 提示：
 字符串长度在[0, 100000]范围内。
 说明:
 你能只调用一次检查子串的方法吗？

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/string-rotation-lcci
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

class FlipedString {
    static func isFlipedString(_ s1: String, _ s2: String) -> Bool {
        if s1.count != s2.count { return false }
        if s1 == s2 { return true }
        return (s1 + s1).contains(s2)
    }
}
