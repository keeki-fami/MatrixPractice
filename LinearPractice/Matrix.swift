//
//  Matrix.swift
//  LinearPractice
//
//  Created by 櫻田聖和 on 2026/06/23.
//

import SwiftUI

struct MatrixView: View {
    
    var body: some View {
        
    }
}

enum CalculateType {
    case add
    case sub
    case mul
}

struct Matrix: Identifiable {
    var id = UUID()
    var rowDim = 3
    var colDim = 3
    var matrix: [[Int]] = []
}

@Observable
class MatrixGenerator {
    var rowDim = 3
    var colDim = 3
    var matrix1: Matrix = .init()
    var matrix2: Matrix = .init()
    var matrixAnswer: Matrix = .init()
    var calculateType: CalculateType = .add
    var answerPointX: Int = 0
    var answerPointY: Int = 0
    var combo: Int = 0
    
    func generate(row1: Int, col1: Int, row2: Int, col2: Int, type: CalculateType) {
        var matrix: [[Int]] = []
        for i in 0..<row1 {
            var row: [Int] = []
            for j in 0..<col1 {
                row.append(Int.random(in: 0...10))
            }
            matrix.append(row)
        }
        matrix1 = Matrix(rowDim: row1, colDim: col1, matrix: matrix)
        
        matrix = []
        for i in 0..<row1 {
            var row: [Int] = []
            for j in 0..<col1 {
                row.append(Int.random(in: 0...10))
            }
            matrix.append(row)
        }
        matrix2 = Matrix(rowDim: row2, colDim: col2, matrix: matrix)
        
        calculateType = type
        
        generateAnswer()
    }
    
    func generateAnswer() {
        switch calculateType {
        case .add:
            generateAddAnswer()
        case .sub:
            generateSubAnswer()
        case .mul:
            print("c")
        default:
            break
        }
        
        answerPointX = Int.random(in: 0..<matrixAnswer.rowDim)
        answerPointY = Int.random(in: 0..<matrixAnswer.colDim)
    }
    
    func generateAddAnswer() {
        if matrix1.rowDim != matrix2.rowDim || matrix1.colDim != matrix2.colDim {
            // TODO: エラー
            print("ダメです")
        }
        
        var matrix: [[Int]] = []
        for i in 0..<matrix1.rowDim {
            var row: [Int] = []
            for j in 0..<matrix1.colDim {
                row.append(matrix1.matrix[i][j] + matrix2.matrix[i][j])
            }
            matrix.append(row)
        }
        
        matrixAnswer = .init(rowDim: matrix1.rowDim, colDim: matrix1.colDim, matrix: matrix)
    }
    
    func generateSubAnswer() {
        if matrix1.rowDim != matrix2.rowDim || matrix1.colDim != matrix2.colDim {
            // TODO: エラー
            print("ダメです")
        }
        
        var matrix: [[Int]] = []
        for i in 0..<matrix1.rowDim {
            var row: [Int] = []
            for j in 0..<matrix1.colDim {
                row.append(matrix1.matrix[i][j] - matrix2.matrix[i][j])
            }
            matrix.append(row)
        }
        
        matrixAnswer = .init(rowDim: matrix1.rowDim, colDim: matrix1.colDim, matrix: matrix)
    }
    
    func generateMulAnswer() {
        if matrix1.colDim != matrix2.rowDim {
            // TODO: エラー
            print("ダメです")
        }
        
        let row = matrix1.rowDim
        let col = matrix2.colDim
        
        var matrix: [[Int]] = []
        for i in 0..<matrix1.rowDim {
            var row: [Int] = []
            for j in 0..<matrix1.colDim {
                row.append(matrix1.matrix[i][j] - matrix2.matrix[i][j])
            }
            matrix.append(row)
        }
        
        matrixAnswer = .init(rowDim: matrix1.rowDim, colDim: matrix1.colDim, matrix: matrix)
    }
}
