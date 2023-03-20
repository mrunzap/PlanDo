//
//  SearchBar.swift
//  SearchDaumBlog
//
//  Created by Bo-Young PARK on 2021/09/08.
//

import RxSwift
import RxCocoa
import RxViewController

class SearchBar: UISearchBar {
    let disposeBag = DisposeBag()
    
    let searchButton = UIButton()
    
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        
       // bind()
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: SearchBarViewModel) {
        self.rx.text.debug("queryText")
            .bind(to: viewModel.queryText)
            
            .disposed(by: disposeBag)
        Observable
            .merge(
                // 옵저블 타입으로 변경. searchButtonClicked 하는 것을 관찰함
                self.rx.searchButtonClicked.asObservable(),
                // 검색버튼 클릭하는 것을 관찰함.
                searchButton.rx.tap.asObservable()
            )
            .debug("searchButtonTapped")
            .bind(to: viewModel.searchButtonTapped)
            .disposed(by: disposeBag)
        

        
        viewModel.searchButtonTapped
               .asSignal()
               .debug("asSignal")
               .emit(to: self.rx.endEditing)
               .disposed(by: disposeBag)


    }
    
    private func attribute() {
        searchButton.setTitle("검색", for: .normal)
        searchButton.setTitleColor(.systemBlue, for: .normal)
    }
    
    private func layout() {
        addSubview(searchButton)
        
        searchTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalTo(searchButton.snp.leading).offset(-12)
            $0.centerY.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12)
        }
    }
}

extension Reactive where Base: SearchBar {
    var endEditing: Binder<Void> {
        return Binder(base) { base, _ in
            base.endEditing(true)
        }
    }
}
