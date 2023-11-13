//
//  SchedularView.swift
//  CombineFramework
//
//  Created by Neosoft on 09/11/23.
//

import Foundation
import SwiftUI

struct SchedulerView: View {
    @ObservedObject private var viewModel = SchedulerViewModel()

    var body: some View {
        VStack {
            Text("Current Time: \(viewModel.message)")
                .padding()
        }
    }
}

struct SchedulerView_Previews: PreviewProvider {
    static var previews: some View {
        SchedulerView()
    }
}
