//
//  MinDistance.swift
//  LeeCode
//
//  Created by Ocean on 2022/4/17.
//
/*
 给你两个单词 word1 和 word2， 请返回将 word1 转换成 word2 所使用的最少操作数  。

 你可以对一个单词进行如下三种操作：
 插入一个字符
 删除一个字符
 替换一个字符

 示例 1：
 输入：word1 = "horse", word2 = "ros"
 输出：3
 解释：
 horse -> rorse (将 'h' 替换为 'r')
 rorse -> rose (删除 'r')
 rose -> ros (删除 'e')
 
 示例 2：
 输入：word1 = "intention", word2 = "execution"
 输出：5
 解释：
 intention -> inention (删除 't')
 inention -> enention (将 'i' 替换为 'e')
 enention -> exention (将 'n' 替换为 'x')
 exention -> exection (将 'n' 替换为 'c')
 exection -> execution (插入 'u')

 提示：
 0 <= word1.length, word2.length <= 500
 word1 和 word2 由小写英文字母组成

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/edit-distance
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

class MinDistance {
    // MARK: 最优解
    func minDistance(_ word1: String, _ word2: String) -> Int {
           let arr1 = Array(word1)
           let arr2 = Array(word2)
           var dp = [[Int]](repeating:[Int](repeating:-1, count:arr2.count + 1), count:arr1.count + 1)
           dp[0][0] = 0
            dp[arr1.count][arr2.count] = dfs(&dp, arr1, arr2, arr1.count, arr2.count)
            // print("dp \(dp)")
           return dp[arr1.count][arr2.count]
        }

        func dfs(_ dp: inout [[Int]], _ arr1: [Character], _ arr2: [Character], _ i: Int, _ j: Int) -> Int {
            if i == 0 || j == 0 {
                return max(i, j)
            }
            if dp[i][j] != -1 {
                return dp[i][j]
            }

            if arr1[i-1] == arr2[j-1] {
                dp[i][j] = dfs(&dp, arr1, arr2, i - 1, j - 1)
                return dp[i][j]
            }

            let t1 = dfs(&dp, arr1, arr2, i, j - 1) + 1
            let t2 = dfs(&dp, arr1, arr2, i - 1, j - 1) + 1
            let t3 = dfs(&dp, arr1, arr2, i-1, j) + 1
            dp[i][j] = min(t1, t2, t3)
            return dp[i][j]
        }
    
    // MARK: 思路
    // dp[i][j]是s1[0, i)转化到s2[0, j)的最少操作数
    // s1[0, i)是由s1的前i个字符组成的子串
    // s2[0, j)是由s2的前j个字符组成的子串
    
    // 最后一步操作
    // 删除 dp[i][j] = dp[i - 1][j] + 1 (先删除s1[0, i]的最后一个字符s1[0, i - 1) 再s1[0, i - 1)转化为s2[0, j))
    // 插入 dp[i][j] = dp[i][j - 1] + 1
    // 转化
    // 1.s1[i - 1] == s2[j - 1] dp[i][j] = dp[i - 1][j - 1]
    // 2.s1[i - 1] != s2[j - 1] dp[i][j] = dp[i - 1][j - 1] + 1
    func minDistance1(_ word1: String, _ word2: String) -> Int {
        if word1.isEmpty || word2.isEmpty { return max(word1.count, word2.count) }
        
        let word1Array = word1.utf8.map{ $0 }
        let word2Array = word2.utf8.map{ $0 }
        
        var dp: [[Int]] = Array(repeating: Array(repeating: 0, count: word2.count + 1), count: word1.count + 1)
        dp[0][0] = 0
        
        // 赋值初始值
        // 行
        for index in 1 ... word1.count {
            dp[index][0] = index
        }
        
        // 列
        for index in 1 ... word2.count {
            dp[0][index] = index
        }
        
        for i in 1 ... word1.count {
            for j in 1 ... word2.count {
                let left = dp[i - 1][j] + 1
                let top = dp[i][j - 1] + 1
                var leftTop = dp[i - 1][j - 1]
                if word1Array[i - 1] != word2Array[j - 1] {
                    leftTop += 1
                }
                
                // 取出最小值
                dp[i][j] = min(left, top, leftTop)
            }
        }
        
        return dp[word1.count][word2.count]
    }
}
