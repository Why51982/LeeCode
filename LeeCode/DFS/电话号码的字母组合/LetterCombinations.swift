//
//  LetterCombinations.swift
//  LeeCode
//
//  Created by Ocean on 2022/5/2.
//

/*
 给定一个仅包含数字 2-9 的字符串，返回所有它能表示的字母组合。答案可以按 任意顺序 返回。

 给出数字到字母的映射如下（与电话按键相同）。注意 1 不对应任何字母。

 示例 1：
 输入：digits = "23"
 输出：["ad","ae","af","bd","be","bf","cd","ce","cf"]
 示例 2：
 输入：digits = ""
 输出：[]
 示例 3：
 输入：digits = "2"
 输出：["a","b","c"]
 
 提示：
 0 <= digits.length <= 4
 digits[i] 是范围 ['2', '9'] 的一个数字。

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/letter-combinations-of-a-phone-number
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

class LetterCombinations {
    
    // MARK: DFS
    let letters  = [
        ["a", "b", "c"],
        ["d", "e", "f"],
        ["g", "h", "i"],
        ["j", "k", "l"],
        ["m", "n", "o"],
        ["p", "q", "r", "s"],
        ["t", "u", "v"],
        ["w", "x", "y", "z"]
    ]
    func letterCombinations(_ digits: String) -> [String] {
        if digits.isEmpty { return [] }
        
        var list: [String] = []
        var str: String = ""
        dfs(0, &str, digits, &list)
        return list
    }
    
    /// 正在搜索的index层
    private func dfs(_ index: Int, _ str: inout String, _ digits: String, _ list: inout [String]) {
        
        if index == digits.count {
            list.append(str)
            return
        }
        
        let digitArray = Array(digits)
        let digit = digitArray[index]
        
        // 转数字
        let num = Int(String(digit)) ?? 0
        let letterArray = letters[num - 2]
        for digit in letterArray {
            str.append(digit)
            dfs(index + 1, &str, digits, &list)
            str.removeLast()
        }
    }
}

class Lee {
    var res = [String]()
    var map = [
        2: ["a", "b", "c"],
        3: ["d", "e", "f"],
        4: ["g", "h", "i"],
        5: ["j", "k", "l"],
        6: ["m", "n", "o"],
        7: ["p", "q", "r", "s"],
        8: ["t", "u", "v"],
        9: ["w", "x", "y", "z"]
    ]
    func letterCombinations(_ digits: String) -> [String] {
        guard digits.count > 0 else {
            return res
        }
        let digits = Array(digits).map{Int(String($0))!}
        dfs(digits, 0, "")
        return res
    }
    func dfs(_ digits: [Int], _ index: Int, _ path: String) {
        if index == digits.count {
            res.append(path)
            return
        }
        for c in map[digits[index]]! {
            dfs(digits, index+1, path+c)
        }
    }
}
