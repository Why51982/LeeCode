//
//  PartialSort.swift
//  LeeCode
//
//  Created by Ocean on 2022/2/19.
//

/*
 给定一个整数数组，编写一个函数，找出索引m和n，只要将索引区间[m,n]的元素排好序，整个数组就是有序的。注意：n-m尽量最小，也就是说，找出符合条件的最短序列。函数返回值为[m,n]，若不存在这样的m和n（例如整个数组是有序的），请返回[-1,-1]。

 示例：

 输入： [1,2,4,7,10,11,7,12,6,7,16,18,19]
 输出： [3,9]
 提示：

 0 <= len(array) <= 1000000

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/sub-sort-lcci
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

struct PartialSort {
    static func subSort(_ array: [Int]) -> [Int] {
        guard array.count > 1 else {
            return [-1, -1]
        }
        
        // 从左往右遍历依次变大
        // 记录最大值
        var max = array[0]
        // 记录最右边逆序对index
        var right = -1
        
        var index = 0
        while index < array.count {
            let num = array[index]
            if num >= max {
                max = num
            } else {
                right = index
            }
            index += 1
        }
        
        if -1 == right {
            return [-1, -1]
        }
        
        // 从右往左遍历依次变小
        // 记录最小值
        var min = array[array.count - 1]
        // 记录最左边的逆序对index
        var left = -1
        
        index = array.count - 2
        while index >= 0 {
            let num = array[index]
            if num <= min {
                min = num
            } else {
                left = index
            }
            index -= 1
        }
        
        return [left, right]
    }
}
