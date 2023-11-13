//
//  SchedularViewModel.swift
//  CombineFramework
//
//  Created by Neosoft on 09/11/23.
//

import Foundation
import SwiftUI
import Combine

class SchedulerViewModel: ObservableObject {
    @Published var message: String = "0 : 0 : 0"

    private var cancellable: AnyCancellable?

    init() {
        
        // Create a timer publisher that emits values every second
        let timerPublisher = Timer.publish(every: 1.0, on: .main, in: .default).autoconnect()
        
        // Use receive(on:) to specify a background queue for processing values
        cancellable = timerPublisher
            .receive(on: DispatchQueue.global())
            .map { _ in
                return "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date())):\(Calendar.current.component(.second, from: Date()))"
            }
            .sink { [weak self] value in
                // Update the @Published property on the main queue
                DispatchQueue.main.async {
                    self?.message = value
                }
            }
    }
}
