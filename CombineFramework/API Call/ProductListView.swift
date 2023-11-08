//
//  File.swift
//  CombineFramework
//
//  Created by Neosoft on 07/11/23.
//

import Foundation
import SwiftUI

struct ProductListView: View {
    
    @EnvironmentObject var viewModel: ProductListViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.products, id: \.self) { product in
                HStack{
                    AsyncImage(url: URL(string: product.product_images ?? "")){ image in
                        image
                        .resizable()
                        .frame(width: 100, height: 100)
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                    
                    VStack(alignment: .leading){
                        Text("\(product.name ?? "")")
                            .font(.title2)
                        Text("\(product.producer ?? "")")
                            .font(.subheadline)
                        Text("Rs: \(product.cost ?? 0)")
                            .font(.title3)
                            .foregroundColor(.red)
                            .padding(.vertical,5)
                    }
                    .padding(.horizontal)
                }
                .alignmentGuide(.listRowSeparatorLeading) { d in
                    d[.leading] - 20 // Add 10 points of inset
                  }
            }
        }
        
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView()
    }
}
