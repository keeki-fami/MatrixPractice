//
//  Profile.swift
//  LinearPractice
//
//  Created by 櫻田聖和 on 2026/06/30.
//
import SwiftUI

struct ProfileView: View {
    @AppStorage("failure") var failure: Int = 0
    @AppStorage("success") var success: Int = 0
    var body: some View {
        NavigationStack {
            VStack {
                Text("Coming Soon")
                    .font(.custom("Avenir Next", size: 20))
                    .foregroundStyle(.gray)
                Spacer()
                HStack {
                    Text("正解数:")
                    Spacer()
                    Text("\(success)")
                }
                HStack {
                    Text("正答率:")
                    Spacer()
                    Text("\((failure+success) == 0 ? "0.0%" : String(format: "%.1f", Double(success)*100/Double(failure+success)))%")
                }
                Spacer()
                Image("InfinityMatrix")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 0)
                Text("v1.0.0")
                    .foregroundStyle(.gray)
                Spacer()
            }
            .font(.custom("AndaleMono", size: 20))
            .padding(100)
//            .navigationTitle(Text("Profile"))
        }
    }
}
#Preview {
    ProfileView()
}
