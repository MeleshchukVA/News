//
//  String+Extension.swift
//  News
//
//  Created by Владимир Мелещук on 04.04.2022.
//

import Foundation

extension String {
    
    // Функция конвертирует String в Date.
    func convertToDate() -> Date? {
        let dateFormatter           = DateFormatter()
        dateFormatter.dateFormat    = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale        = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone      = .current
        
        return dateFormatter.date(from: self)
    }
    
    // Функция конвертирует строку в дату, а затем отображает дату в строку в нужном формате.
    func convertToDisplayFormat() -> String {
        guard let date = self.convertToDate() else { return "N/A" }
        return date.convertToDayMonthYearHourMinuteFormat()
    }
}
