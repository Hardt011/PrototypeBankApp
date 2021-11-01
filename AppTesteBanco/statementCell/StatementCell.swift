//
//  StatementCell.swift
//  AppTesteBanco
//
//  Created by Virtual Machine on 21/10/21.
//

import UIKit


class StatementCell: UITableViewCell {
    
    @IBOutlet weak var transactionType: UILabel!
    @IBOutlet weak var transactionDescription: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var backGroundView: UIView!
    
    

    

    
    
    var statement : ListStatement! {
        didSet {
            self.transactionDescription.text = statement.descricao
            self.date.text = Utils.formatDate(date: statement.data)
            self.value.text = Utils.numberFormatter(value: statement.valor)
            if statement.valor < 0 {
                self.transactionType.text = "Pagamento"
                self.value.textColor = colors.valueRed
            }else {
                self.transactionType.text = "Recebimento"
                self.value.textColor = colors.valueGreen
            }
            
            
           
        }
        
    }
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    
        viewCell.layer.cornerRadius = 20.0
        viewCell.layer.masksToBounds = true
        
        backGroundView.layer.cornerRadius = 20.0
        backGroundView.layer.masksToBounds = true
        
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   
    
}




