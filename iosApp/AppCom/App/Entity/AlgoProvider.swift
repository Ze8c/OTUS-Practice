//
//  AlgoProvider.swift
//  OTUS-Practice
//
//  Created by Mak on 19.05.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import Foundation

enum Structures: String, CaseIterable {
    case suffixArray
    case set
    case dictionary
    case array
    
    var processor: TestStructureProcessor {
        switch self {
        case .array:
            return ArrayProcessor()
        case .set:
            return SetProcessor()
        case .dictionary:
            return DictionaryProcessor()
        case .suffixArray:
            return SuffixArrayProcessor()
        }
    }
    
    var nameForWatch: String {
        let tmpValue: String
        switch self {
        case .array:
            tmpValue = "[]"
        case .set:
            tmpValue = "Set"
        case .dictionary:
            tmpValue = "[:]"
        case .suffixArray:
            tmpValue = "Suffix"
        }
        return tmpValue
    }
}

struct SuffixIterator: IteratorProtocol {
    
    let string: String
    var offset: String.Index
    
    init(string: String) {
        self.string = string
        offset = string.startIndex
    }
    
    mutating func next() -> Substring? {
        guard offset < string.endIndex else { return nil }
        offset = string.index(after: offset)
        return string[..<offset]
    }
}

struct SuffixSequence: Sequence {
    
    let string: String
    
    func makeIterator() -> SuffixIterator {
        return SuffixIterator(string: string)
    }
}

struct AlgoProvider {
    
    var all: [String] {
        return [
            // Searching
            "Linear Search",
            "Binary Search",
            "Count Occurrences",
            "Select Minimum / Maximum",
            "k-th Largest Element",
            "Selection Sampling",
            "Union-Find",
            // String Search
            "Brute-Force String Search",
            "Boyer-Moore",
            "Knuth-Morris-Pratt",
            "Rabin-Karp",
            "Longest Common Subsequence",
            "Z-Algorithm",
            // Sorting
            "Insertion Sort",
            "Selection Sort",
            "Shell Sort",
            "Quicksort",
            "Merge Sort",
            "Heap Sort",
            "Introsort",
            "Counting Sort",
            "Radix Sort",
            "Topological Sort",
            "Bubble Sort",
            "Slow Sort",
            // Compression
            "Run-Length Encoding (RLE)",
            "Huffman Coding",
            // Miscellaneous
            "Shuffle",
            "Comb Sort",
            "Convex Hull",
            "Miller-Rabin Primality Test",
            "MinimumCoinChange",
            "Genetic",
            "Myers Difference Algorithm",
            // Mathematics
            "Greatest Common Divisor (GCD)",
            "Permutations and Combinations",
            "Shunting Yard Algorithm",
            "Karatsuba Multiplication",
            "Haversine Distance",
            "Strassen's Multiplication Matrix",
            // Machine learning
            "k-Means Clustering",
            "Linear Regression",
            "Naive Bayes Classifier",
            "Simulated annealing",
        ]
    }
}
