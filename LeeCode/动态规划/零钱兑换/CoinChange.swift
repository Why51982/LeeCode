//
//  CoinChange.swift
//  LeeCode
//
//  Created by Ocean on 2022/3/18.
//

/*
 给你一个整数数组 coins ，表示不同面额的硬币；以及一个整数 amount ，表示总金额。

 计算并返回可以凑成总金额所需的 最少的硬币个数 。如果没有任何一种硬币组合能组成总金额，返回 -1 。

 你可以认为每种硬币的数量是无限的。

  

 示例 1：
 输入：coins = [1, 2, 5], amount = 11
 输出：3
 解释：11 = 5 + 5 + 1
 示例 2：
 输入：coins = [2], amount = 3
 输出：-1
 示例 3：
 输入：coins = [1], amount = 0
 输出：0
 
 提示：
 1 <= coins.length <= 12
 1 <= coins[i] <= 231 - 1
 0 <= amount <= 104

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/coin-change
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

class CoinChange {
    func coinChange(_ coins: [Int], _ amount: Int) -> Int {
        if amount == 0 { return 0 }
        if amount < 1 || coins.isEmpty { return -1 }
        var dp: [Int] = Array(repeating: 0, count: amount + 1)
        for n in 1 ... amount {
            var minimum = Int.max
            for coin in coins {
                if n < coin || dp[n - coin] < 0 { continue }
                minimum = min(dp[n - coin], minimum)
            }
            if minimum == Int.max {
                dp[n] = -1
            } else {
                dp[n] = minimum + 1
            }
        }
        return dp[amount]
    }
}

// MARK: 递推(自底向上的调用)
class CoinChange3 {
    func coin(_ amount: Int) -> Int {
        var dp: [Int] = Array(repeating: 0, count: amount + 1)
        for n in 1 ... amount {
            var minimum = Int.max
            if n >= 1 { minimum = min(dp[n - 1], minimum) }
            if n >= 5 { minimum = min(dp[n - 5], minimum) }
            if n >= 20 { minimum = min(dp[n - 20], minimum) }
            if n >= 25 { minimum = min(dp[n - 25], minimum) }
            dp[n] = minimum + 1
        }
        return dp[amount]
    }
    
    // 打印出使用每个银币
    func printCoin(_ amount: Int) -> Int {
        var dp: [Int] = Array(repeating: 0, count: amount + 1)
        var faces: [Int] = Array(repeating: 0, count: amount + 1)
        for n in 1 ... amount {
            var minimum = Int.max
            if n >= 1, dp[n - 1] < minimum {
                minimum = dp[n - 1]
                faces[n] = 1
            }
            
            if n >= 5, dp[n - 5] < minimum {
                minimum = dp[n - 5]
                faces[n] = 5
            }
            
            if n >= 20, dp[n - 20] < minimum {
                minimum = dp[n - 20]
                faces[n] = 20
            }
            
            if n >= 25, dp[n - 25] < minimum {
                minimum = dp[n - 25]
                faces[n] = 25
            }
            dp[n] = minimum + 1
        }
        
        var n = amount
        while n > 0 {
            debugPrint(faces[n])
            n -= faces[n]
        }
        
        return dp[amount]
    }
}

// MARK: 记忆化搜索(自顶向下的调用)
class CoinChange2 {
    func coin(_ amount: Int) -> Int {
        var dp: [Int] = Array(repeating: 0, count: amount + 1)
        dp[1] = 1
        dp[5] = 1
        dp[20] = 1
        dp[25] = 1
        return coin(amount, &dp)
    }
    
    func coin(_ amount: Int, _ dp: inout [Int]) -> Int {
        if amount < 1 {
            return Int.max
        }
        
        if dp[amount] == 0 {
            let min1 = min(coin(amount - 1, &dp), coin(amount - 5, &dp))
            let min2  = min(coin(amount - 20, &dp), coin(amount - 25, &dp))
            dp[amount] = min(min1, min2) + 1
        }
        return dp[amount]
    }
}

// MARK: 暴力递归实现(自顶向下的调用，出现重叠子问题)
/*
 以 1，5，20，25为例
 */
class CoinChange1 {
    func coin(_ amount: Int) -> Int {
        if amount < 1 {
            return Int.max
        }
        
        if amount == 1 || amount == 5 || amount == 20 || amount == 25 {
            return 1
        }
        
        let min1 = min(coin(amount - 1), coin(amount - 5))
        let min2  = min(coin(amount - 20), coin(amount - 25))
        return min(min1, min2) + 1
    }
}
