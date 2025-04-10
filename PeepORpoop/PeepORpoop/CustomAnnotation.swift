//
//  CustomAnnotation.swift
//  PeepORpoop
//
//  Created by Денис Меркотун on 09.04.2025.
//

import SwiftUI

struct CustomAnnotation: View {
    
    let image: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(.background)
            RoundedRectangle(cornerRadius: 5)
                .stroke(.secondary, lineWidth: 5)
            Image(systemName: image)
                .padding(5)
        }
    }
}

#Preview {
    CustomAnnotation(image: "car")
}
