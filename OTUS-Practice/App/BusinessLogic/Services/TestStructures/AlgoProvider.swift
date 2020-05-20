//
//  AlgoProvider.swift
//  OTUS-Practice
//
//  Created by Mak on 19.05.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import Foundation

enum Structures: String, CaseIterable {
    case array
    case set
    case dictionary
    case suffixArray
    
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

struct Algo {
    var name: String
    //var color
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
    
    lazy var allMapSuffix: [SuffixSequence] = all.map { SuffixSequence(string: $0) }
    
    
    var sortings: [Algo] {
        return [
            Algo(name: "Insertion Sort"),
            Algo(name: "Selection Sort"),
            Algo(name: "Shell Sort"),
            Algo(name: "Quicksort"),
            Algo(name: "Merge Sort"),
            Algo(name: "Heap Sort"),
            Algo(name: "Introsort"),
            Algo(name: "Counting Sort"),
            Algo(name: "Radix Sort"),
            Algo(name: "Topological Sort"),
            Algo(name: "Bubble Sort"),
            Algo(name: "Slow Sort")
        ]
    }
    
}
