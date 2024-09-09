//
//  DoubleUtils.swift
//  SearchingML
//
//  Created by Juan Camilo Garzon Patino on 6/09/24.
//

import Foundation

extension Double {
    func removeTrailingZeros() -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
    
    func discountRate(finalPrice: Double) -> Double {
            let discount = ((self - finalPrice) / self) * 100
            return discount
        }
}
