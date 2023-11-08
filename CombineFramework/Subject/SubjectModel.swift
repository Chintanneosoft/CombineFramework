//
//  SubjectModel.swift
//  CombineFramework
//
//  Created by Neosoft on 08/11/23.
//

import Foundation
import Combine

class DataModel: ObservableObject {
    @Published var message = ""
    let passThroughSubject = PassthroughSubject<String, Never>()
    let currentValueSubject = CurrentValueSubject<String, Never>("Initial Value")
}
