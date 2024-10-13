//
//  HistoryViewModel.swift
//  Starbucks
//
//  Created by Oguz Mert Beyoglu on 13.10.2024.
//

import Foundation

struct HistoryViewModel {
    
    var sections = [HistorySection]()
    
    var transactions: [Transaction]? {
        didSet {
            guard let txs = transactions else { return }
            
            let firstMonth  = "Jul"
            let secondMonth = "Jun"
            let thirdMonth  = "May"
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.locale = Locale(identifier: "en_US")
            
            let firstMonthTransactions = txs.filter {
                let dateString = dateFormatter.string(from: $0.date)
                return dateString.starts(with: firstMonth)
            }
            
            let secondMonthTransactions = txs.filter {
                let dateString = dateFormatter.string(from: $0.date)
                return dateString.starts(with: secondMonth)
            }
            let thirdMonthTransactions = txs.filter {
                let dateString = dateFormatter.string(from: $0.date)
                return dateString.starts(with: thirdMonth)
            }
            
            let firstMonthSection  = HistorySection(title: "July", transactions: firstMonthTransactions)
            let secondMonthSection = HistorySection(title: "June", transactions: secondMonthTransactions)
            let thirdMonthSection  = HistorySection(title: "May", transactions: thirdMonthTransactions)
            
            sections = [HistorySection]()
            sections.append(firstMonthSection)
            sections.append(secondMonthSection)
            sections.append(thirdMonthSection)
            
        }
    }
}
