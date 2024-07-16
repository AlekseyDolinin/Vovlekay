import UIKit

protocol CurrencyDelegate: AnyObject {
    func updateContent()
}

class Currency {
    
    weak var delegate: CurrencyDelegate?
    
    var id: Int
    var image: UIImage
    
    init(id: Int = 0, image: UIImage = UIImage()) {
        self.id = id
        self.image = image
    }
}


extension Currency {
    
    func parse(json: JSON) async {
        self.id = json["id"].intValue
        self.image = UIImage()
        
        delegate?.updateContent()
    }
}


//{
//  "image" : "\/upload\/t1\/store\/NONfr3u6zqu3BhhBg93w3pcF1y4Gl5zp.svg",
//  "id" : 2
//}
