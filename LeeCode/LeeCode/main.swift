//
//  main.swift
//  LeeCode
//
//  Created by Ocean on 2022/2/18.
//

import Foundation

// 只出现一次数字
//let nums = [4,1,2,1,2]
//let num = SingleNum.singleNumber(nums)
//print(num)

// 多数元素
//let nums = [6, 5, 5]
//let num = MoreNum.majorityElement1(nums)
//let num = MoreNum.majorityElement2(nums)
//debugPrint(num)

// 搜索二维矩阵
//let matrix = [[1,4,7,11,15],[2,5,8,12,19],[3,6,9,16,22],[10,13,14,17,24],[18,21,23,26,30]]
//let isHas = MatrixNum.searchMatrix(matrix, 31)
//debugPrint(isHas)

// 合并两个有序数组
//var nums1 = [2, 0]
//let m = 1, nums2 = [1], n = 1
//MergeArray.merge(&nums1, m, nums2, n)
//debugPrint(nums1)

// 颜色分类
//var nums = [2,0,2,1,1,0]
//SortColor.sortColors(&nums)
//debugPrint(nums)

// 部分排序
var nums = [1,2,4,7,10,11,7,12,6,7,16,18,19]
let indexs = PartialSort.subSort(nums)
debugPrint(indexs)
