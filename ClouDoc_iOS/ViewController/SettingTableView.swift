//
//  test.swift
//  ClouDoc_iOS
//
//  Created by mac on 2022/02/24.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

class SettingTableView:UITableView {
    let bag = DisposeBag()
    let settingTableViewVM = SettingTableViewModel()
    let customDataSource = RxTableViewSectionedReloadDataSource<SectionOfSettingItem> { (datasource, tableView, indexPath,  element) in
        let cell = tableView.dequeueReusableCell(withIdentifier: "NameCell", for: indexPath)
        if #available(iOS 14.0, *) {
            var config = cell.defaultContentConfiguration()
            
            let l = UILabel().then { 
                $0.text = element.title
                $0.layer.borderWidth = 1
                $0.textAlignment = .center   
            }
            
            cell.backgroundColor = .white
            cell.layer.cornerRadius = 10
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.clear.cgColor
            
            cell.selectionStyle = .none
            cell.contentView.addSubview(element.valueUI)
            cell.contentView.addSubview(l)
            
            l.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
              l.setContentHuggingPriority(.defaultHigh, for: .horizontal)           

            l.textAlignment = .left
            l.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.left.equalToSuperview().inset(12)
//                make.width.greaterThanOrEqualToSuperview().multipliedBy(0.3)
            }

            if !(element.valueUI is UITextField) {
                element.valueUI.isUserInteractionEnabled = false
//                    let tt = element.valueUI as! UITextField    
                
                
            } 
            
            element.valueUI.setContentHuggingPriority(.defaultLow, for: .horizontal)           
            element.valueUI.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

            element.valueUI.snp.makeConstraints { make in 	
                make.top.bottom.equalToSuperview()
                make.left.equalTo(l.snp.right).offset(24)
                make.right.equalToSuperview().inset(12)
            }
            
            return cell
        } else {
            cell.textLabel?.text = element.title
            cell.selectionStyle = .none
            // Fallback on earlier versions
        }
        
        return cell
    }
    
    override init(frame: CGRect, style: UITableView.Style) {    
        super.init(frame: frame, style: style)
        self.dataSource = nil
        
        self.layer.borderWidth = 1
        self.backgroundColor = .clear
        self.separatorColor = .clear
        
        self.register(UITableViewCell.self, forCellReuseIdentifier: "NameCell")
        self.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "sec")      
        
        self.delegate = self
         // Section
        customDataSource.titleForHeaderInSection = { datasource, index in
            return datasource.sectionModels[index].section
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(sections:[SectionOfSettingItem]) {
        self.init(frame: CGRect.zero, style: UITableView.Style.plain)
        
        // SetItems
        Observable.just(sections)
            .bind(to: self.rx.items(dataSource: customDataSource))
            .disposed(by: self.bag)
        
        // inputBind
        self.rx.modelSelected(SettingItem.self)
            .bind(to: self.settingTableViewVM.input.tapTableCell)
            .disposed(by: self.bag)
            
       
    }
}

extension SettingTableView:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
