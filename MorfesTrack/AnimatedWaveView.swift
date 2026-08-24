import UIKit

/// Continuously animated sine-wave — insert at index 0 of any card view.
final class AnimatedWaveView: UIView {

    private let backWave  = CAShapeLayer()
    private let frontWave = CAShapeLayer()
    private var phase: CGFloat = 0
    private var link: CADisplayLink?

    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = false
        clipsToBounds = true
        backWave.fillColor  = PawKit.forestMid.withAlphaComponent(0.28).cgColor
        frontWave.fillColor = PawKit.leaf.withAlphaComponent(0.13).cgColor
        layer.addSublayer(backWave)
        layer.addSublayer(frontWave)
        link = CADisplayLink(target: self, selector: #selector(tick))
        link?.add(to: .main, forMode: .common)
    }
    required init?(coder: NSCoder) { fatalError() }

    @objc private func tick() { phase += 0.022; setNeedsLayout() }

    override func layoutSubviews() {
        super.layoutSubviews()
        let b = bounds
        backWave.frame  = b
        frontWave.frame = b
        backWave.path  = wavePath(phase: phase + 1.4, amp: 10, yRatio: 0.55).cgPath
        frontWave.path = wavePath(phase: phase,       amp: 14, yRatio: 0.68).cgPath
    }

    private func wavePath(phase: CGFloat, amp: CGFloat, yRatio: CGFloat) -> UIBezierPath {
        let w = bounds.width, h = bounds.height, mid = h * yRatio
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: mid))
        stride(from: CGFloat(0), through: w, by: 3).forEach { x in
            path.addLine(to: CGPoint(x: x, y: mid + sin(x / w * .pi * 4 + phase) * amp))
        }
        path.addLine(to: CGPoint(x: w, y: h))
        path.addLine(to: CGPoint(x: 0, y: h))
        path.close()
        return path
    }

    deinit { link?.invalidate() }
}
