import SwiftUI
import SwiftUICharts

struct ContentView: View {
    @State private var diceData: [Double] = Array(repeating: 0, count: 11)
    @State private var totalRolls: Int = 0
    @State private var totalSum: Int = 0
    @State private var rollsPerSecond: Double = 1.0
    @State private var die1Value: Int = 1
    @State private var die2Value: Int = 1

    var currentMean: Double {
        totalRolls == 0 ? 0.0 : Double(totalSum) / Double(totalRolls)
    }
    
    var yAxisLabels: [String] {
        let maxVal = diceData.max() ?? 0
        guard maxVal > 0 else { return ["0", "", "", "", ""] }
        let step = (maxVal / 4).rounded(.up)
        return (0...4).map { "\(Int(Double($0) * step))" }
    }

    var meanColor: Color {
        totalRolls > 0 && abs(currentMean - 7.0) < 0.1 ? .green : .primary
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                header
                diceRow
                statsRow
                chartCard
                speedCard
                resetButton
            }
            .padding()
        }
        .background(
            LinearGradient(
                colors: [Color(.systemGroupedBackground), Color(.systemBackground)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
        .task(id: rollsPerSecond) {
            while !Task.isCancelled {
                let interval = (1.0 / rollsPerSecond) * 1_000_000_000
                try? await Task.sleep(nanoseconds: UInt64(interval))
                rollDice()
            }
        }
    }

    private var header: some View {
        VStack(spacing: 4) {
            Text("Law of Large Numbers")
                .font(.largeTitle)
                .fontWeight(.bold)
        }
        .frame(maxWidth: .infinity)
    }

    private var diceRow: some View {
        HStack(spacing: 24) {
            DieView(value: die1Value)
            DieView(value: die2Value)
        }
        .padding(.vertical, 4)
    }

    private var statsRow: some View {
        HStack(spacing: 12) {
            StatCard(title: "MEAN",
                     value: String(format: "%.3f", currentMean),
                     color: meanColor)
            StatCard(title: "ROLLS",
                     value: "\(totalRolls)",
                     color: .blue)
            StatCard(title: "LAST SUM",
                     value: "\(die1Value + die2Value)",
                     color: .purple)
        }
    }

    private var chartCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .firstTextBaseline) {
                Text("Distribution of Sums")
                    .font(.headline)
                Spacer()
                Text("Roll count per outcome")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            AxisLabels {
                ChartGrid {
                    BarChart()
                        .chartData(diceData)
                        .chartStyle(
                            ChartStyle(
                                backgroundColor: Color(.secondarySystemBackground),
                                foregroundColor: ColorGradient(.orange, .red)
                            )
                        )
                }
                .chartGridLines(horizontal: 5, vertical: 11)
            }
            .chartXAxisLabels(["2","3","4","5","6","7","8","9","10","11","12"])
            .chartYAxisLabels(yAxisLabels)
            .chartAxisColor(.secondary)
            .chartAxisFont(.caption2)
            .frame(height: 240)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemBackground))
        )
    }

    private var speedCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Label("Speed", systemImage: "speedometer")
                    .font(.headline)
                Spacer()
                Text("\(String(format: "%.1f", rollsPerSecond)) /sec")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .monospacedDigit()
            }
            Slider(value: $rollsPerSecond, in: 0.5...10.0, step: 0.5)
                .tint(.blue)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemBackground))
        )
    }

    private var resetButton: some View {
        Button {
            withAnimation {
                diceData = Array(repeating: 0, count: 11)
                totalRolls = 0
                totalSum = 0
                die1Value = 1
                die2Value = 1
            }
        } label: {
            Label("Reset", systemImage: "arrow.counterclockwise")
                .frame(maxWidth: .infinity)
                .padding(.vertical, 4)
        }
        .buttonStyle(.borderedProminent)
        .tint(.red)
        .controlSize(.large)
    }

    func rollDice() {
        let d1 = Int.random(in: 1...6)
        let d2 = Int.random(in: 1...6)
        let sum = d1 + d2

        die1Value = d1
        die2Value = d2
        diceData[sum - 2] += 1
        totalRolls += 1
        totalSum += sum
    }
}

struct DieView: View {
    let value: Int

    var body: some View {
        Image(systemName: "die.face.\(value).fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 80, height: 80)
            .foregroundStyle(.blue.gradient)
            .shadow(color: .blue.opacity(0.25), radius: 8, x: 0, y: 4)
            .contentTransition(.symbolEffect(.replace))
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let color: Color

    var body: some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.caption2)
                .foregroundStyle(.secondary)
                .tracking(0.5)
            Text(value)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(color)
                .monospacedDigit()
                .lineLimit(1)
                .minimumScaleFactor(0.6)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.secondarySystemBackground))
        )
    }
}

#Preview {
    ContentView()
}
