//
//  ViewController.swift
//  回调测试
//
//  Created by gaoang on 2025/3/31.
//

import UIKit

// 定义回调类型
typealias ButtonActionCallback = (_ button: UIButton) -> Void

class ViewController: UIViewController {
    
    // MARK: - 懒加载控件
    
    // 懒加载按钮
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("点击我", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    // 懒加载标签
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "等待按钮点击..."
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 回调属性
    private var buttonCallback: ButtonActionCallback?
    
    // MARK: - 生命周期
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCallback()
    }
    
    // MARK: - UI设置
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // 添加控件
        view.addSubview(actionButton)
        view.addSubview(statusLabel)
        
        // 布局约束
        NSLayoutConstraint.activate([
            actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            actionButton.widthAnchor.constraint(equalToConstant: 200),
            actionButton.heightAnchor.constraint(equalToConstant: 50),
            
            statusLabel.topAnchor.constraint(equalTo: actionButton.bottomAnchor, constant: 20),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    // MARK: - 回调设置
    
    private func setupCallback() {
        // 设置回调逻辑
        setButtonCallback { [weak self] button in
            guard let self = self else { return }
            
            // 回调执行的操作
            self.statusLabel.text = "按钮于 \(Date()) 被点击"
            
            // 可以访问按钮属性
            print("按钮标题: \(button.currentTitle ?? "")")
            
            // 模拟耗时操作
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.statusLabel.text = "操作完成"
            }
        }
    }
    
    // MARK: - 公开方法
    
    /// 设置按钮回调
    /// - Parameter callback: 回调闭包
    func setButtonCallback(_ callback: @escaping ButtonActionCallback) {
        self.buttonCallback = callback
    }
    
    // MARK: - 事件处理
    
    @objc private func buttonTapped(_ sender: UIButton) {
        // 触发回调
        buttonCallback?(sender) //传入一个按钮类型
        
        // 按钮点击动画
        UIView.animate(withDuration: 0.1, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                sender.transform = .identity
            }
        }
    }
}
