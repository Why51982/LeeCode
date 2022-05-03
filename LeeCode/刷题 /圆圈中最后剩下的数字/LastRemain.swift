//
//  LastRemain.swift
//  LeeCode
//
//  Created by Ocean on 2022/5/4.
//
/*
 0,1,···,n-1这n个数字排成一个圆圈，从数字0开始，每次从这个圆圈里删除第m个数字（删除后从下一个数字开始计数）。求出这个圆圈里剩下的最后一个数字。

 例如，0、1、2、3、4这5个数字组成一个圆圈，从数字0开始每次删除第3个数字，则删除的前4个数字依次是2、0、4、1，因此最后剩下的数字是3。

 示例 1：
 输入: n = 5, m = 3
 输出: 3
 示例 2：
 输入: n = 10, m = 17
 输出: 2

 限制：
 1 <= n <= 10^5
 1 <= m <= 10^6

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/yuan-quan-zhong-zui-hou-sheng-xia-de-shu-zi-lcof
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

class LastRemain {
    
    // 公式 f(n, m) = (f(n - 1, m) + m) % n
    
    // MARK: 解答
    // f(1, 3) = 0
    // f(2, 3) = (f(1, 3) + m) % 2
    // ....
    // f(8, 3) = (f(7, 3) + m) % 8
    // f(9, 3) = (f(8, 3) + m) % 9
    // f(10, 3) = (f(9, 3) + m) % 10
    
    func lastRemaining(_ n: Int, _ m: Int) -> Int {
        var remain = 0
        for i in 2 ... n {
            remain = (remain + m) % i
        }
        return remain
    }
}

// MARK: 最优解
extension LastRemain {
    func lastRemaining1(_ n: Int, _ m: Int) -> Int {
        if n <= 1 {
            return 0
        }
        let x = lastRemaining(n-1, m)
        return (x+m)%n
    }
}
