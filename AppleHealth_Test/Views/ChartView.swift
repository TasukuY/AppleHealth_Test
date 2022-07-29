//
//  ChartView.swift
//  AppleHealth_Test
//
//  Created by Tasuku Yamamoto on 7/29/22.
//

import SwiftUI


struct ChartView: View {
    
    let values: [Int]
    let labels: [String]
    let xAxisLabels: [String]
    
    var body: some View {
        GeometryReader { geometry in
            
            HStack(alignment: .bottom) {
                
                ForEach(0 ..< values.count, id:\.self) { index in
                    
                    let max = values.max() ?? 0
                    let calculatedHeight = CGFloat(values[index]) / CGFloat(max) * geometry.size.height * 0.5
                    
                    VStack {
                        Text(labels[index])
                            .font(.caption)
                            .rotationEffect(.degrees(-60))
                        
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.orange)
                            .frame(width: 10, height: calculatedHeight)
                        
                        Text(xAxisLabels[index])
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.primary.opacity(0.3))
            .cornerRadius(10)
            .padding(.bottom, 20)
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        let values = [1, 2, 3, 4, 5, 6, 7, 8]
        let labels = ["a", "b", "c", "d", "e", "f", "g"]
        let xAxisValues = ["Jul 1", "Jul 2", "Jul 3", "Jul 4", "Jul 5", "Jul 6", "Jul 7", "Jul 8"]
        
        ChartView(values: values, labels: labels, xAxisLabels: xAxisValues)
    }
}

