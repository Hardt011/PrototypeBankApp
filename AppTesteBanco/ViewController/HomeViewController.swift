//
//  HomeViewController.swift
//  AppTesteBanco
//
//  Created by Virtual Machine on 08/10/21.
//

import UIKit
import Alamofire


class HomeViewController: UIViewController {
   

    @IBOutlet weak var uName: UITextView!
    @IBOutlet weak var documentNumber: UITextView!
    @IBOutlet weak var balanceV: UITextView!
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var viewHome: UIView!
    
    
    
    let numero = NSNumber()
    var nf = NumberFormatter()
    
   
    //Variáveis dados do usuário
    var userName = ""
    var docNumber = ""
    var balValue = ""
    var tkn = ""
    
    //Variável dados do extrato
    
    var statementData : [ListStatement] = []
    
    @IBAction func logoutButton(_ sender: UIButton) {
        
        let logoutAlert = UIAlertController (title: "", message: "Deseja realmente sair?", preferredStyle: .alert)
        
        let confirm = UIAlertAction (title: "Confirmar", style: .default, handler: { _ in
            self.navigationController?.popViewController(animated: true)})
        
        
        let cancel = UIAlertAction (title: "Cancelar", style: .destructive)
        
        logoutAlert.addAction(confirm)
        logoutAlert.addAction(cancel)
        
        self.present(logoutAlert, animated: true, completion: nil)
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "StatementCell" , bundle: nil), forCellReuseIdentifier: "StatementCell")
        
        uName.text = userName
        documentNumber.text = docNumber
        balanceV.text = balValue
        
        getStatement(token: tkn)
        
        

        viewHome.gradientBackground(colorOne: colors.solutisLightBlue, colorTwo: colors.solutisBlue)
        
        
    
    }
    
    func getStatement(token: String){
        ApiRequest.shareInstance.getStatement(token: token) {
            (result) in
            switch result {
                case .success(let json) :
                    print(json)

                self.statementData = json
                self.tableView.reloadData()

                case .failure(let erro):
                    print ("Erro ao trazer extrato")
                
            }
        }
    }
    

    
            override func viewWillAppear(_ animated: Bool) {
                self.navigationController?.setNavigationBarHidden( true , animated: true )
    }
    
    
    
    
}

extension HomeViewController {
    static func shareInstance () -> HomeViewController{
        return HomeViewController.instantiateFromStoryboard("Main")
    }
}

extension HomeViewController : UITableViewDelegate {
    
}

extension HomeViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statementData.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         if let cell = tableView.dequeueReusableCell(withIdentifier: "StatementCell", for: indexPath) as? StatementCell {
             cell.statement = self.statementData[indexPath.row]
             
            return cell
        }
        
       return UITableViewCell()
    }
    

    
    
    
}





    
    
    




    
    
    
    



    
    

