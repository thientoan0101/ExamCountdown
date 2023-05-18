//
//  CountdownViewController.swift
//  ExamCountdown
//
//  Created by Toan Thien on 16/05/2023.
//

import UIKit
import SnapKit

class CountdownViewController: UIViewController, UIPickerViewDelegate {
    let calendar = Calendar.current
    
    let deadlineDate: Date = {
        let date = UserDefaults.standard.value(forKey: "deadlineDate") as? Date
        return date ?? Date()
    }()
    
    let sloganLabel: UILabel = {
        let label = UILabel()
        label.text = "Cố gắng hết mình nhé."
        label.textColor = .black
        return label
    }()
    
    let ngaythiLabel: UILabel = {
        let label = UILabel()
        label.text = "ngày thi"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let conLabel: UILabel = {
        let label = UILabel()
        label.text = "Còn"
        label.textColor = .gray
        return label
    }()
    
    let ngayLabel: UILabel = {
        let label = UILabel()
        label.text = "ngày"
        label.textColor = .gray
        return label
    }()
    
    let remainLabel: UILabel = {
        let label = UILabel()
        label.text = "56"
        label.font = UIFont.systemFont(ofSize: 200)
        label.textColor = UIColor(hex: "#FF0081C9")
        return label
    }()
    
    let deadlineLabel: UILabel = {
        let label = UILabel()
        label.text = "24/12/2023"
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .inline
        picker.backgroundColor = UIColor(hex: "0xFFAEE2FF")
        picker.datePickerMode = UIDatePicker.Mode.date
        picker.layer.cornerRadius = 16
        picker.layer.masksToBounds = true
        picker.minimumDate = Date()
        let maximumDate = Calendar.current.date(byAdding: .year, value: 2, to: Date())
        picker.maximumDate = maximumDate
        picker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)

        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
//        title = "Đếm ngược ngày thi"
        navigationItem.title = "Đếm ngược ngày thi"
        setupView()
        setupLayout()
        setupDeadline()
    }
    
    private func setupDeadline() {
        let numberDay: Int?
        let targetDate = UserDefaults.standard.value(forKey: "deadlineDate") as? Date
        if let dt = targetDate {
            numberDay = calculateDistanceDay(Date(), dt)
        } else {
            numberDay = 0
        }
        DispatchQueue.main.async {
            self.remainLabel.text = "\(numberDay ?? 0)"
        }
    }
    
    private func calculateDistanceDay(_ fromDate: Date, _ toDate: Date) -> Int? {
        let numberOfDays = Calendar.current.dateComponents([.day], from: fromDate, to: toDate).day
        return numberOfDays
    }
    
    private func setupView() {
        view.addSubview(sloganLabel)
        view.addSubview(remainLabel)
        view.addSubview(conLabel)
        view.addSubview(ngayLabel)
        view.addSubview(deadlineLabel)
        view.addSubview(datePicker)
        view.addSubview(ngaythiLabel)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium

        let initialDate = Date() // Set the initial date to the current date or any other date as desired
        let formattedDate = dateFormatter.string(from: initialDate)
        
        deadlineLabel.text = formattedDate
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(chooseDeadlineDate))
        deadlineLabel.isUserInteractionEnabled = true
        deadlineLabel.addGestureRecognizer(tapGesture)
    }
    
    private func setupLayout() {
        sloganLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.centerX.equalToSuperview()
        }
        
        remainLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        conLabel.snp.makeConstraints { make in
            make.bottom.equalTo(remainLabel.snp.top).offset(30)
            make.centerX.equalToSuperview()
        }
        
        ngayLabel.snp.makeConstraints { make in
            make.top.equalTo(remainLabel.snp.bottom).offset(-30)
            make.centerX.equalToSuperview()
        }
        
        deadlineLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-150)
        }
        
        ngaythiLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(deadlineLabel.snp.top).offset(-10)
        }
        
        datePicker.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.bottom)
            make.height.equalTo(111)
            make.width.equalTo(115)
        }
    }
    
    @objc private func chooseDeadlineDate() {
        UIView.animate(withDuration: 1) { [weak self] in
            guard let wSelf = self else { return }
            DispatchQueue.main.async {
                wSelf.datePicker.snp.removeConstraints()
                wSelf.datePicker.snp.makeConstraints { make in
                    make.centerX.equalToSuperview()
                    make.centerY.equalToSuperview()
                    make.height.equalTo(350)
                    make.width.equalTo(320)
                }
//                wSelf.viewDidLayoutSubviews()
            }
            
        }

        
        
    }
    
    @objc private func datePickerValueChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        let selectedDate = sender.date
        UserDefaults.standard.setValue(selectedDate, forKey: "deadlineDate")
        UserDefaults.standard.synchronize()
        let formattedDate = dateFormatter.string(from: selectedDate)
        
        deadlineLabel.text = formattedDate
        UIView.animate(withDuration: 1) { [weak self] in
            guard let wSelf = self else { return }
            DispatchQueue.main.async {
                wSelf.datePicker.snp.removeConstraints()
                wSelf.datePicker.snp.makeConstraints { make in
                    make.centerX.equalToSuperview()
                    make.top.equalTo(wSelf.view.snp.bottom)
                    make.height.equalTo(350)
                    make.width.equalTo(320)
                }
                let numberOfDays = wSelf.calendar.dateComponents([.day], from: Date(), to: selectedDate).day
                if let numDay = numberOfDays {
                    wSelf.remainLabel.text = "\(String(describing: numDay))"
                }
                wSelf.viewDidLayoutSubviews()
            }
            
        }
        
    }


}
