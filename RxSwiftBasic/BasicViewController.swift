//
//  BasicViewController.swift
//  RxSwiftBasic
//
//  Created by ungQ on 3/26/24.
//

import UIKit
import RxSwift
import RxCocoa

class BasicViewController: UIViewController {

	var disposeBag = DisposeBag()


    override func viewDidLoad() {
        super.viewDidLoad()

		view.backgroundColor = .white
		testInterval()

    }

	deinit {
		print("BasicVC deinit")
	}

	//scheduler(main/global. GCD)
	func testInterval() {
		let interval =
		Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)

		let intervalValue = interval
			.subscribe { value in
				print(value)
			} onError: { error in
				print("error")
			} onCompleted: {
				print("completed")
			} onDisposed: {
				print("disposed")
			}
			.disposed(by: disposeBag)

		let intervalValue2 = interval
			.subscribe { value in
				print(value)
			} onError: { error in
				print("error")
			} onCompleted: {
				print("completed")
			} onDisposed: {
				print("disposed")
			}
			.disposed(by: disposeBag) //영원히 종료되지 않는다.

		//5초 뒤에 메모리가 정리가 되면 좋겠다.ㄷ
		DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//
			self.disposeBag = DisposeBag()
			self.dismiss(animated: true)
//			//일일이 필요한 시점에 모든 구독을 해제해주는 것은 힘들 수 있따.
////			intervalValue.dispose()
////			intervalValue2.dispose()
		}

	}


	func testJust() {
		Observable
			.just([1,2,3])
			.subscribe { value in
				print(value)
			} onError: { error in
				print("Error")
			} onCompleted: {
				print("Completed") //completed -> notification
			} onDisposed: {
				print("Disposed") //구독해지, 유한한 시퀀스, 끝이 있음
			}
			.disposed(by: disposeBag)
	}

	func testOf() {
		Observable
			.of([1,2,3], [1,2,4], [1,2,5])
			.subscribe { value in
				print(value)
			} onError: { error in
				print("Error")
			} onCompleted: {
				print("Completed") //completed -> notification
			} onDisposed: {
				print("Disposed") //구독해지, 유한한 시퀀스, 끝이 있음
			}
			.disposed(by: disposeBag)

	}

	func testFrom() {
		Observable
			.from([1,2,3])
			.subscribe { value in
				print(value)
			} onError: { error in
				print("Error")
			} onCompleted: {
				print("Completed") //completed -> notification
			} onDisposed: {
				print("Disposed") //구독해지, 유한한 시퀀스, 끝이 있음
			}
			.disposed(by: disposeBag)

	}

}
