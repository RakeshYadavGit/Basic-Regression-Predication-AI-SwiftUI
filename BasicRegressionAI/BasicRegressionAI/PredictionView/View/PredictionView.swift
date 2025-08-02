//
//  PredictionView.swift
//  BasicRegressionAI
//
//  Created by Rakesh Yadav on 02/08/25.
//

import SwiftUI

struct PredictionView: View {
    
    @StateObject var predictionViewModel: PredictionViewModel = PredictionViewModel()
    @State private var input: String = ""
    var body: some View {
        VStack {
            Text("Prediction for 2*input - 1")
                .font(.system(.title))
                .fontWeight(.heavy)
                .foregroundStyle(.pink)
                .padding(.vertical)
            Spacer(minLength: 0)
            Text("Model Prediction is \(self.predictionViewModel.output)")
                .frame(maxWidth: .infinity)
                .foregroundStyle(.pink)
                .padding(.vertical, 100)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.black)
                )
            TextField("Enter input here to predict...", text: self.$input)
                .frame(maxWidth: .infinity)
                .padding()
                .font(.system(.callout))
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.pink, lineWidth: 1)
                )
            Button {
                self.predictionViewModel.predict(input: self.input)
            } label: {
                Text("Predict")
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.pink)
            )
        }
        .padding()
        .onAppear {
            self.predictionViewModel.initializeInterpreter()
        }
    }
}

#Preview {
    PredictionView()
}
