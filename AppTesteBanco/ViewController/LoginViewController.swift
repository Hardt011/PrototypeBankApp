//
//  LoginViewController.swift
//  AppTesteBanco
//
//  Created by Virtual Machine on 08/10/21.
//

import UIKit
import Alamofire
import KeychainAccess

class LoginViewController: UIViewController {
    
    @IBOutlet weak var campoUser: UITextField!
    @IBOutlet weak var campoPassword: UITextField!
    @IBOutlet weak var lButton: UIButton!
    @IBOutlet weak var keySwitch: UISwitch!
    
    
    
    
    @IBAction func loginButton(_ sender: UIButton) {
        
        guard let username = campoUser.text else {return}
        guard let password = campoPassword.text else {return}
        
        
        let loginRequest = RequestLogin (username: username , password: password )
        
        ApiRequest.shareInstance.getLogin(login: loginRequest) {
            (result) in
            switch result {
            case .success(let json) :
                
                self.lButton.isEnabled = false
                
                let req = json as! NSDictionary
                
                let user = req ["nome"]
                let doc = req ["cpf"] as! String
                let bal = req ["saldo"] as! Double
                let tkn = req ["token"]
                
                let homeView = HomeViewController.shareInstance()
                homeView.userName = user as! String
                homeView.docNumber = Utils.cpfFormatter(cpfString: doc)
                homeView.balValue = Utils.numberFormatter(value: bal)
                homeView.tkn = tkn as! String
                
                //Guarda os dados de acesso na view
                self.keyChainSaveData()
                
                //Deleta caso o usuário não queira salvar
                self.keyChainDeleteData()
                
                
                self.navigationController!.pushViewController(homeView, animated: true)
                
                
            case .failure(let erro) :
                
                let alert = UIAlertController(title: "Ops!", message: "Usuário e/ou senha inválidos", preferredStyle: .alert)
                
                
                let closeAlert = UIAlertAction (title: "OK", style: .default)
                
                alert.addAction(closeAlert)
                
                self.present(alert, animated: true, completion: nil)
                
                self.lButton.isEnabled = true
                
            }
            
        }
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden( true, animated: true )
        
        keyChainShowData()
        
        self.lButton.isEnabled = true
        
        
    }
    func keyChainSaveData(){
        
        let keychain = Keychain(service: "com.filipe.AppTesteBanco")
        if (self.keySwitch.isOn == true){
            keychain["user"] = self.campoUser.text
            keychain["password"] = self.campoPassword.text
        }
        self.campoUser.text = ""
        self.campoPassword.text = ""
    }
    
    func keyChainDeleteData() {
        let keychain = Keychain(service: "com.filipe.AppTesteBanco")
        if (keySwitch.isOn == false){
            keychain["user"] = nil
            keychain["password"] = nil
        }
    }
    
    func keyChainShowData() {
        let keychain = Keychain(service: "com.filipe.AppTesteBanco")
        guard let user = keychain["user"] else {return}
        if (user != ""){
            keySwitch.isOn = true
        }
        self.campoUser.text = user
        
        guard let password = keychain["password"] else {return}
        if (password != ""){
            keySwitch.isOn = true
        }
        self.campoPassword.text = password
    }
    
}





