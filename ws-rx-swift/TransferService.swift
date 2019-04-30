//
//  TransferService.swift
//  ws-rx-swift
//
//  Created by Fernando Cruz on 30/04/19.
//  Copyright © 2019 cocoaheads. All rights reserved.
//

import Foundation
import RxSwift

protocol TransferService {
    func makeTransfer(transfer: Transfer) -> Single<Protocol>
}

class MockTransferService: TransferService {
    
    func makeTransfer(transfer: Transfer) -> Single<Protocol> {
        
        return Single<Protocol>.create { single in
            
            self.createProtocol(for: transfer, completation: { (newProtocol, error) in
                if let error = error {
                    single(.error(error))
                    return
                }
                
                if let newProtocol = newProtocol {
                    single(.success(newProtocol))
                }
            })
            
            return Disposables.create()
        }
    }
}

extension MockTransferService {
    
    func createProtocol(for transfer: Transfer, completation: @escaping (Protocol?, Error?) -> Void ) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let newProtocol = Protocol(number: "3745353191244", transactionValue: transfer.value)
            completation(newProtocol,nil)
        }
        
    }
}
