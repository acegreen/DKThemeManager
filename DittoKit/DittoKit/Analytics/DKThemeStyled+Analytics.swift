//
//  DKThemeStyled+Analytics.swift
//  DittoKit
//
//  Created by Ace Green on 4/6/21.
//

import Foundation

public protocol DKInterfaceAnalyticsResponse: class {
    func shouldTrack(event eventName: String, inSections sections: [String]?)
}

extension DKThemeStyledButton: DKInterfaceAnalyticsResponse {
    public func shouldTrack(event eventName: String, inSections sections: [String]?) {
        //TODO: IMEGA-269 What should we do about these? 
    }
}

extension DKThemeStyledRDSButton: DKInterfaceAnalyticsResponse {
    public func shouldTrack(event eventName: String, inSections sections: [String]?) {
        //TODO: IMEGA-269
    }
}

extension DKThemeStyledToggleButton: DKInterfaceAnalyticsResponse {
    public func shouldTrack(event eventName: String, inSections sections: [String]?) {
        //TODO: IMEGA-269 TODO
    }
}

extension DKThemeStyledTextView: DKInterfaceAnalyticsResponse {
    public func shouldTrack(event eventName: String, inSections sections: [String]?) {
        //TODO: IMEGA-269
    }
}
