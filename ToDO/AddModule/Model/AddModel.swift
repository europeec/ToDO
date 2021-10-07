//
//  AddModel.swift
//  ToDO
//
//  Created by Дмитрий Юдин on 07.10.2021.
//

import Foundation

enum CellsConfiguration {
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

func getTypeForIndexPath(_ indexPath: IndexPath) -> CellsConfiguration? {
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
