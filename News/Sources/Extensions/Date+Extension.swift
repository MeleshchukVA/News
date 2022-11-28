//
//  Date+Extension.swift
//  News
//
//  Created by Владимир Мелещук on 04.04.2022.
//

import Foundation

extension Date {
    
    // Фукнция конвертирует дату в строку формата "02.03.22 13:37".
    func convertToDayMonthYearHourMinuteFormat() -> String {
        return formatted(.dateTime.day().month(.twoDigits).year().hour().minute())
    }
}
