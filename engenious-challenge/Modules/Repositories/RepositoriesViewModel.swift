//
//  DashboardViewModel.swift
//  engenious-challenge
//
//  Created by Юлія Воротченко on 10.01.2024.
//

import Foundation
import Combine

protocol RepositoriesViewModelInputs {
    func getRepositories()
}

protocol RepositoriesViewModelProtocol {
    var inputs: RepositoriesViewModelInputs { get set }
}

// MARK: - ViewModel
final class RepositoriesViewModel: BaseViewModel,
                                   RepositoriesViewModelProtocol,
                                   RepositoriesViewModelInputs {
    
    var inputs: RepositoriesViewModelInputs {
        get {
            return self
        }
        set {}
    }
    
    private var repositorysService: CombinedRepositoryServiceProtocol
    
    init(repositorysService: CombinedRepositoryServiceProtocol = RepositoryService()) {
        self.repositorysService = repositorysService
    }
    
    @Published var repositories: [Repository] = []
    
    // MARK: - Inputs
    func getRepositories() {
        self.isLoading.send(true)
        let repositoryDTO: RepositoryDTO = .init(username: "Apple")
        
        // MARK: - Here we using method from network layer build with Combine
        self.repositorysService.repositories(request: repositoryDTO)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                self.isLoading.send(false)
                switch completion {
                case .failure(let error):
                    self.displayMessage.send(error.localizedDescription)
                case .finished:
                    printIfDebug("Repos load finished")
                }
            } receiveValue: { repositoriesResponse in
                self.repositories = repositoriesResponse
            }.store(in: &cancellable)
        
        // MARK: - Here we using method from old network layer

//    self.repositorysService.repositories(repositoryDTO: repositoryDTO) { [weak self] result in
//        switch result {
//        case .success(let repos):
//            DispatchQueue.main.async {
//                self?.isLoading.send(false)
//                self?.repositories = repos
//            }
//        case .failure(let error):
//            DispatchQueue.main.async {
//                self?.isLoading.send(false)
//                self?.displayMessage.send(error.localizedDescription)
//            }
//        }
//    }
        
    }
}
