//
//  ProductListResponse.swift
//  OunassCase
//
//  Created by Yasin Akbas on 5.03.2025.
//

// generated via https://app.quicktype.io
struct ProductListResponse: Decodable {
    let breadcrumbs: [Breadcrumb]?
    let pageTitle: String?
    let plpBanner: PlpBanner?
    let facets: [Facet]?
    let pagination: Pagination?
    let sortBy: [SortBy]?
    let sortBySelectedIndex: Int?
    let styleColors: [StyleColor]?
    let noFilterURL: String?
    let quickFilters: [QuickFilter]?
    let showSeeAllDesignersButton: Bool?
    let feedbackFrom: FeedbackFrom?
    let semanticSearch: SemanticSearch?

    enum CodingKeys: String, CodingKey {
        case breadcrumbs, pageTitle, plpBanner, facets, pagination, sortBy, sortBySelectedIndex, styleColors
        case noFilterURL
        case quickFilters, showSeeAllDesignersButton, feedbackFrom, semanticSearch
    }
}

// MARK: - Breadcrumb
struct Breadcrumb: Codable {
    let categoryID: Int?
    let name, urlPath: String?

    enum CodingKeys: String, CodingKey {
        case categoryID
        case name, urlPath
    }
}

// MARK: - Facet
struct Facet: Codable {
    let title, catalogAttribute, name: String?
    let searchable, showCheckbox: Bool?
    let options: [Option]?
    let link: Link?
    let searchFieldPlaceholder: String?
    let globalrange: Globalrange?
    let action: String?
    let inputs: [[String]]?
}

// MARK: - Globalrange
struct Globalrange: Codable {
    let min, max: Int?
}

// MARK: - Link
struct Link: Codable {
    let type, text, href: String?
}

// MARK: - Option
struct Option: Codable {
    let optionID, name, href: String?
    let rel: Rel?
    let numberOfStyleColors: Int?
    let hex: String?
    let showBorder: Bool?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case optionID
        case name, href, rel, numberOfStyleColors, hex, showBorder, image
    }
}

enum Rel: String, Codable {
    case empty = ""
    case noindexNofollow = "noindex nofollow"
}

// MARK: - FeedbackFrom
struct FeedbackFrom: Codable {
    let url: String?
    let ratingID, commentID: String?

    enum CodingKeys: String, CodingKey {
        case url
        case ratingID
        case commentID
    }
}

// MARK: - Pagination
struct Pagination: Codable {
    let infinite: Bool?
    let totalItems, currentSet, viewSize: Int?
    let styleColorProgress: String?
    let previousPage: PreviousPage?
    let nextPage: NextPage?
    let pageText, pageProgress: String?
}

// MARK: - NextPage
struct NextPage: Codable {
    let label, href: String?
}

// MARK: - PreviousPage
struct PreviousPage: Codable {
    let label: String?
}

// MARK: - PlpBanner
struct PlpBanner: Codable {
    let contentTypeID, contentID, name, analyticsName: String?
    let analyticsTracking: Bool?
    let analyticsID: String?
    let headline: String?
    let mobileImage, desktopImage: Image?
    let description, descriptionDesktop: String?

    enum CodingKeys: String, CodingKey {
        case contentTypeID
        case contentID
        case name, analyticsName, analyticsTracking
        case analyticsID
        case headline, mobileImage, desktopImage, description, descriptionDesktop
    }
}

// MARK: - Image
struct Image: Codable {
    let contentTypeID, title, type: String?
    let details: Details?
    let url: String?
    let aspectRatio: Double?

    enum CodingKeys: String, CodingKey {
        case contentTypeID
        case title, type, details, url, aspectRatio
    }
}

// MARK: - Details
struct Details: Codable {
    let size: Int?
    let image: ImageClass?
}

// MARK: - ImageClass
struct ImageClass: Codable {
    let width, height: Int?
}

// MARK: - QuickFilter
struct QuickFilter: Codable {
    let optionID, name, href: String?
    let rel: Rel?
    let numberOfStyleColors: Int?
    let facetName: String?

    enum CodingKeys: String, CodingKey {
        case optionID
        case name, href, rel, numberOfStyleColors, facetName
    }
}

// MARK: - SemanticSearch
struct SemanticSearch: Codable {
    let searchMode: String?
}

// MARK: - SortBy
struct SortBy: Codable {
    let key, text, href: String?
}

// MARK: - StyleColor
struct StyleColor: Codable {
    let styleColorID, slug, designerCategoryName, thumbnail: String?
    let name: String?
    let simpleType: String?
    let parentSku: String?
    let discounted: String?
    let wishlistCount: Int?
    let url: String?
    let designerCategoryEnglishName, nameInEnglish, categoryURL, colorInEnglish: String?
    let productClassInEnglish: String?
    let division: String?
    let group: String?
    let department: String?
    let styleColorClass, subClass: String?
    let gender: String?
    let season: String?
    let exclusive: Int?
    let isClearance, isPriority, isPromotion: Bool?
    let designerPlusSubClass, hoverImage: String?
    let badge: Badge?
    let price: Int?
    let colors: [Color]?
    let sizes: [Size]?
    let showSizeSelector: Bool?

    enum CodingKeys: String, CodingKey {
        case styleColorID
        case slug, designerCategoryName, thumbnail, name, simpleType, parentSku, discounted, wishlistCount, url, designerCategoryEnglishName, nameInEnglish
        case categoryURL
        case colorInEnglish, productClassInEnglish, division, group, department
        case styleColorClass
        case subClass, gender, season, exclusive, isClearance, isPriority, isPromotion, designerPlusSubClass, hoverImage, badge, price, colors, sizes, showSizeSelector
    }
}

// MARK: - Badge
struct Badge: Codable {
    let id: Int?
    let name: String?
    let backgroundColor, borderColor: String?
    let fontColor, backgroundColorDarkMode, borderColorDarkMode: String?
    let fontColorDarkMode: String?
}

// MARK: - Color
struct Color: Codable {
    let styleColorID, url, hex, swatchImage: String?

    enum CodingKeys: String, CodingKey {
        case styleColorID
        case url, hex, swatchImage
    }
}

// MARK: - Size
struct Size: Codable {
    let sizeCodeID: Int?
    let sizeCode: String?
    let stock: Int?

    enum CodingKeys: String, CodingKey {
        case sizeCodeID
        case sizeCode, stock
    }
}
