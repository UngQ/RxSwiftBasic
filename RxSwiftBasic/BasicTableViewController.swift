//
//  BasicTableViewController.swift
//  RxSwiftBasic
//
//  Created by ungQ on 3/26/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa


// UI Infinite ->
// DisposeBag 클래스가 deinit이 될 때, dispose 메서드가 호출이 된다.
// 그래서 뷰컨트롤러가 disposebag 클래스의 인스터를 갖고 있고, 뷰컨이 deinit이 잘 된다면, 별도 액션을 취하지않더라도 리소스 정리는 이루어집니다.


class BasicTableViewController: UIViewController {


	let tableView = UITableView()

	let items = Observable.just([
		"First Item",
		"Second Item",
		"Third Item"
	])

	let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()



		configureView()




		items
		.bind(to: tableView.rx.items) { (tableView, row, element) in
			let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
			cell.textLabel?.text = "\(element) @ row \(row)"
			return cell
		}
		.disposed(by: disposeBag)


		tableView.rx.itemSelected
			.subscribe { indexPath in
				print(indexPath)
			} onDisposed: {
				print("disposed")
			}
			.disposed(by: disposeBag)

		tableView.rx.modelSelected(String.self)
			.subscribe { model in
				print(model)
			}
			.disposed(by: disposeBag)



    }

	deinit {
		print("TableVC deinit")
	}


	func configureView() {
		view.backgroundColor = .white
		tableView.backgroundColor = .green

		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

		view.addSubview(tableView)
		tableView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}


}
