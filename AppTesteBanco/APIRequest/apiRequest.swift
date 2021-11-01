//
//  apiRequest.swift
//  AppTesteBanco
//
//  Created by Virtual Machine on 14/10/21.
//

import Foundation
import Alamofire

enum APIErros: Error {
    case custom(message: String)
}

typealias Handler = (Swift.Result <NSDictionary, APIErros > ) -> Void
typealias statementHandler = (Swift.Result <[ListStatement], APIErros > ) -> Void

class ApiRequest {
    
    static let shareInstance = ApiRequest()

    func getLogin (login : RequestLogin, completionHandler: @escaping Handler) {
        
        let headers : HTTPHeaders = [
            .contentType("application/json")
        ]
        
        AF.request(loginUrl , method: .post , parameters: login , encoder: JSONParameterEncoder.default , headers: headers ).response { response in
            debugPrint(response)
            switch response.result {
            case.success(let data):
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    if response.response?.statusCode == 200{
                        completionHandler(.success(json as! NSDictionary))
                        
                    }else{
                        completionHandler(.failure(.custom(message: "Por favor, verifique sua conexão com a internet!")))
                    }
                }catch{
                    print(error.localizedDescription)
                    completionHandler(.failure(.custom(message: "Usuário e/ou senha inválidos")))
                }
            case.failure(let erro) :
                print(erro.localizedDescription)
                completionHandler(.failure(.custom(message: "Usuário e/ou senha inválidos")))
            }
        }
       
        
    }
        
    func getStatement (token: String, completionHandler: @escaping statementHandler) {
        
        let headers = [
//            .contentType("application/json"),
//            .accept(<#T##value: String##String#>)
            "token": token
            
        ] as HTTPHeaders
 
        
        AF.request(extratoUrl , method: .get, headers: headers).response { response in
            debugPrint(response)
            switch response.result {
            case.success(let data):
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    if response.response?.statusCode == 200{
                        completionHandler(.success(parseStatement(json: json as! [NSDictionary])))
                        
                    }else{
                        completionHandler(.failure(.custom(message: "Por favor, verifique sua conexão com a internet!")))
                    }
                }catch{
                    print(error.localizedDescription)
                    completionHandler(.failure(.custom(message: "Não foi possível exibir seu extrato")))
                }
            case.failure(let erro) :
                print(erro.localizedDescription)
                completionHandler(.failure(.custom(message: "Não foi possível exibir seu extrato")))
            
        }
        
    }

        func parseStatement(json: [NSDictionary]) -> [ListStatement] {
            var fullStatement: [ListStatement] = []
            for statement in json {
                let singleStatement = ListStatement (data: statement["data"] as! String , descricao: statement["descricao"] as! String , valor: statement["valor"] as! Double )
                fullStatement.append(singleStatement)
            }
            
            return fullStatement
        }
        
        
     
}
    
    
}

