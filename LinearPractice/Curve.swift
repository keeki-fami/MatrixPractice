//
//  Curve.swift
//  LinearPractice
//
//  Created by 櫻田聖和 on 2026/06/23.
//
import SwiftUI

struct RightCurve: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 300, y: 100)) // 始点
        path.addQuadCurve(
            to: CGPoint(x: 300, y: 300), // 終点
            control: CGPoint(x: 325, y: 200) // 制御点
        )
        return path
    }
}
struct LeftCurve: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
        path.move(to: CGPoint(x: w-50, y: 0)) // 始点
        path.addQuadCurve(
            to: CGPoint(x: w-50, y: h), // 終点
            control: CGPoint(x: w, y: h/2) // 制御点
        )

        return path
    }
}

struct CustomBracketShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // 中括弧（ { ）の左半分を描く例
        let width = rect.width
        let height = rect.height
        
        path.move(to: CGPoint(x: width, y: 0))
        path.addQuadCurve(to: CGPoint(x: width / 2, y: height / 4), control: CGPoint(x: width / 2, y: 0))
        path.addLine(to: CGPoint(x: width / 2, y: height * 3 / 8))
        path.addQuadCurve(to: CGPoint(x: 0, y: height / 2), control: CGPoint(x: 0, y: height / 2))
        path.addQuadCurve(to: CGPoint(x: width / 2, y: height * 5 / 8), control: CGPoint(x: 0, y: height / 2))
        path.addLine(to: CGPoint(x: width / 2, y: height * 3 / 4))
        path.addQuadCurve(to: CGPoint(x: width, y: height), control: CGPoint(x: width / 2, y: height))
        
        return path
    }
}

#Preview {
    LeftCurve()
}
