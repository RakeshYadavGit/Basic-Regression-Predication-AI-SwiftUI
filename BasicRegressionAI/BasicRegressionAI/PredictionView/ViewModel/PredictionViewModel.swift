//
//  PredictionViewModel.swift
//  BasicRegressionAI
//
//  Created by Rakesh Yadav on 02/08/25.
//

import Foundation
import TensorFlowLite

final class PredictionViewModel: ObservableObject {
    var interpreter: Interpreter?
    @Published var output: Float = 0.0
    
    func initializeInterpreter() {
        self.interpreter = loadModel()
    }
    
    private func loadModel() -> Interpreter? {
        guard let modelPath = Bundle.main.path(forResource: "linear", ofType: "tflite") else {
            return nil
        }
        
        do {
            let interpreter: Interpreter = try Interpreter(modelPath: modelPath)
            try interpreter.allocateTensors()
            return interpreter
        } catch {
            return nil
        }
    }
    
    private func getInput(input: String) -> Float? {
        if let input: Float = Float(input) {
            return input
        } else {
            return nil
        }
    }
    
    private func processInput(input: String) -> Data? {
        guard let input: Float = getInput(input: input) else {
            return nil
        }
        
        let inputValues: [Float] = [input]
        let data: Data = Data(bytes: inputValues, count: MemoryLayout<Float>.size * inputValues.count)
        return data
    }
    
    func predict(input: String) {
        guard let interpreter: Interpreter = self.interpreter, let data: Data = self.processInput(input: input) else {
            return
        }
        
        do {
            try interpreter.copy(data, toInputAt: 0)
            try interpreter.invoke()
            let predictionTensor: Tensor = try interpreter.output(at: 0)
            let data: Data = predictionTensor.data
            self.output = data.withUnsafeBytes({$0.load(as: Float.self)})
        } catch {
            self.output = 0.0
        }
        
       
    }
    
}
