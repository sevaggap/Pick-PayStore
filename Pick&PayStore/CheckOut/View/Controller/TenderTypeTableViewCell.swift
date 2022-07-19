//
//  TenderTypeTableViewCell.swift
//  Pick&PayStore
//
//  Created by Xavier on 7/18/22.
//

import UIKit

class TenderTypeTableViewCell: UITableViewCell {

    @IBOutlet weak var labelTenderTypeDesc: UILabel!
    @IBOutlet weak var imageTenderType: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(viewModel: TenderTypeViewModel) {
        self.labelTenderTypeDesc.text = viewModel.tenderTypeDesc
        self.imageTenderType.image = viewModel.isImageSytemImage ? UIImage(systemName: viewModel.tenderTypeImage) : UIImage(named: viewModel.tenderTypeImage)
        
        if viewModel.isImageSytemImage {
            self.imageTenderType.tintColor = .orange
        }
    }

}
