//
//  SideMenuTableViewCell.swift
//  FakestoreApiEcommerce
//
//  Created by Abul Kashem on 27/12/22.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sideMenuImageView: UIImageView!
    @IBOutlet weak var sideMenuLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       self.sideMenuImageView.tintColor = .white
        
    }


    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
