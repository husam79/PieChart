//
//  PieChart.swift
//  TestArc
//
//  Created by Husam Burhan on 28.12.2022.
//

import SwiftUI

struct PieInformation: Identifiable{
    var id = UUID()
    
    var title       : String
    var percent     : Double
    var color       : Color
    var startAngle  : Double = 0
}

struct PieChart: View {
    var pieInfos            : [PieInformation]
    var showLabels          : Bool = false
    var showLegend          : Bool = false
    private var dataNotValid: Bool = false
    
    init(pieInfos: [PieInformation]) {
        self.pieInfos = pieInfos
        
        
        var sum = self.pieInfos.reduce(0) { partialResult, pieInfo in
            partialResult + pieInfo.percent
        }
        
        if sum != 100 {
            dataNotValid = true
            return
        }
        
        var acc: Double = 0
        
        self.pieInfos[0].startAngle = 0
        
        for i in 1..<self.pieInfos.count {
            acc += pieInfos[i-1].percent/100*360
            self.pieInfos[i].startAngle = acc
        }
    }
    
    var body: some View {
        if dataNotValid {
            Text("Data is not valid!")
        } else {
            ZStack {
                ForEach(pieInfos) { pieInfo in
                    PieShape(startAngle: pieInfo.startAngle, percent: pieInfo.percent)
                        .fill(pieInfo.color)
                }
            }
        }
        
    }
}

struct PieChart_Previews: PreviewProvider {
    static var previews: some View {
        PieChart(pieInfos: [
            PieInformation(title: "", percent: 15, color: .green),
            PieInformation(title: "", percent: 55, color: .orange),
            PieInformation(title: "", percent: 25, color: .blue),
            PieInformation(title: "", percent: 5, color: .gray)
        ])
        .padding()
    }
}
