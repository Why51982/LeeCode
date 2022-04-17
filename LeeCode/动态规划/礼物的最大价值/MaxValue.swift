//
//  MaxValue.swift
//  LeeCode
//
//  Created by Ocean on 2022/4/17.
//
/*
 在一个 m*n 的棋盘的每一格都放有一个礼物，每个礼物都有一定的价值（价值大于 0）。你可以从棋盘的左上角开始拿格子里的礼物，并每次向右或者向下移动一格、直到到达棋盘的右下角。给定一个棋盘及其上面的礼物的价值，请计算你最多能拿到多少价值的礼物？

  

 示例 1:

 输入:
 [
   [1,3,1],
   [1,5,1],
   [4,2,1]
 ]
 输出: 12
 解释: 路径 1→3→5→2→1 可以拿到最多价值的礼物
  

 提示：

 0 < grid.length <= 200
 0 < grid[0].length <= 200


 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/li-wu-de-zui-da-jie-zhi-lcof
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

class MaxValue {
    func maxValue(_ grid: [[Int]]) -> Int {
        let rows = grid.count
        let columns = grid[0].count
        
        var dp: [[Int]] = Array(repeating: Array(repeating: 0, count: columns), count: rows)
        
        // 赋值初始值
        dp[0][0] = grid[0][0]
        
        for index in 1 ..< rows {
            dp[index][0] = dp[index - 1][0] + grid[index][0]
        }
        
        for index in 1 ..< columns {
            dp[0][index] = dp[0][index - 1] + grid[0][index]
        }
        
        for row in 1 ..< rows {
            for column in 1 ..< columns {
                dp[row][column] = max(dp[row - 1][column], dp[row][column - 1]) + grid[row][column]
            }
        }
        
        return dp[rows - 1][columns - 1]
    }
}
