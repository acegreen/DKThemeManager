//
//  DKRDSIcons.swift
//  DittoKit
//
//  Created by Ace Green on 4/7/21.
//

import Foundation
import UIKit

public enum DKRDSIcons: String {
    /// Button
    case calendar = "rds-calendar"
    case cart = "rds-cart"
    case filter = "rds-filter"
    case help = "rds-help"
    case idCard = "rds-id-card"
    case info = "rds-info"
    case list = "rds-list"
    case locationPin = "rds-location-pin"
    case notification = "rds-notification"
    case search = "rds-search"
    case settings = "rds-settings"
    case startOver = "rds-start-over"
    case clear = "rds-clear"

    /// Indicator
    case twentyFourHours = "rds-24-hour"
    case alert = "rds-alert"
    case award = "rds-award"
    case checkmarkCircleFilled = "rds-checkmark-circle-filled"
    case checkmarkCircleOutlined = "rds-checkmark-circle-outlined"
    case coins = "rds-coins"
    case diamondCircle = "rds-diamond-circle"
    case heartFilled = "rds-heart-filled"
    case heartOutlined = "rds-heart-outlined"
    case reward = "rds-reward"
    case tier1 = "rds-tier-1"

    /// Navigation
    case arrowDown = "rds-arrow-down"
    case arrowUp = "rds-arrow-up"
    case chevronLeft = "rds-chevron-left"
    case chevronRight = "rds-chevron-right"
    case close = "rds-close"
    case collapse = "rds-collapse"
    case expand = "rds-expand"
    case linkOut = "rds-link-out"

    /// Toggle
    case checkboxSelected = "rds-checkbox-selected"
    case checkboxUnselected = "rds-checkbox-unselected"
    case hide = "rds-hide"
    case radioSelected = "rds-radio-selected"
    case radioUnselected = "rds-radio-unselected"
    case saveFilled = "rds-save-filled"
    case savedOutlined = "rds-saved-outlined"
    case show = "rds-show"
    case starRatingFilled = "rds-star-rating-filled"
    case starRatingOutlined = "rds-star-rating-outlined"

    public var image: UIImage? {
        return UIImage(named: self.rawValue, in: DittoKit.bundle, compatibleWith: nil)
    }
}
