//
//  DetailView.swift
//  AppleHealth_Test
//
//  Created by Tasuku Yamamoto on 7/29/22.
//

import SwiftUI

struct DetailView: View {
    
    var healthCategory: HealthCategory
    var healthStore: HealthStore
    @ObservedObject var detailViewModel: DetailViewModel
    
    init(healthCategory: HealthCategory, healthStore: HealthStore) {
        self.healthCategory = healthCategory
        self.healthStore = healthStore
        
        detailViewModel = DetailViewModel(healthCategory: healthCategory, healthStore: healthStore)
    }
    
    var body: some View {
        ChartView(values: detailViewModel.stats.map {detailViewModel.value(from: $0.stat).value},
                  labels: detailViewModel.stats.map {detailViewModel.value(from: $0.stat).desc},
                  xAxisLabels: detailViewModel.stats.map {DetailViewModel.dateFormatter.string(from: $0.date)})
        
        List(detailViewModel.stats) { stat in
            VStack(alignment: .leading) {
                Text(detailViewModel.value(from: stat.stat).desc)
                Text(stat.date, style: .date).opacity(0.5)
            }
        }
        .navigationBarTitle("\(healthCategory.name) \(healthCategory.image)", displayMode: .inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(healthCategory: HealthCategory(id: "Steps", name: "Steps", image: "👣"), healthStore: HealthStore())
    }
}
