//
//  AddModel.swift
//  ToDO
//
//  Created by Дмитрий Юдин on 07.10.2021.
//

import Foundation

enum CellsConfiguration: CaseIterable {
    case textFieldName
    case textFieldDescription
    case toggle
    case startDate
    case endDate

    var text: String {
        switch self {
        case .textFieldName:
            return "Название"
        case .textFieldDescription:
            return "Описание"
        case .toggle:
            return "Весь день"
        case .startDate:
            return "Начало"
        case .endDate:
            return "Конец"
        }
    }

    var date: Date {
        switch self {
        case .startDate:
            return startOfDay
        case .endDate:
            var dateComponents = DateComponents()
            dateComponents.hour = 23
            dateComponents.minute = 59
            dateComponents.second = 59
            return Calendar.current.date(byAdding: dateComponents, to: startOfDay)!
        default:
            return Date()
        }
    }

    private var startOfDay: Date {
        return Calendar.current.startOfDay(for: Date())
    }
    
    static func getTypeForIndexPath(_ indexPath: IndexPath) -> CellsConfiguration? {
        if indexPath.section == 0 {
            return indexPath.row == 0 ? .textFieldName : .textFieldDescription
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                return .toggle
            } else {
                return indexPath.row == 1 ? .startDate : .endDate
            }
        }
        return nil
    }
}

enum TitleForSection {
    case naming, date

    var title: String {
        switch self {
        case .naming:
            return "Название и описание"
        case .date:
            return "Дата задачи"
        }
    }
}

