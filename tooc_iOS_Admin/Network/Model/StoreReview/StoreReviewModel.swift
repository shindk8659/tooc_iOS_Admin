
import Foundation
struct StoreReviewModel: Codable {
    let reviewUserImgResponseDtos : [ReviewUserImgResponseDtos]?
    let storeGradeReview : StoreGradeReview?
    
    enum CodingKeys: String, CodingKey {
        
        case reviewUserImgResponseDtos = "reviewUserImgResponseDtos"
        case storeGradeReview = "storeGradeReview"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        reviewUserImgResponseDtos = try values.decodeIfPresent([ReviewUserImgResponseDtos].self, forKey: .reviewUserImgResponseDtos)
        storeGradeReview = try values.decodeIfPresent(StoreGradeReview.self, forKey: .storeGradeReview)
    }
    
}
