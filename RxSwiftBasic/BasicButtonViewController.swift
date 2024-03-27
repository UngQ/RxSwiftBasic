//
//  BasicButtonViewController.swift
//  RxSwiftBasic
//
//  Created by ungQ on 3/26/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class BasicButtonViewController: UIViewController {

	let button = UIButton()
	let label = UILabel()

	let textField = UITextField()

	let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

		configureView()


		//observable : 버튼 탭
		//observer : 레이블에 텍스트 출력

		button //UIButton
			.rx //rx로 랩핑 Reactive<UIButton>
			.tap // ControlEvent<Void>
			.subscribe { _ in
				self.label.text = "버튼이 클릭되었습니다."
				self.present(BasicViewController(), animated: true)
			
			}
			.disposed(by: bag)

//		button.rx.tap
//			.bind { _ in
//				self.label.text = "버튼이 클릭"
//			}
//			.disposed(by: bag)

		textField //
			.rx
			.text //ControlProperty<String?>
			.orEmpty //ControlProperty<String>, 옵셔널 벗겨줌
			.map { $0.count } // Int
			.map { $0 > 4} // Bool
			.bind { value in
				self.button.backgroundColor = value ? .red : .blue
			}
			.disposed(by: bag)


    }
    
	func configureView() {
		view.backgroundColor = .white
		view.addSubview(button)
		view.addSubview(label)
		view.addSubview(textField)

		button.snp.makeConstraints { make in
			make.center.equalToSuperview()
			make.height.equalTo(50)
			make.width.equalTo(300)
		}

		label.snp.makeConstraints { make in
			make.top.horizontalEdges.equalTo(view.safeAreaInsets)
			make.height.equalTo(100)
		}

		textField.snp.makeConstraints { make in
			make.top.equalTo(label.snp.bottom).offset(20)
			make.horizontalEdges.equalTo(view.safeAreaInsets)
			make.height.equalTo(50)
		}

		textField.backgroundColor = .green

		button.backgroundColor = .lightGray
		button.setTitle("테스트 버튼", for: .normal)

		label.text = "테스트 레이블"
	}

}
