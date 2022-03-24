//
//  Package.swift
//  LeeCode
//
//  Created by Ocean on 2022/3/24.
//
/*
 有n件物品和一个最大承重为 W 的背包，每件物品的重量是W[i]、价值为V[i]
 在保证总重量不超过 W 的前提下，选择某些物品装入背包，背包的最大价值是多少？
 注意：每个物品只有一件，也就是每个物品只能选择 0 件 或者 1 件
 
 假设 values 是价值数组， weights 是重量数组
 编号为k的物品，价值是values[k]，重量是 weights[k], k ∈ [0, n)
 */

import Foundation

class Package {
    // MARK: 动态规划(一位数组 注: 还可以优化空间复杂度(用长度短的作为dp的数组长度))
    func select(values: [Int], weights: [Int], capacity: Int) -> Int {
        guard !values.isEmpty, !weights.isEmpty, capacity > 0 else { return 0 }
        guard values.count == weights.count else { return 0 }
        // dp[i, j]是最大承重为j、有前i件物品可选时的最大总价值、i ∈ [0, n)、 j ∈ [0, W)
        var dp: [Int] = Array(repeating: 0, count: capacity + 1)
        
        for i in 1 ... values.count {
            for j in (1 ... capacity).reversed() {
//                if weights[i - 1] > j { // 不能选最后一件
//                    dp[j] = dp[j]
//                } else { // 能选最后一件(拿出选择和未选择的最大值)
//                    dp[j] = max(dp[j], dp[j - weights[i - 1]] + values[i - 1])
//                }
                
                if weights[i - 1] > j { continue }
                dp[j] = max(dp[j], dp[j - weights[i - 1]] + values[i - 1])
            }
        }
        return dp[capacity]
    }
    
    // MARK: 动态规划
    func select1(values: [Int], weights: [Int], capacity: Int) -> Int {
        guard !values.isEmpty, !weights.isEmpty, capacity > 0 else { return 0 }
        guard values.count == weights.count else { return 0 }
        // dp[i, j]是最大承重为j、有前i件物品可选时的最大总价值、i ∈ [0, n)、 j ∈ [0, W)
        var dp: [[Int]] = Array(repeating: Array(repeating: 0, count: capacity + 1), count: values.count + 1)
        
        for i in 1 ... values.count {
            for j in 1 ... capacity {
                if weights[i - 1] > j { // 不能选最后一件
                    dp[i][j] = dp[i - 1][j]
                } else { // 能选最后一件(拿出选择和未选择的最大值)
                    dp[i][j] = max(dp[i - 1][j], dp[i - 1][j - weights[i - 1]] + values[i - 1])
                }
            }
        }
        return dp[weights.count][capacity]
    }
}
