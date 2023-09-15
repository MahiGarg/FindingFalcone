//
//  ResultViewModel.swift
//  FindingFalcone
//
//  Created by Mahi Garg on 13/09/23.
//

import Foundation

class ResultViewModel: BaseViewModel, ObservableObject {
    @Published var findResponse: FindResponse = FindResponse(planetName: "",
                                                             status: "",
                                                             error: "")
}

extension ResultViewModel {
    func findFalcon(findRequest: FindRequest) {
        FalconRepository.instance.findFalcon(request: findRequest) { data in
            self.findResponse = data
        } onError: { error in
            self.afError = error
        }

    }
}
