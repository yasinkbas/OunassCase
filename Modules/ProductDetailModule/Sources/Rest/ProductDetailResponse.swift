//
//  ProductDetailResponse.swift
//  OunassCase
//
//  Created by Yasin Akbas on 11.03.2025.
//

import Foundation

// generated via https://app.quicktype.io
// MARK: - ProductDetailResponse
struct ProductDetailResponse: Codable {
    let styleColorID, slug, visibleSku, name: String?
    let designerID: Int?
    let designerCategoryName, designerCategoryEnglishName, designerCategoryURL: String?
    let price: Int?
    let thumbnail: String?
    let media: [Media]?
    let simpleType, designerPlusSubClass: String?
    let breadcrumbs: [Breadcrumb]?
    let badge: Badge?
    let amberPoints: Int?
    let parentSku, nameInEnglish, categoryURL, color: String?
    let colorInEnglish: String?
    let colorID: Int?
    let productClassInEnglish, division, group, department: String?
    let pdpClass, subClass, gender, season: String?
    let exclusive, isClearance, isPromotion: Int?
    let isPriority: Bool?
    let priceInAED: Int?
    let gaCategory, onlineDateWithStock: String?
    let bnplPromoBanner: BnplPromoBanner?
    let shouldShowSwatchOptions: Bool?
    let colors: [Color]?
    let selectedColor: Color?
    let countryOfOrigin: String?
    let showSizeSelector: Bool?
    let sizeGuide: SizeGuide?
    let showSizePrice: Bool?
    let sizes: [Size]?
    let selectedSizeIndex: Int?
    let presale: Bool?
    let isExclusivePopUp: Int?
    let showDeliverySLA: Bool?
    let cities: [City]?
    let outOfStock: Bool?
    let contentTabs: [ContentTab]?
    let deliveryDetails: DeliveryDetails?
    let descriptionText: String?
    let recommendationTitle: String?
    let deepLinks: DeepLinks?

    enum CodingKeys: String, CodingKey {
        case styleColorID = "styleColorId"
        case slug, visibleSku, name
        case designerID = "designerId"
        case designerCategoryName, designerCategoryEnglishName
        case designerCategoryURL = "designerCategoryUrl"
        case price, thumbnail, media, simpleType, designerPlusSubClass, breadcrumbs, badge, amberPoints, parentSku, nameInEnglish
        case categoryURL = "categoryUrl"
        case color, colorInEnglish
        case colorID = "colorId"
        case productClassInEnglish, division, group, department
        case pdpClass = "class"
        case subClass, gender, season, exclusive, isClearance, isPromotion, isPriority, priceInAED, gaCategory, onlineDateWithStock, bnplPromoBanner, shouldShowSwatchOptions, colors, selectedColor, countryOfOrigin, showSizeSelector, sizeGuide, showSizePrice, sizes, selectedSizeIndex, presale, isExclusivePopUp, showDeliverySLA, cities, outOfStock, contentTabs, deliveryDetails, descriptionText, recommendationTitle, deepLinks
    }
}

// MARK: - Badge
struct Badge: Codable {
    let id: Int?
    let name, value, backgroundColor, borderColor: String?
    let fontColor, backgroundColorDarkMode, borderColorDarkMode, fontColorDarkMode: String?
}

// MARK: - BnplPromoBanner
struct BnplPromoBanner: Codable {
    let title: String?
    let options: [Option]?
}

// MARK: - Option
struct Option: Codable {
    let key: String?
    let logoURL: String?
    let moreInfoURL: String?
    let isAmountWithinLimits: Bool?

    enum CodingKeys: String, CodingKey {
        case key
        case logoURL = "logoUrl"
        case moreInfoURL = "moreInfoUrl"
        case isAmountWithinLimits
    }
}

// MARK: - Breadcrumb
struct Breadcrumb: Codable {
    let name: String?
    let categoryID: CategoryID?
    let urlPath: String?

    enum CodingKeys: String, CodingKey {
        case name
        case categoryID = "categoryId"
        case urlPath
    }
}

enum CategoryID: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(CategoryID.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for CategoryID"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - City
struct City: Codable {
    let cityID: String?
    let cityDefault: Bool?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case cityID = "cityId"
        case cityDefault = "default"
        case name
    }
}

// MARK: - Color
struct Color: Codable {
    let styleColorID, url, label, thumbnail: String?
    let hex: String?
    let isInStock: Bool?

    enum CodingKeys: String, CodingKey {
        case styleColorID = "styleColorId"
        case url, label, thumbnail, hex, isInStock
    }
}

// MARK: - ContentTab
struct ContentTab: Codable {
    let tabID, title, html, ctaText: String?
    let ctaURL: String?

    enum CodingKeys: String, CodingKey {
        case tabID = "tabId"
        case title, html, ctaText
        case ctaURL = "ctaUrl"
    }
}

// MARK: - DeepLinks
struct DeepLinks: Codable {
    let ios, android: String?
}

// MARK: - DeliveryDetails
struct DeliveryDetails: Codable {
    let tabID, title: String?
    let tabs: [Tab]?

    enum CodingKeys: String, CodingKey {
        case tabID = "tabId"
        case title, tabs
    }
}

// MARK: - Tab
struct Tab: Codable {
    let tabID, title: String?
    let delivery: Delivery?
    let returns: Returns?

    enum CodingKeys: String, CodingKey {
        case tabID = "tabId"
        case title, delivery, returns
    }
}

// MARK: - Delivery
struct Delivery: Codable {
    let title: String?
    let shipments: [Shipment]?
    let footnotes: [String]?
    let ctaText, ctaURL: String?

    enum CodingKeys: String, CodingKey {
        case title, shipments, footnotes, ctaText
        case ctaURL = "ctaUrl"
    }
}

// MARK: - Shipment
struct Shipment: Codable {
    let flag, sourceDescription: String?
    let methods: [Method]?
}

// MARK: - Method
struct Method: Codable {
    let title, description: String?
}

// MARK: - Returns
struct Returns: Codable {
    let title, description, ctaText, ctaURL: String?

    enum CodingKeys: String, CodingKey {
        case title, description, ctaText
        case ctaURL = "ctaUrl"
    }
}

// MARK: - Media
struct Media: Codable {
    let src: String?
}

// MARK: - SizeGuide
struct SizeGuide: Codable {
    let name, type, title: String?
    let columns: [[String]]?
}

// MARK: - Size
struct Size: Codable {
    let sku: String?
    let sizeCodeID: Int?
    let sizeCode: String?
    let price, priceInAED, amberPoints: Int?
    let disabled: Bool?
    let stock: Int?
    let isReturnable: Bool?
    let stockUrgencyText: String?

    enum CodingKeys: String, CodingKey {
        case sku
        case sizeCodeID = "sizeCodeId"
        case sizeCode, price, priceInAED, amberPoints, disabled, stock, isReturnable, stockUrgencyText
    }
}
